//
//  BCC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

struct BCC: RelativeMode, Conditional {
    static var opcode: UInt8 = 0x90
    static var mnemonic = "BCS"

    static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Carry]
    }
}
