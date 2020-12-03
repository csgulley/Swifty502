//
//  File.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

struct DEY: ImpliedMode {
    static var opcode: UInt8 = 0x88
    static var mnemonic = "DEY"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.y &-= 1
        registers.status.updateFlags(registers.y, .Zero, .Negative)
    }
}
