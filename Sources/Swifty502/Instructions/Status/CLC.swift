//
//  CLC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

struct CLC: ImpliedMode {
    static var opcode: UInt8 = 0x18
    static var mnemonic = "CLC"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Carry] = false
    }
}
