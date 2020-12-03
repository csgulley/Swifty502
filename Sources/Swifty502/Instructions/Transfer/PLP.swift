//
//  PLP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct PLP: ImpliedMode {
    static var opcode: UInt8 = 0x28
    static var mnemonic = "PLP"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status.statusByte = stack.popByte()
    }
}
