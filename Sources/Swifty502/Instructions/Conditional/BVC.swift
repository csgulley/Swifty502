//
//  BVC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct BVC: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0x50
    public static var mnemonic = "BVC"

    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Overflow]
    }
}
