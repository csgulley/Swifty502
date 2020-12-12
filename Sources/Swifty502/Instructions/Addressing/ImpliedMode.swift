//
//  ImpliedMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public protocol ImpliedMode: Instruction {
}

extension ImpliedMode {
    public static var addressMode: AddressMode { .Implied }
}
