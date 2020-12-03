//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class INXTests: NoProcessorTestCase {
    func execute(value: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type) {
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.x, value)
    }

    func testINX() throws {
        registers.x = 0xfe
        execute(value: 0xff, negative: true, zero: false, instruction: INX.self)
        execute(value: 0x00, negative: false, zero: true, instruction: INX.self)
    }

    static var allTests = [
        ("testINX", testINX)
    ]
}

