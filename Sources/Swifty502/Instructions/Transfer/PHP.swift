//
//  PHP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct PHP: ImpliedMode {
    static var opcode: UInt8 = 0x08
    static var mnemonic = "PHP"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        stack.pushByte(registers.status.statusByte)
    }
}
