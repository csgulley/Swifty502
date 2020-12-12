//
//  JMP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct JMP {
    public struct Absolute: AbsoluteMode {
        public static var opcode: UInt8 = 0x4c
        public static var mnemonic = "JMP"

        public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
            registers.pc = operand
            return 3
        }
    }

    public struct Indirect: IndirectMode {
        public static var opcode: UInt8 = 0x6c
        public static var mnemonic = "JMP"

        public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
            registers.pc = memory.readWord(operand)
            return 5
        }
    }
}
