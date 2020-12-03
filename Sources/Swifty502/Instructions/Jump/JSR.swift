//
//  JSR.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

struct JSR: AbsoluteMode {
    static var opcode: UInt8 = 0x20
    static var mnemonic = "JSR"

    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        stack.pushWord(registers.pc - 1)
        registers.pc = operand
    }
}

