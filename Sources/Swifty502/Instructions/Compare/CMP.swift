//
//  CMP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

fileprivate protocol AComparer: RegisterComparer {
}

extension AComparer {
    public static var mnemonic: String { "CMP" }

    static func getRegisterValue(_ registers: Registers) -> UInt8 {
        registers.a
    }
}

public struct CMP {
    public struct Immediate: ImmediateMode, ImmediateRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xc9
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xc5
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xd5
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xcd
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xdd
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xd9
    }

    public struct IndirectX: IndirectXMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xc1
    }

    public struct IndirectY: IndirectYMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xd1
    }
}
