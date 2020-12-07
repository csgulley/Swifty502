//
//  CLI.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

struct CLI: ImpliedMode {
    static var opcode: UInt8 = 0x58
    static var mnemonic = "CLI"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.InterruptDisable] = false
    }
}
