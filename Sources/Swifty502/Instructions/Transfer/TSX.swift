//
//  TSX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct TSX: ImpliedMode {
    static var opcode: UInt8 = 0xba
    static var mnemonic = "TSX"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.x = registers.sp
        registers.status.updateFlags(registers.x, .Zero, .Negative)
    }
}

