//
//  PLP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct PLP: ImpliedMode {
    public static var opcode: UInt8 = 0x28
    public static var mnemonic = "PLP"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status.statusByte = stack.popByte()
    }
}
