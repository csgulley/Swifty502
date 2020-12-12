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
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xc5
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xd5
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xcd
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xdd
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xd9
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xc1
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectRegisterComparer, AComparer {
        public static var opcode: UInt8 = 0xd1
        static func cycles() -> Int { 5 }
    }
}
