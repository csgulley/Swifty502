//
//  DEX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

struct DEX: ImpliedMode {
    static var opcode: UInt8 = 0xca
    static var mnemonic = "DEX"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.x &-= 1
        registers.status.updateFlags(registers.x, .Zero, .Negative)
    }
}
