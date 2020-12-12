//
//  INY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public struct INY: ImpliedMode {
    public static var opcode: UInt8 = 0xc8
    public static var mnemonic = "INY"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.y &+= 1
        registers.status.updateFlags(registers.y, .Zero, .Negative)
        return 2
    }
}
