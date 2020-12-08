//
//  BNE.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public struct BNE: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0xd0
    public static var mnemonic = "BNE"

    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Zero]
    }
}
