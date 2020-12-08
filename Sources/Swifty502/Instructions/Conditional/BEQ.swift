//
//  BEQ.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public struct BEQ: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0xf0
    public static var mnemonic = "BEQ"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Zero]
    }
}
