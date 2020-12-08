//
//  BIT.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol BITExecutor {
}

extension BITExecutor {
    public static var mnemonic: String { "BIT" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        let value = memory[operand]
        registers.status[.Negative] = (value & 0x80) > 0
        registers.status[.Overflow] = (value & 0x40) > 0
        registers.status[.Zero] = (value & registers.a) == 0
    }
}

public struct BIT {
    public struct ZeroPage: ZeroPageMode, BITExecutor {
        public static var opcode: UInt8 = 0x24
    }

    public struct Absolute: AbsoluteMode, BITExecutor {
        public static var opcode: UInt8 = 0x2C
    }
}
