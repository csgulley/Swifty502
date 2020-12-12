//
//  ADC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

fileprivate protocol AdcOperator {
    static func cycles() -> Int
}

extension AdcOperator {
    public static var mnemonic: String { "ADC" }

    static func add(value: UInt8, registers: Registers) {
        if (registers.status[.Decimal]) {
            AddOperator.decimalAdd(value: value, registers: registers)
        } else {
            AddOperator.binaryAdd(value: value, registers: registers)
        }
    }
}

fileprivate protocol ImmediateAdd: AdcOperator {
}

extension ImmediateAdd {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        add(value: operand, registers: registers)
        return cycles()
    }
}

fileprivate protocol IndirectAdd: AdcOperator {
}

extension IndirectAdd {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        add(value: memory[operand], registers: registers)
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack) + (crossedPageBoundary ? 1 : 0)
    }
}

public struct ADC {
    public struct Immediate: ImmediateMode, ImmediateAdd {
        public static var opcode: UInt8 = 0x69
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectAdd {
        public static var opcode: UInt8 = 0x65
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectAdd {
        public static var opcode: UInt8 = 0x75
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectAdd {
        public static var opcode: UInt8 = 0x6d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectAdd {
        public static var opcode: UInt8 = 0x7d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectAdd {
        public static var opcode: UInt8 = 0x79
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectAdd {
        public static var opcode: UInt8 = 0x61
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectAdd {
        public static var opcode: UInt8 = 0x71
        static func cycles() -> Int { 5 }
    }
}

