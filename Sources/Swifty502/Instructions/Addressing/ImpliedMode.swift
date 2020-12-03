//
//  ImpliedMode.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol ImpliedMode: Instruction {
}

extension ImpliedMode {
    static var addressMode: AddressMode {
        .Implied
    }
}
