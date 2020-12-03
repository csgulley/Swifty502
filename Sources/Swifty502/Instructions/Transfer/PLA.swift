//
//  PLA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

struct PLA: ImpliedMode {
    static var opcode: UInt8 = 0x68
    static var mnemonic = "PLA"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = stack.popByte()
        registers.status.updateFlags(registers.a, .Negative, .Zero)
    }
}
