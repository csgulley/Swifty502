//
//  ROL.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

fileprivate protocol RotateOperation {
}

extension RotateOperation {
    static func shift(value: UInt8, registers: Registers) -> UInt8 {
        let carryBitmask: UInt8 = registers.status[.Carry] ? 0x01 : 0x00
        registers.status[.Carry] = (value & 0x80) > 0
        let shifted = (value << 1) | carryBitmask
        registers.status.updateFlags(shifted, .Zero, .Negative)
        return shifted
    }

    static var mnemonic: String {
        return "ROL"
    }
}

fileprivate protocol AccumulatorRotate: RotateOperation {
}

extension AccumulatorRotate {
    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = shift(value: registers.a, registers: registers)
    }
}

fileprivate protocol IndirectRotate: RotateOperation {
}

extension IndirectRotate {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = shift(value: memory[operand], registers: registers)
    }
}

struct ROL {
    struct Accumulator: AccumulatorMode, AccumulatorRotate {
        static var opcode: UInt8 = 0x2a
    }

    struct ZeroPage: ZeroPageMode, IndirectRotate {
        static var opcode: UInt8 = 0x26
    }

    struct ZeroPageX: ZeroPageXMode, IndirectRotate {
        static var opcode: UInt8 = 0x36
    }

    struct Absolute: AbsoluteMode, IndirectRotate {
        static var opcode: UInt8 = 0x2e
    }

    struct AbsoluteX: AbsoluteXMode, IndirectRotate {
        static var opcode: UInt8 = 0x3e
    }
}

