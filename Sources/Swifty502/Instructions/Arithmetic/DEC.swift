//
//  DEC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol DecrementOperator {
}

extension DecrementOperator {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] &-= 1
        registers.status.updateFlags(memory[operand], .Zero, .Negative)
    }
}

struct DEC {
    struct ZeroPage: ZeroPageMode, DecrementOperator {
        static var opcode: UInt8 = 0xc6
        static var mnemonic = "DEC"
    }

    struct ZeroPageX: ZeroPageXMode, DecrementOperator {
        static var opcode: UInt8 = 0xd6
        static var mnemonic = "DEC"
    }

    struct Absolute: AbsoluteMode, DecrementOperator {
        static var opcode: UInt8 = 0xce
        static var mnemonic = "DEC"
    }

    struct AbsoluteX: AbsoluteXMode, DecrementOperator {
        static var opcode: UInt8 = 0xde
        static var mnemonic = "DEC"
    }
}
