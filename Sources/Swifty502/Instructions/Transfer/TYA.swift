//
//  TYA.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

public struct TYA: ImpliedMode {
    public static var opcode: UInt8 = 0x98
    public static var mnemonic = "TYA"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = registers.y
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}
