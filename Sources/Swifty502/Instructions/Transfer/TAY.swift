//
//  TAY.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

public struct TAY: ImpliedMode {
    public static var opcode: UInt8 = 0xa8
    public static var mnemonic = "TAY"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.y = registers.a
        registers.status.updateFlags(registers.y, .Zero, .Negative)
    }
}
