//
//  InstructionInterceptor.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public protocol InstructionInterceptor {
    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor)
}
