//
//  Executor.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public class Executor {
    private let registers: Registers
    private let memory: Memory

    init(memory: Memory, registers: Registers) {
        self.memory = memory
        self.registers = registers
    }

    public func nextByte(_ registers: Registers) -> UInt8 {
        registers.pc += 1
        return memory[registers.pc - 1]
    }

    public func nextWord(_ registers: Registers) -> UInt16 {
        registers.pc += 2
        return memory.readWord(registers.pc - 2)
    }
}
