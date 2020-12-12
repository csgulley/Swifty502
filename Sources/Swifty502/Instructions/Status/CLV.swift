//
//  CLV.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct CLV: ImpliedMode {
    public static var opcode: UInt8 = 0xb8
    public static var mnemonic = "CLV"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.status[.Overflow] = false
        return 2
    }
}
