//
//  STY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol YStoreOperator {
}

extension YStoreOperator {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = registers.y
    }
}

struct STY {
    struct ZeroPage: ZeroPageMode, YStoreOperator {
        static var opcode: UInt8 = 0x84
        static var mnemonic = "STY"
    }

    struct ZeroPageX: ZeroPageXMode, YStoreOperator {
        static var opcode: UInt8 = 0x94
        static var mnemonic = "STY"
    }

    struct Absolute: AbsoluteMode, YStoreOperator {
        static var opcode: UInt8 = 0x8c
        static var mnemonic = "STY"
    }
}
