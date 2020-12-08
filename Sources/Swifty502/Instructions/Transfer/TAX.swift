//
//  TAX.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

public struct TAX: ImpliedMode {
    public static var opcode: UInt8 = 0xaa
    public static var mnemonic = "TAX"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.x = registers.a
        registers.status.updateFlags(registers.x, .Zero, .Negative)
    }
}
