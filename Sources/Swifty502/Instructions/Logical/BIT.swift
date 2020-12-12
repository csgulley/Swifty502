//
//  BIT.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol BITExecutor {
    static func cycles() -> Int
}

extension BITExecutor {
    public static var mnemonic: String { "BIT" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        let value = memory[operand]
        registers.status[.Negative] = (value & 0x80) > 0
        registers.status[.Overflow] = (value & 0x40) > 0
        registers.status[.Zero] = (value & registers.a) == 0
        return cycles()
    }
}

public struct BIT {
    public struct ZeroPage: ZeroPageMode, BITExecutor {
        public static var opcode: UInt8 = 0x24
        static func cycles() -> Int { 3 }
    }

    public struct Absolute: AbsoluteMode, BITExecutor {
        public static var opcode: UInt8 = 0x2C
        static func cycles() -> Int { 4 }
    }
}
