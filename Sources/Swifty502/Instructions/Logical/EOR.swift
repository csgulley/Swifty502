//
//  EOR.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

fileprivate protocol XorOperator {
}

extension XorOperator {
    public static var mnemonic: String {
        "EOR"
    }

    static func and(value: UInt8, registers: Registers) {
        registers.a ^= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}

fileprivate protocol ImmediateXor: XorOperator {
}

extension ImmediateXor {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectXor: XorOperator {
}

extension IndirectXor {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        and(value: memory[operand], registers: registers)
    }
}

public struct EOR {
    public struct Immediate: ImmediateMode, ImmediateXor {
        public static var opcode: UInt8 = 0x49
    }

    public struct ZeroPage: ZeroPageMode, IndirectXor {
        public static var opcode: UInt8 = 0x45
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectXor {
        public static var opcode: UInt8 = 0x55
    }

    public struct Absolute: AbsoluteMode, IndirectXor {
        public static var opcode: UInt8 = 0x4d
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectXor {
        public static var opcode: UInt8 = 0x5d
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectXor {
        public static var opcode: UInt8 = 0x59
    }

    public struct IndirectX: IndirectXMode, IndirectXor {
        public static var opcode: UInt8 = 0x41
    }

    public struct IndirectY: IndirectYMode, IndirectXor {
        public static var opcode: UInt8 = 0x51
    }

}

