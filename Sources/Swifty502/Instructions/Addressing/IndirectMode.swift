//
//  IndirectMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public protocol IndirectMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int
}

extension IndirectMode {
    public static var addressMode: AddressMode {
        .Indirect
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        let operand = executor.nextWord(registers)
        return execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
