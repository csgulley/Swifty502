//
//  SED.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

struct SED: ImpliedMode {
    static var opcode: UInt8 = 0xf8
    static var mnemonic = "SED"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Decimal] = true
    }
}
