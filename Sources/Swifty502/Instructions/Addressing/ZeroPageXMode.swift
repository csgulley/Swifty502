//
//  ZeroPageXMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

protocol ZeroPageXMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension ZeroPageXMode {
    static var addressMode: AddressMode {
        .ZeroPageX
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let raw = UInt16(executor.nextByte(registers)) + UInt16(registers.x)
        let operand = raw & 0xff
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
