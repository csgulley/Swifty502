//
//  BMI.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct BMI: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0x30
    public static var mnemonic = "BMI"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Negative]
    }
}
