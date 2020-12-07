//
//  StatusRegister.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

public protocol ProcessorStatus {
    subscript(index: StatusFlag) -> Bool { get }
}
