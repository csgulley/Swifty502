//
//  RTI.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

struct RTI: ImpliedMode {
    static var opcode: UInt8 = 0x40
    static var mnemonic = "RTI"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status.statusByte = stack.popByte()
        registers.pc = stack.popWord()
    }
}
