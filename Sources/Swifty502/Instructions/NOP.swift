//
//  NOP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct NOP: ImpliedMode {
    static var opcode: UInt8 = 0xea
    static var mnemonic = "NOP"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
    }
}
