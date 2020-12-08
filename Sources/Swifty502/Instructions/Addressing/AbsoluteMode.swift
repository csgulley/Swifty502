//
//  AbsoluteMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol AbsoluteMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension AbsoluteMode {
    public static var addressMode: AddressMode {
        .Absolute
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = executor.nextWord(registers)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
