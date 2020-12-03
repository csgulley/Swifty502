//
//  IndirectYMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

protocol IndirectYMode: Instruction {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack)
}

extension IndirectYMode {
    static var addressMode: AddressMode {
        .IndirectY
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let indirect = UInt16(executor.nextByte(registers))
        let operand = memory.readWord(indirect) + UInt16(registers.y)
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}
