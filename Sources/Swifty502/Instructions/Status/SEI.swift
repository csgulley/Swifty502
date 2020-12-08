//
//  SEI.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct SEI: ImpliedMode {
    public static var opcode: UInt8 = 0x78
    public static var mnemonic = "SEI"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.InterruptDisable] = true
    }
}
