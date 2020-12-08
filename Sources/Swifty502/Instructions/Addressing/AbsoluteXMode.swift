//
//  AbsoluteXMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol AbsoluteXMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension AbsoluteXMode {
    public static var addressMode: AddressMode {
        .AbsoluteX
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = executor.nextWord(registers) + UInt16(registers.x)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
