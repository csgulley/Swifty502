//
//  Processor.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

import Foundation
import Atomics

final public class Processor {
    // Run frequently enough for 60 fps display
    private static let QuantumInterval = 1.0 / 60
    
    // How many cycles we'd get per quantum interval running at 1 MHz
    private static let QuantumCycles = Int(1_000_000.0 * QuantumInterval)
    
    public struct UnknownInstruction: Error {
        public let address: UInt16
        public let opcode: UInt8
    }

    public var a: UInt8 { registers.a }
    public var x: UInt8 { registers.x }
    public var y: UInt8 { registers.y }
    public var sp: UInt8 { registers.sp }
    public var pc: UInt16 { registers.pc }
    public var memory: Memory { _memory }
    public let status: ProcessorStatus

    // When true we try to emulate a 1Mhz clock. When false instructions are executed
    // as fast as possible
    public var throttleExecution = true
    
    // Called when BRK encountered. Return true to stop execution.
    public var brkHandler: ((_ address: UInt16, _ processor: Processor) -> Bool)?
    
    /**
     Set true for for active. Will not be automatically reset.
     */
    public var irq: Bool {
        get { interruptRequested.load(ordering: .relaxed) }
        set(newValue) { interruptRequested.store(newValue, ordering: .relaxed) }
    }
    
    private let registers = Registers()
    private let _memory: Memory
    private var instructions = [Instruction.Type?](repeating: nil, count: 256)
    private let stack: Stack
    private var interceptors = [InstructionInterceptor]()
    private let executor: Executor
    private var resetRequested = ManagedAtomic<Bool>(false)
    private var interruptRequested = ManagedAtomic<Bool>(false)
    private var nonMaskableInterruptRequested = ManagedAtomic<Bool>(false)
    private var quantumStart: TimeInterval = 0

    public init(memory: Memory, instructions: InstructionSet.Type? = Instructions6502.self) {
        _memory = memory
        executor = Executor(memory: _memory, registers: registers)
        stack = Stack(memory: _memory, registers: registers)

        // Read only view of status
        class ReadOnlyStatus: ProcessorStatus {
            private let register: StatusRegister

            init(_ r: StatusRegister) {
                register = r
            }

            subscript(index: StatusFlag) -> Bool {
                register[index]
            }
        }

        status = ReadOnlyStatus(registers.status)
        instructions?.instructions.forEach { addInstruction($0) }
    }

    public func addInstruction(_ i: Instruction.Type) {
        instructions[Int(i.opcode)] = i
    }

    public func addDebugInterceptor(_ i: InstructionInterceptor) {
        interceptors.append(i)
    }

    /*
     A reset request is stored until the processor can handle it and then automatically cleared.
     */
    public func reset() {
        resetRequested.store(true, ordering: .relaxed)
    }
    
    public func nonMaskableInterrupt() {
        nonMaskableInterruptRequested.store(true, ordering: .relaxed)
    }

    private func handleReset() {
        registers.status[.InterruptDisable] = true
        registers.pc = memory.readWord(0xfffc)
        resetRequested.store(false, ordering: .relaxed)
    }

    private func handleInterrupt() {
        stack.pushWord(registers.pc)
        stack.pushByte(registers.status.statusByte & 0xef)
        registers.status[.InterruptDisable] = true
        registers.pc = memory.readWord(0xfffe)
    }
    
    private func handleNonMaskableInterrupt() {
        stack.pushWord(registers.pc)
        stack.pushByte(registers.status.statusByte & 0xef)
        registers.status[.InterruptDisable] = true
        registers.pc = memory.readWord(0xfffa)
        nonMaskableInterruptRequested.store(false, ordering: .relaxed)
    }

    private func throttle() {
        let now = ProcessInfo.processInfo.systemUptime
        let duration = now - quantumStart
        let remaining = Processor.QuantumInterval  - duration
        if remaining > 0 {
            quantumStart = now + remaining
            Thread.sleep(forTimeInterval: remaining)
        } else {
            quantumStart = ProcessInfo.processInfo.systemUptime
        }
    }

    public func start() throws {
        var cycles = 0
        quantumStart = ProcessInfo.processInfo.systemUptime
        registers.pc = memory.readWord(0xfffc)
        while (true) {
            if resetRequested.load(ordering: .relaxed) {
                handleReset()
            }
            
            if nonMaskableInterruptRequested.load(ordering: .relaxed) {
                handleNonMaskableInterrupt()
            }

            if !registers.status[.InterruptDisable] && interruptRequested.load(ordering: .relaxed) {
                handleInterrupt()
            }

            let opcode = executor.nextByte(registers)
            guard let instruction = instructions[Int(opcode)] else {
                throw UnknownInstruction(address: registers.pc - 1, opcode: opcode)
            }

            interceptors.forEach {
                $0.onInstruction(address: registers.pc - 1, instruction: instruction, processor: self)
            }

            if opcode == BRK.opcode && brkHandler?(registers.pc - 1, self) ?? false {
                return
            }

            cycles += instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
            if (cycles >= Processor.QuantumCycles) {
                if throttleExecution { throttle() }
                cycles = 0
            }
        }
    }
}
