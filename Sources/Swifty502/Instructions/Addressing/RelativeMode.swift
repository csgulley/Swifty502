//
//  RelativeMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol RelativeMode: Instruction {
    static func execute(offset: Int8, memory: Memory, registers: Registers, stack: Stack)
}

extension RelativeMode {
    static var addressMode: AddressMode {
        .Relative
    }

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        let offset = executor.nextByte(registers)
        execute(offset: Int8(bitPattern: offset), memory: memory, registers: registers, stack: stack)
    }
}
