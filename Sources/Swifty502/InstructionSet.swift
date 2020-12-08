//
//  InstructionSet.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public protocol InstructionSet {
    static var instructions: [Instruction.Type] { get }
}
