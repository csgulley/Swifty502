//
//  TYA.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

struct TYA: ImpliedMode {
    static var opcode: UInt8 = 0x98
    static var mnemonic = "TYA"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = registers.y
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}
