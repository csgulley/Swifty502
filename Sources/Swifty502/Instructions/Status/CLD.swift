//
//  CLD.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct CLD: ImpliedMode {
    static var opcode: UInt8 = 0xD8
    static var mnemonic = "CLD"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Decimal] = false
    }
}
