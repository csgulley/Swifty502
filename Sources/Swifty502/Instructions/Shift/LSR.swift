//
//  LSR.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/26/20.
//

fileprivate protocol Shifter {
    static func cycles() -> Int
}

extension Shifter {
    public static var mnemonic: String { "LSR" }

    static func shift(value: UInt8, registers: Registers) -> UInt8 {
        registers.status[.Carry] = (value & 0x01) > 0
        let shifted = value >> 1
        registers.status.updateFlags(shifted, .Zero, .Negative)
        return shifted
    }
}

fileprivate protocol AccumulatorShifter: Shifter {
}

extension AccumulatorShifter {
    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.a = shift(value: registers.a, registers: registers)
        return cycles()
    }
}

fileprivate protocol IndirectShifter: Shifter {
}

extension IndirectShifter {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] = shift(value: memory[operand], registers: registers)
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}

public struct LSR {
    public struct Accumulator: AccumulatorMode, AccumulatorShifter {
        public static var opcode: UInt8 = 0x4a
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectShifter {
        public static var opcode: UInt8 = 0x46
        static func cycles() -> Int { 5 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectShifter {
        public static var opcode: UInt8 = 0x56
        static func cycles() -> Int { 6 }
    }

    public struct Absolute: AbsoluteMode, IndirectShifter {
        public static var opcode: UInt8 = 0x4e
        static func cycles() -> Int { 6 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectShifter {
        public static var opcode: UInt8 = 0x5e
        static func cycles() -> Int { 7 }
    }
}
