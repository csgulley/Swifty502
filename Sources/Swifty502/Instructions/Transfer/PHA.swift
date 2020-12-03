//
//  PHA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

struct PHA: ImpliedMode {
    static var opcode: UInt8 = 0x48
    static var mnemonic = "PHA"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        stack.pushByte(registers.a)
    }
}
