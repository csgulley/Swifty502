//
//  JSR.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

public struct JSR: AbsoluteMode {
    public static var opcode: UInt8 = 0x20
    public static var mnemonic = "JSR"

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        stack.pushWord(registers.pc - 1)
        registers.pc = operand
    }
}

