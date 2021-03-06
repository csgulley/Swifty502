//
//  IndirectXMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol IndirectXMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int
}

extension IndirectXMode {
    public static var addressMode: AddressMode {
        .IndirectX
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        let indirect = UInt16(executor.nextByte(registers) &+ registers.x)
        let operand = memory.readWord(UInt16(indirect))
        return execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
