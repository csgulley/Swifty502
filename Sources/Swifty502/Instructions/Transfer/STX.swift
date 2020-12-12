//
//  STX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol XStoreOperator {
    static func cycles() -> Int
}

extension XStoreOperator {
    public static var mnemonic: String { "STX" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] = registers.x
        return cycles()
    }
}

public struct STX {
    public struct ZeroPage: ZeroPageMode, XStoreOperator {
        public static var opcode: UInt8 = 0x86
        static func cycles() -> Int { 3 }
    }


    public struct ZeroPageY: ZeroPageYMode, XStoreOperator {
        public static var opcode: UInt8 = 0x96
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, XStoreOperator {
        public static var opcode: UInt8 = 0x8e
        static func cycles() -> Int { 4 }
    }
}

