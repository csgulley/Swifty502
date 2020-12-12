//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class TXATests: NoProcessorTestCase {
    func execute(value: UInt8, zero: Bool, negative: Bool, instruction: Instruction.Type) {
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.a, value)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Negative], negative)
    }

    func testTXA() throws {
        registers.x = 0x00
        execute(value: 0x00, zero: true, negative: false, instruction: TXA.self)
        registers.x = 0x7f
        execute(value: 0x7f, zero: false, negative: false, instruction: TXA.self)
        registers.x = 0x80
        execute(value: 0x80, zero: false, negative: true, instruction: TXA.self)
        registers.x = 0xff
        execute(value: 0xff, zero: false, negative: true, instruction: TXA.self)
    }

    static var allTests = [
        ("testTXA", testTXA)
    ]
}

