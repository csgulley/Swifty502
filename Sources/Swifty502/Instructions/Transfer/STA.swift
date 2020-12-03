//
//  LDA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol AStoreOperator {
}

extension AStoreOperator {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = registers.a
    }
}

struct STA {
    struct ZeroPage: ZeroPageMode, AStoreOperator {
        static var opcode: UInt8 = 0x85
        static var mnemonic = "STA"
    }

    struct ZeroPageX: ZeroPageXMode, AStoreOperator {
        static var opcode: UInt8 = 0x95
        static var mnemonic = "STA"
    }

    struct Absolute: AbsoluteMode, AStoreOperator {
        static var opcode: UInt8 = 0x8d
        static var mnemonic = "STA"
    }

    struct AbsoluteX: AbsoluteXMode, AStoreOperator {
        static var opcode: UInt8 = 0x9d
        static var mnemonic = "STA"
    }

    struct AbsoluteY: AbsoluteYMode, AStoreOperator {
        static var opcode: UInt8 = 0x99
        static var mnemonic = "STA"
    }

    struct IndirectX: IndirectXMode, AStoreOperator {
        static var opcode: UInt8 = 0x81
        static var mnemonic = "STA"
    }

    struct IndirectY: IndirectYMode, AStoreOperator {
        static var opcode: UInt8 = 0x91
        static var mnemonic = "STA"
    }
}
