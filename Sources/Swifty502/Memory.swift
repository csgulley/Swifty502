//
//  File.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

import Foundation

public protocol Memory: class {
    subscript(address: UInt16) -> UInt8 { get set }
}

extension Memory {
    public func readWord(_ address: UInt16) -> UInt16 {
        let lo = UInt16(self[address])
        let hi = UInt16(self[address + 1])
        return (hi << 8) | lo
    }

    public func writeWord(address: UInt16, value: UInt16) {
        self[address] = UInt8(value & 0xff)
        self[address + 1] = UInt8(value >> 8)
    }
}
