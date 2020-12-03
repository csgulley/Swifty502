//
//  AbsoluteMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

protocol AbsoluteMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension AbsoluteMode {
    static var addressMode: AddressMode {
        .Absolute
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = executor.nextWord(registers)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
