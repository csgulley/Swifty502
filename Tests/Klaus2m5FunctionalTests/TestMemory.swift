//
//  File.swift
//  
//
//  Created by Chris Gulley on 12/7/20.
//

@testable import Swifty502

class TestMemory : Memory {
    private static let MAX_ADDRESS = 0xffff
    private var memory = Array<UInt8>(repeating: 0xab, count: TestMemory.MAX_ADDRESS + 1)

    subscript(address: UInt16) -> UInt8 {
        get {
            memory[Int(address)]
        }
        set(newValue) {
            memory[Int(address)] = newValue
        }
    }
}
