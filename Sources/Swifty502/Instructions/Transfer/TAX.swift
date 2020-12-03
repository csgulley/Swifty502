//
//  TAX.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

struct TAX: ImpliedMode {
    static var opcode: UInt8 = 0xaa
    static var mnemonic = "TAX"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.x = registers.a
        registers.status.updateFlags(registers.x, .Zero, .Negative)
    }
}
