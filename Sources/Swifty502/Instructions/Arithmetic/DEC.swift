//
//  DEC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol DecrementOperator {
}

extension DecrementOperator {
    public static var mnemonic: String { "DEC" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] &-= 1
        registers.status.updateFlags(memory[operand], .Zero, .Negative)
    }
}

public struct DEC {
    public struct ZeroPage: ZeroPageMode, DecrementOperator {
        public static var opcode: UInt8 = 0xc6
    }

    public struct ZeroPageX: ZeroPageXMode, DecrementOperator {
        public static var opcode: UInt8 = 0xd6
    }

    public struct Absolute: AbsoluteMode, DecrementOperator {
        public static var opcode: UInt8 = 0xce
    }

    public struct AbsoluteX: AbsoluteXMode, DecrementOperator {
        public static var opcode: UInt8 = 0xde
    }
}
