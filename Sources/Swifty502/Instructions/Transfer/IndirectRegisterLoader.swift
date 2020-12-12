//
//  IndirectRegisterLoader.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

protocol IndirectRegisterLoader: RegisterLoader {
}

extension IndirectRegisterLoader {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        let value = memory[operand]
        setValue(value: value, registers: registers)
        updateFlags(value: value, status: registers.status)
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack) + (crossedPageBoundary ? 1 : 0)
    }
}
