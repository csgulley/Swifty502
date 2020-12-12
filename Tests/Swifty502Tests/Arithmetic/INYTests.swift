//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class INYTests: NoProcessorTestCase {
    func execute(value: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type) {
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.y, value)
    }

    func testINY() throws {
        registers.y = 0xfe
        execute(value: 0xff, negative: true, zero: false, instruction: INY.self)
        execute(value: 0x00, negative: false, zero: true, instruction: INY.self)
    }

    static var allTests = [
        ("testINY", testINY)
    ]
}

