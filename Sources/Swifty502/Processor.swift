//
//  Processor.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

import Foundation

final public class Processor {
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
    
    // Called when BRK encountered. Return true to stop execution.
    public var brkHandler: ((_ address: UInt16, _ processor: Processor) -> Bool)?
    
    private let registers = Registers()
    private let _memory: Memory
    private var instructions = [Instruction.Type?](repeating: nil, count: 256)
    private let stack: Stack
    private var interceptors = [InstructionInterceptor]()
    private let executor: Executor
    private var doReset = false

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

    public func reset() {
        doReset = true
    }

    private func handleReset() {
        registers.status[.InterruptDisable] = true
        registers.pc = memory.readWord(0xfffc)
        doReset = false
    }

    public func start() throws {
        registers.pc = memory.readWord(0xfffc)
        while (true) {
            if doReset {
                handleReset()
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

            instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        }
    }
}
