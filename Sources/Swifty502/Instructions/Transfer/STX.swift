//
//  STX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol XStoreOperator {
}

extension XStoreOperator {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = registers.x
    }
}

public struct STX {
    public struct ZeroPage: ZeroPageMode, XStoreOperator {
        public static var opcode: UInt8 = 0x86
        public static var mnemonic = "STX"
    }


    public struct ZeroPageY: ZeroPageYMode, XStoreOperator {
        public static var opcode: UInt8 = 0x96
        public static var mnemonic = "STX"
    }

    public struct Absolute: AbsoluteMode, XStoreOperator {
        public static var opcode: UInt8 = 0x8e
        public static var mnemonic = "STX"
    }
}

