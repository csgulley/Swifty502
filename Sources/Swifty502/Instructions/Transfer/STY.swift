//
//  STY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol YStoreOperator {
}

extension YStoreOperator {
    public static var mnemonic: String { "STY" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = registers.y
    }
}

public struct STY {
    public struct ZeroPage: ZeroPageMode, YStoreOperator {
        public static var opcode: UInt8 = 0x84
    }

    public struct ZeroPageX: ZeroPageXMode, YStoreOperator {
        public static var opcode: UInt8 = 0x94
    }

    public struct Absolute: AbsoluteMode, YStoreOperator {
        public static var opcode: UInt8 = 0x8c
    }
}
