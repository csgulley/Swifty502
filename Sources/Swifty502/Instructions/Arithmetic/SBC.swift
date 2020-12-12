//
//  SBC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

fileprivate protocol SubtractOperator {
    static func cycles() -> Int
}

extension SubtractOperator {
    public static var mnemonic: String {
        "SBC"
    }

    static func subtract(value: UInt8, registers: Registers) {
        if (registers.status[.Decimal]) {
            AddOperator.decimalSubtract(value: value, registers: registers)
        } else {
            AddOperator.binarySubtract(value: value, registers: registers)
        }
    }
}

fileprivate protocol ImmediateSubtract: SubtractOperator {
}

extension ImmediateSubtract {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        subtract(value: operand, registers: registers)
        return cycles()
    }
}

fileprivate protocol IndirectSubtract: SubtractOperator {
}

extension IndirectSubtract {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        subtract(value: memory[operand], registers: registers)
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack) + (crossedPageBoundary ? 1 : 0)
    }
}

public struct SBC {
    public struct Immediate: ImmediateMode, ImmediateSubtract {
        public static var opcode: UInt8 = 0xe9
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xe5
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xf5
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xed
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xfd
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xf9
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xe1
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xf1
        static func cycles() -> Int { 5 }
    }
}

