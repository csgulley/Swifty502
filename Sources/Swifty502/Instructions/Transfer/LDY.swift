//
//  LDY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol YLoader: RegisterLoader {
}

extension YLoader {
    static func setValue(value: UInt8, registers: Registers) {
        registers.y = value
    }
}

public struct LDY {
    public struct Immediate: ImmediateMode, ImmediateRegisterLoader, YLoader {
        public static var opcode: UInt8 = 0xa0
        public static var mnemonic = "LDY"
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, YLoader {
        public static var opcode: UInt8 = 0xa4
        public static var mnemonic = "LDY"
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRegisterLoader, YLoader {
        public static var opcode: UInt8 = 0xb4
        public static var mnemonic = "LDY"
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterLoader, YLoader {
        public static var opcode: UInt8 = 0xac
        public static var mnemonic = "LDY"
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRegisterLoader, YLoader {
        public static var opcode: UInt8 = 0xbc
        public static var mnemonic = "LDY"
    }
}
