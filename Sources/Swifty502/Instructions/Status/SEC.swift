//
//  SEC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct SEC: ImpliedMode {
    public static var opcode: UInt8 = 0x38
    public static var mnemonic = "SEC"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.status[.Carry] = true
        return 2
    }
}
