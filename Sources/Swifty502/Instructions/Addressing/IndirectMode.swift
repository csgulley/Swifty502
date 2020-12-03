//
//  IndirectMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol IndirectMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension IndirectMode {
    static var addressMode: AddressMode {
        .Indirect
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = executor.nextWord(registers)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
