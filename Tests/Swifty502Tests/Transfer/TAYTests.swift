//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class TAYTests: NoProcessorTestCase {
    func execute(value: UInt8, zero: Bool, negative: Bool, instruction: Instruction.Type) {
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.y, value)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Negative], negative)
    }

    func testTAY() throws {
        registers.a = 0x00
        execute(value: 0x00, zero: true, negative: false, instruction: TAY.self)
        registers.a = 0x7f
        execute(value: 0x7f, zero: false, negative: false, instruction: TAY.self)
        registers.a = 0x80
        execute(value: 0x80, zero: false, negative: true, instruction: TAY.self)
        registers.a = 0xff
        execute(value: 0xff, zero: false, negative: true, instruction: TAY.self)
    }

    static var allTests = [
        ("testTAY", testTAY)
    ]
}

