//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class DEYTests: NoProcessorTestCase {
    func execute(value: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type) {
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.y, value)
    }

    func testDEY() throws {
        registers.y = 0x01
        execute(value: 0x00, negative: false, zero: true, instruction: DEY.self)
        execute(value: 0xff, negative: true, zero: false, instruction: DEY.self)
    }

    static var allTests = [
        ("testDEY", testDEY)
    ]
}

