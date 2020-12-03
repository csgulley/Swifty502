//
//  TXS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

struct TXS: ImpliedMode {
    static var opcode: UInt8 = 0x9a
    static var mnemonic = "TXS"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.sp = registers.x
    }
}
