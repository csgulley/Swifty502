//
//  LDX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol XLoader: RegisterLoader {
}

extension XLoader {
    public static var mnemonic: String { "LDX" }
    static func setValue(value: UInt8, registers: Registers) {
        registers.x = value
    }
}

public struct LDX {
    public struct Immediate: ImmediateMode, ImmediateRegisterLoader, XLoader {
        public static var opcode: UInt8 = 0xa2
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, XLoader {
        public static var opcode: UInt8 = 0xa6
    }

    public struct ZeroPageY: ZeroPageYMode, IndirectRegisterLoader, XLoader {
        public static var opcode: UInt8 = 0xb6
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterLoader, XLoader {
        public static var opcode: UInt8 = 0xae
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectRegisterLoader, XLoader {
        public static var opcode: UInt8 = 0xbe
    }
}
