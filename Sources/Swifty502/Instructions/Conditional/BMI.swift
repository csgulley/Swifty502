//
//  BMI.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct BMI: RelativeMode, Conditional {
    static var opcode: UInt8 = 0x30
    static var mnemonic = "BMI"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Negative]
    }
}
