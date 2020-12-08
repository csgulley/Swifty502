//
//  BCC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

public struct BCC: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0x90
    public static var mnemonic = "BCS"

    public static func shouldBranch(registers: Registers) -> Bool {
        !registers.status[.Carry]
    }
}
