//
//  SED.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

public struct SED: ImpliedMode {
    public static var opcode: UInt8 = 0xf8
    public static var mnemonic = "SED"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Decimal] = true
    }
}
