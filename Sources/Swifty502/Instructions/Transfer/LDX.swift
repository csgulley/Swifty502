//
//  LDX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol XLoader: RegisterLoader {
}

extension XLoader {
    static func setValue(value: UInt8, registers: Registers) {
        registers.x = value
    }
}

struct LDX {
    struct Immediate: ImmediateMode, ImmediateRegisterLoader, XLoader {
        static var opcode: UInt8 = 0xa2
        static var mnemonic = "LDX"
    }

    struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, XLoader {
        static var opcode: UInt8 = 0xa6
        static var mnemonic = "LDX"
    }

    struct ZeroPageY: ZeroPageYMode, IndirectRegisterLoader, XLoader {
        static var opcode: UInt8 = 0xb6
        static var mnemonic = "LDX"
    }

    struct Absolute: AbsoluteMode, IndirectRegisterLoader, XLoader {
        static var opcode: UInt8 = 0xae
        static var mnemonic = "LDX"
    }

    struct AbsoluteY: AbsoluteYMode, IndirectRegisterLoader, XLoader {
        static var opcode: UInt8 = 0xbe
        static var mnemonic = "LDX"
    }
}
