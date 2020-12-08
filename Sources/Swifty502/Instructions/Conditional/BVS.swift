//
//  BVS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct BVS: RelativeMode, Conditional {
    public static var opcode: UInt8 = 0x70
    public static var mnemonic = "BVS"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Overflow]
    }
}

