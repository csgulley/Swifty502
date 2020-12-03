//
//  BIT.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol BITExecutor {
}

extension BITExecutor {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        let value = memory[operand]
        registers.status[.Negative] = (value & 0x80) > 0
        registers.status[.Overflow] = (value & 0x40) > 0
        registers.status[.Zero] = (value & registers.a) == 0
    }
}

struct BIT {
    struct ZeroPage: ZeroPageMode, BITExecutor {
        static var opcode: UInt8 = 0x24
        static var mnemonic = "BIT"
    }

    struct Absolute: AbsoluteMode, BITExecutor {
        static var opcode: UInt8 = 0x2C
        static var mnemonic = "BIT"
    }
}
