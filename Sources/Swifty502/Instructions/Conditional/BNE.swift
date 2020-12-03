//
//  BNE.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

struct BNE: RelativeMode, Conditional {
    static var opcode: UInt8 = 0xd0
    static var mnemonic = "BNE"

    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Zero]
    }
}
