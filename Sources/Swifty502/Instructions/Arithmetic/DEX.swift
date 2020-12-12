//
//  DEX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

public struct DEX: ImpliedMode {
    public static var opcode: UInt8 = 0xca
    public static var mnemonic = "DEX"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int{
        registers.x &-= 1
        registers.status.updateFlags(registers.x, .Zero, .Negative)
        return 2
    }
}
