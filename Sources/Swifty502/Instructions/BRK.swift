//
//  Brk.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

struct BRK: ImpliedMode {
    static var opcode: UInt8 = 0x00
    static var mnemonic = "BRK"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        stack.pushWord(registers.pc + 1)
        stack.pushByte(registers.status.statusByte)
        registers.status[.Interrupt] = true
        registers.pc = memory.readWord(0xfffe)
    }
}
