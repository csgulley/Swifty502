//
//  PLA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

public struct PLA: ImpliedMode {
    public static var opcode: UInt8 = 0x68
    public static var mnemonic = "PLA"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.a = stack.popByte()
        registers.status.updateFlags(registers.a, .Negative, .Zero)
        return 4
    }
}
