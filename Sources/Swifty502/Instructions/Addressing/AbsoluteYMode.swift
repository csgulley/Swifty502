//
//  AbsoluteYMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

protocol AbsoluteYMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension AbsoluteYMode {
    static var addressMode: AddressMode {
        .AbsoluteY
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = executor.nextWord(registers) + UInt16(registers.y)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
