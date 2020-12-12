//
//  TSX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

public struct TSX: ImpliedMode {
    public static var opcode: UInt8 = 0xba
    public static var mnemonic = "TSX"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.x = registers.sp
        registers.status.updateFlags(registers.x, .Zero, .Negative)
        return 2
    }
}

