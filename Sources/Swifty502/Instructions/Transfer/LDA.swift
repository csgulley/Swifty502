//
//  LDA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol ALoader: RegisterLoader {
}

extension ALoader {
    public static var mnemonic: String { "LDA" }

    static func setValue(value: UInt8, registers: Registers) {
        registers.a = value
    }
}

public struct LDA {
    public struct Immediate: ImmediateMode, ImmediateRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xa9
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xa5
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xb5
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xad
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xbd
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xb9
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xa1
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xb1
        static func cycles() -> Int { 5 }
    }
}
