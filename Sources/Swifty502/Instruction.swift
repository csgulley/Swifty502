//
//  Instruction.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

public protocol Instruction {
    static var opcode: UInt8 { get }
    static var mnemonic: String { get }
    static var addressMode: AddressMode { get }
    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor)
}
