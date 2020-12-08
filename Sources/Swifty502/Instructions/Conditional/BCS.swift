//
//  BCS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct BCS: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0xb0
    public static var mnemonic = "BCS"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Carry]
    }
}
