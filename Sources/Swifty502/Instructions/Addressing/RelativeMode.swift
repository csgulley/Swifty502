//
//  RelativeMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public protocol RelativeMode: Instruction {
    static func execute(offset: Int8, memory: Memory, registers: Registers, stack: Stack) -> Int
}

extension RelativeMode {
    public static var addressMode: AddressMode {
        .Relative
    }

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        let offset = executor.nextByte(registers)
        return execute(offset: Int8(bitPattern: offset), memory: memory, registers: registers, stack: stack)
    }
}
