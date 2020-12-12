//
//  INC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

fileprivate protocol Incrementer {
    static var cycles: Int { get }
}

extension Incrementer {
    public static var mnemonic: String {
        "INC"
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] &+= 1
        registers.status.updateFlags(memory[operand], .Zero, .Negative)
        return cycles
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}

public struct INC {
    public struct ZeroPage: ZeroPageMode, Incrementer {
        public static var opcode: UInt8 = 0xe6
        fileprivate static var cycles: Int = 5
    }

    public struct ZeroPageX: ZeroPageXMode, Incrementer {
        public static var opcode: UInt8 = 0xf6
        fileprivate static var cycles: Int = 6
    }

    public struct Absolute: AbsoluteMode, Incrementer {
        public static var opcode: UInt8 = 0xee
        fileprivate static var cycles: Int = 6
    }

    public struct AbsoluteX: AbsoluteXMode, Incrementer {
        public static var opcode: UInt8 = 0xfe
        fileprivate static var cycles: Int = 7
    }
}

