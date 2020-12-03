//
//  RTS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

struct RTS: ImpliedMode {
    static var opcode: UInt8 = 0x60
    static var mnemonic = "RTS"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let address = stack.popWord()
        registers.pc = address + 1
    }
}
