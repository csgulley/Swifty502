//
//  AccumulatorMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol AccumulatorMode: Instruction {
}

extension AccumulatorMode {
    static var addressMode: AddressMode {
        .Accumulator
    }
}

