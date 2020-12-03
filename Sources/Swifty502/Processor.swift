//
//  Processor.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

import Foundation

public class Processor {
    public struct UnknownInstruction: Error {
        public let address: UInt16
        public let opcode: UInt8
    }

    private let registers = Registers()
    private let _memory: Memory
    private var instructions = [Instruction.Type?](repeating: nil, count: 256)
    private let stack: Stack
    private var interceptors = [InstructionInterceptor]()
    private let executor: Executor
    private var doReset = false

    public init(memory: Memory) {
        _memory = memory
        executor = Executor(memory: _memory, registers: registers)
        stack = Stack(memory: _memory, registers: registers)

        // Read only view of status
        class ReadOnlyStatus: ProcessorStatus {
            private let register: StatusRegister

            init(_ r: StatusRegister) {
                register = r
            }

            subscript(index: ProcessorFlag) -> Bool {
                register[index]
            }
        }

        status = ReadOnlyStatus(registers.status)
        InstructionSet.addInstructions(processor: self)
    }

    public var a: UInt8 {
        registers.a
    }

    public var x: UInt8 {
        registers.x
    }

    public var y: UInt8 {
        registers.y
    }

    public var pc: UInt16 {
        registers.pc
    }

    public var sp: UInt8 {
        registers.sp
    }

    public var memory: Memory {
        _memory
    }

    public let status: ProcessorStatus

    public func addInstruction(_ i: Instruction.Type) {
        instructions[Int(i.opcode)] = i
    }

    public func addDebugInterceptor(_ i: InstructionInterceptor) {
        interceptors.append(i)
    }

    public func execute(start: UInt16) throws {
        registers.pc = start
        try execute()
    }

    public func reset() {
        doReset = true
    }

    private func handleReset() {
        registers.status[.Interrupt] = true
        registers.pc = memory.readWord(0xfffc)
        doReset = false
    }

    private func execute() throws {
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

            // Comment out to run 502_functional_test until we come up with a better scheme
//            if (opcode == BRK.opcode) {
//                return
//            }

            instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        }
    }
}
