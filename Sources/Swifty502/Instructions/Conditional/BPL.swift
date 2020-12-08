//
//  BPL.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public struct BPL: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0x10
    public static var mnemonic = "BPL"
    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Negative]
    }
}
