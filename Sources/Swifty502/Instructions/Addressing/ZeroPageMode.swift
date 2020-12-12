//
//  ZeroPageMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol ZeroPageMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int
}

extension ZeroPageMode {
    public static var addressMode: AddressMode {
        .ZeroPage
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        let operand = UInt16(executor.nextByte(registers))
        return execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
