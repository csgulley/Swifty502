//
//  JMP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

struct JMP {
    struct Absolute: AbsoluteMode {
        static var opcode: UInt8 = 0x4c
        static var mnemonic = "JMP"

        static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
            registers.pc = operand
        }
    }

    struct Indirect: IndirectMode {
        static var opcode: UInt8 = 0x6c
        static var mnemonic = "JMP"

        static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
            registers.pc = memory.readWord(operand)
        }
    }
}
