//
//  BVS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct BVS: RelativeMode, Conditional {
    static var opcode: UInt8 = 0x70
    static var mnemonic = "BVS"

    static func shouldBranch(registers: Registers) -> Bool {
        registers.status[.Overflow]
    }
}

