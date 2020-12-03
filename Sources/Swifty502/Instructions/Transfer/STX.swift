//
//  STX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol XStoreOperator {
}

extension XStoreOperator {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = registers.x
    }
}

struct STX {
    struct ZeroPage: ZeroPageMode, XStoreOperator {
        static var opcode: UInt8 = 0x86
        static var mnemonic = "STX"
    }


    struct ZeroPageY: ZeroPageYMode, XStoreOperator {
        static var opcode: UInt8 = 0x96
        static var mnemonic = "STX"
    }

    struct Absolute: AbsoluteMode, XStoreOperator {
        static var opcode: UInt8 = 0x8e
        static var mnemonic = "STX"
    }
}

