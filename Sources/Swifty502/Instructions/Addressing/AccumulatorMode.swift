//
//  AccumulatorMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public protocol AccumulatorMode: Instruction {
}

extension AccumulatorMode {
    public static var addressMode: AddressMode {
        .Accumulator
    }
}

