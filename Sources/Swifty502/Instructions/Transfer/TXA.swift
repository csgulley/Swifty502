//
//  TXA.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

struct TXA: ImpliedMode {
    static var opcode: UInt8 = 0x8a
    static var mnemonic = "TXA"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = registers.x
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}
