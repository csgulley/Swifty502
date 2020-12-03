//
//  BEQ.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

struct BEQ: RelativeMode, Conditional {
    static var opcode: UInt8 = 0xf0
    static var mnemonic = "BEQ"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Zero]
    }
}
