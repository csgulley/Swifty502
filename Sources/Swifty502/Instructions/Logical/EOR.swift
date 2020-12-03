//
//  EOR.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

fileprivate protocol XorOperator {
}

extension XorOperator {
    static var mnemonic: String {
        return "EOR"
    }

    static func and(value: UInt8, registers: Registers) {
        registers.a ^= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}

fileprivate protocol ImmediateXor: XorOperator {
}

extension ImmediateXor {
    static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectXor: XorOperator {
}

extension IndirectXor {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        and(value: memory[operand], registers: registers)
    }
}

struct EOR {
    struct Immediate: ImmediateMode, ImmediateXor {
        static var opcode: UInt8 = 0x49
    }

    struct ZeroPage: ZeroPageMode, IndirectXor {
        static var opcode: UInt8 = 0x45
    }

    struct ZeroPageX: ZeroPageXMode, IndirectXor {
        static var opcode: UInt8 = 0x55
    }

    struct Absolute: AbsoluteMode, IndirectXor {
        static var opcode: UInt8 = 0x4d
    }

    struct AbsoluteX: AbsoluteXMode, IndirectXor {
        static var opcode: UInt8 = 0x5d
    }

    struct AbsoluteY: AbsoluteYMode, IndirectXor {
        static var opcode: UInt8 = 0x59
    }

    struct IndirectX: IndirectXMode, IndirectXor {
        static var opcode: UInt8 = 0x41
    }

    struct IndirectY: IndirectYMode, IndirectXor {
        static var opcode: UInt8 = 0x51
    }

}

