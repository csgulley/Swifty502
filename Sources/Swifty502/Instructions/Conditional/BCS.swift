//
//  BCS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct BCS: RelativeMode, Conditional {
    static var opcode: UInt8 = 0xb0
    static var mnemonic = "BCS"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Carry]
    }
}
