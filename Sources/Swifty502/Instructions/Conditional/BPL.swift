//
//  BPL.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

struct BPL: RelativeMode, Conditional {
    static var opcode: UInt8 = 0x10
    static var mnemonic = "BPL"
    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Negative]
    }
}
