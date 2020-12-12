//
//  ROR.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

fileprivate protocol RotateOperation {
    static func cycles() -> Int
}

extension RotateOperation {
    public static var mnemonic: String { "ROR" }

    static func shift(value: UInt8, registers: Registers) -> UInt8 {
        let carryBitmask: UInt8 = registers.status[.Carry] ? 0x80 : 0x00
        registers.status[.Carry] = (value & 0x01) > 0
        let shifted = (value >> 1) | carryBitmask
        registers.status.updateFlags(shifted, .Zero, .Negative)
        return shifted
    }
}

fileprivate protocol AccumulatorRotate: RotateOperation {
}

extension AccumulatorRotate {
    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.a = shift(value: registers.a, registers: registers)
        return cycles()
    }
}

fileprivate protocol IndirectRotate: RotateOperation {
}

extension IndirectRotate {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] = shift(value: memory[operand], registers: registers)
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}

public struct ROR {
    public struct Accumulator: AccumulatorMode, AccumulatorRotate {
        public static var opcode: UInt8 = 0x6a
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectRotate {
        public static var opcode: UInt8 = 0x66
        static func cycles() -> Int { 5 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRotate {
        public static var opcode: UInt8 = 0x76
        static func cycles() -> Int { 6 }
    }

    public struct Absolute: AbsoluteMode, IndirectRotate {
        public static var opcode: UInt8 = 0x6e
        static func cycles() -> Int { 6 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRotate {
        public static var opcode: UInt8 = 0x7e
        static func cycles() -> Int { 7 }
    }
}

