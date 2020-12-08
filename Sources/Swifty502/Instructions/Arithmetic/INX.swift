//
//  INX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public struct INX: ImpliedMode {
    public static var opcode: UInt8 = 0xe8
    public static var mnemonic = "INX"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.x &+= 1
        registers.status.updateFlags(registers.x, .Zero, .Negative)
    }
}
