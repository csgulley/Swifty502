//
//  TXS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct TXS: ImpliedMode {
    public static var opcode: UInt8 = 0x9a
    public static var mnemonic = "TXS"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.sp = registers.x
    }
}
