//
//  Immediate.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol ImmediateMode: Instruction {
    static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack)
}

extension ImmediateMode {
    public static var addressMode: AddressMode {
        .Immediate
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = executor.nextByte(registers)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
