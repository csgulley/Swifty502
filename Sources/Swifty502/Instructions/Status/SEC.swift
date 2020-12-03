//
//  SEC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct SEC: ImpliedMode {
    static var opcode: UInt8 = 0x38
    static var mnemonic = "SEC"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Carry] = true
    }
}
