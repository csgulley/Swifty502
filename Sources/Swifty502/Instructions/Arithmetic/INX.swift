//
//  INX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

struct INX: ImpliedMode {
    static var opcode: UInt8 = 0xe8
    static var mnemonic = "INX"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.x &+= 1
        registers.status.updateFlags(registers.x, .Zero, .Negative)
    }
}
