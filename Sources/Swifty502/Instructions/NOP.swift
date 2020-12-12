//
//  NOP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct NOP: ImpliedMode {
    public static var opcode: UInt8 = 0xea
    public static var mnemonic = "NOP"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int { 2 }
}
