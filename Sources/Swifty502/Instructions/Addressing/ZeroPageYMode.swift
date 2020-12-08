//
//  ZeroPageYMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol ZeroPageYMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension ZeroPageYMode {
    public static var addressMode: AddressMode {
        .ZeroPageY
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let raw = UInt16(executor.nextByte(registers)) + UInt16(registers.y)
        let operand = raw & 0xff
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}

