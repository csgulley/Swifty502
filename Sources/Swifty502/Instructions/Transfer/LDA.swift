//
//  LDA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol ALoader: RegisterLoader {
}

extension ALoader {
    static func setValue(value: UInt8, registers: Registers) {
        registers.a = value
    }
}

public struct LDA {
    public struct Immediate: ImmediateMode, ImmediateRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xa9
        public static var mnemonic = "LDA"
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xa5
        public static var mnemonic = "LDA"
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xb5
        public static var mnemonic = "LDA"
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xad
        public static var mnemonic = "LDA"
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xbd
        public static var mnemonic = "LDA"
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xb9
        public static var mnemonic = "LDA"
    }

    public struct IndirectX: IndirectXMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xa1
        public static var mnemonic = "LDA"
    }

    public struct IndirectY: IndirectYMode, IndirectRegisterLoader, ALoader {
        public static var opcode: UInt8 = 0xb1
        public static var mnemonic = "LDA"
    }
}
