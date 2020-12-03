//
//  ZeroPageMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

protocol ZeroPageMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension ZeroPageMode {
    static var addressMode: AddressMode {
        .ZeroPage
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let operand = UInt16(executor.nextByte(registers))
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
