//
//  Stack.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

final public class Stack {
    private static let Base: UInt16 = 0x100
    private let memory: Memory
    private let registers: Registers

    init(memory: Memory, registers: Registers) {
        self.memory = memory
        self.registers = registers
        self.registers.sp = 0xff
    }

    public func pushByte(_ data: UInt8) {
        memory[Stack.Base + UInt16(registers.sp)] = data
        registers.sp &-= 1
    }

    public func popByte() -> UInt8 {
        registers.sp &+= 1
        return memory[Stack.Base + UInt16(registers.sp)]
    }

    public func pushWord(_ data: UInt16) {
        memory[Stack.Base + UInt16(registers.sp)] = UInt8(data >> 8)
        registers.sp &-= 1
        memory[Stack.Base + UInt16(registers.sp)] = UInt8(data & 0xff)
        registers.sp &-= 1
    }

    public func popWord() -> UInt16 {
        registers.sp &+= 1
        let lo = UInt16(memory[Stack.Base + UInt16(registers.sp)])
        registers.sp &+= 1
        let hi = UInt16(memory[Stack.Base + UInt16(registers.sp)])
        return (hi << 8) | lo
    }
}
