//
//  BVC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct BVC: RelativeMode, Conditional {
    static var opcode: UInt8 = 0x50
    static var mnemonic = "BVC"

    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Overflow]
    }
}
