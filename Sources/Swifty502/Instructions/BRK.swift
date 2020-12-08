//
//  Brk.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

public struct BRK: ImpliedMode {
    public static var opcode: UInt8 = 0x00
    public static var mnemonic = "BRK"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        stack.pushWord(registers.pc + 1)
        stack.pushByte(registers.status.statusByte)
        registers.status[.InterruptDisable] = true
        registers.pc = memory.readWord(0xfffe)
    }
}
