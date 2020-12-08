//
//  CLD.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct CLD: ImpliedMode {
    public static var opcode: UInt8 = 0xD8
    public static var mnemonic = "CLD"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Decimal] = false
    }
}
