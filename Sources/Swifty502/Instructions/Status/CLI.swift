//
//  CLI.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

public struct CLI: ImpliedMode {
    public static var opcode: UInt8 = 0x58
    public static var mnemonic = "CLI"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.InterruptDisable] = false
    }
}
