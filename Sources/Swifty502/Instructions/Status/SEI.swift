//
//  SEI.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct SEI: ImpliedMode {
    static var opcode: UInt8 = 0x78
    static var mnemonic = "SEI"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status[.Interrupt] = true
    }
}
