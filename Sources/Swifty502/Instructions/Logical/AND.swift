//
//  AND.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol AndOperator {
}

extension AndOperator {
    static func and(value: UInt8, registers: Registers) {
        registers.a &= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}

fileprivate protocol ImmediateAnd: AndOperator {
}

extension ImmediateAnd {
    static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectAnd: AndOperator {
}

extension IndirectAnd {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        and(value: memory[operand], registers: registers)
    }
}

struct AND {
    struct Immediate: ImmediateMode, ImmediateAnd {
        static var opcode: UInt8 = 0x29
        static var mnemonic = "AND"
    }

    struct ZeroPage: ZeroPageMode, IndirectAnd {
        static var opcode: UInt8 = 0x25
        static var mnemonic = "AND"
    }

    struct ZeroPageX: ZeroPageXMode, IndirectAnd {
        static var opcode: UInt8 = 0x35
        static var mnemonic = "AND"
    }

    struct Absolute: AbsoluteMode, IndirectAnd {
        static var opcode: UInt8 = 0x2d
        static var mnemonic = "AND"
    }

    struct AbsoluteX: AbsoluteXMode, IndirectAnd {
        static var opcode: UInt8 = 0x3d
        static var mnemonic = "AND"
    }

    struct AbsoluteY: AbsoluteYMode, IndirectAnd {
        static var opcode: UInt8 = 0x39
        static var mnemonic = "AND"
    }

    struct IndirectX: IndirectXMode, IndirectAnd {
        static var opcode: UInt8 = 0x21
        static var mnemonic = "AND"
    }

    struct IndirectY: IndirectYMode, IndirectAnd {
        static var opcode: UInt8 = 0x31
        static var mnemonic = "AND"
    }

}
