//
//  TXA.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

public struct TXA: ImpliedMode {
    public static var opcode: UInt8 = 0x8a
    public static var mnemonic = "TXA"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = registers.x
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}
