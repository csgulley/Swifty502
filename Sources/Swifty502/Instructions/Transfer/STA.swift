//
//  LDA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol AStoreOperator {
}

extension AStoreOperator {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = registers.a
    }
}

public struct STA {
    public struct ZeroPage: ZeroPageMode, AStoreOperator {
        public static var opcode: UInt8 = 0x85
        public static var mnemonic = "STA"
    }

    public struct ZeroPageX: ZeroPageXMode, AStoreOperator {
        public static var opcode: UInt8 = 0x95
        public static var mnemonic = "STA"
    }

    public struct Absolute: AbsoluteMode, AStoreOperator {
        public static var opcode: UInt8 = 0x8d
        public static var mnemonic = "STA"
    }

    public struct AbsoluteX: AbsoluteXMode, AStoreOperator {
        public static var opcode: UInt8 = 0x9d
        public static var mnemonic = "STA"
    }

    public struct AbsoluteY: AbsoluteYMode, AStoreOperator {
        public static var opcode: UInt8 = 0x99
        public static var mnemonic = "STA"
    }

    public struct IndirectX: IndirectXMode, AStoreOperator {
        public static var opcode: UInt8 = 0x81
        public static var mnemonic = "STA"
    }

    public struct IndirectY: IndirectYMode, AStoreOperator {
        public static var opcode: UInt8 = 0x91
        public static var mnemonic = "STA"
    }
}
