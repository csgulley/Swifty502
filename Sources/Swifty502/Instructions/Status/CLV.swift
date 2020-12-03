//
//  CLV.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct CLV: ImpliedMode {
    static var opcode: UInt8 = 0xb8
    static var mnemonic = "CLV"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Overflow] = false
    }
}
