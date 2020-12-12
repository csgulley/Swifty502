//
//  AbsoluteYMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public protocol AbsoluteYMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int
}

extension AbsoluteYMode {
    public static var addressMode: AddressMode {
        .AbsoluteY
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        let base = executor.nextWord(registers)
        let operand = base + UInt16(registers.y)
        let crossedPageBoundary = (base & 0xff00) != (operand & 0xff00)
        return execute(operand: operand, memory: memory, registers: registers, stack: stack, crossedPageBoundary: crossedPageBoundary)
    }
}
