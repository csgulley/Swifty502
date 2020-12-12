//
//  EOR.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

fileprivate protocol XorOperator {
    static func cycles() -> Int
}

extension XorOperator {
    public static var mnemonic: String {
        "EOR"
    }

    static func xor(value: UInt8, registers: Registers) -> Int {
        registers.a ^= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
        return cycles()
    }
}

fileprivate protocol ImmediateXor: XorOperator {
}

extension ImmediateXor {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        xor(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectXor: XorOperator {
}

extension IndirectXor {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        xor(value: memory[operand], registers: registers)
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        xor(value: memory[operand], registers: registers) + (crossedPageBoundary ? 1 : 0)
    }
}

public struct EOR {
    public struct Immediate: ImmediateMode, ImmediateXor {
        public static var opcode: UInt8 = 0x49
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectXor {
        public static var opcode: UInt8 = 0x45
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectXor {
        public static var opcode: UInt8 = 0x55
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectXor {
        public static var opcode: UInt8 = 0x4d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectXor {
        public static var opcode: UInt8 = 0x5d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectXor {
        public static var opcode: UInt8 = 0x59
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectXor {
        public static var opcode: UInt8 = 0x41
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectXor {
        public static var opcode: UInt8 = 0x51
        static func cycles() -> Int { 5 }
    }

}

