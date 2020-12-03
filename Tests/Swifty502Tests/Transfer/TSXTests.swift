//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class TSXTests: NoProcessorTestCase {
    func execute(value: UInt8, zero: Bool, negative: Bool, instruction: Instruction.Type) {
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.x, value)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Negative], negative)
    }

    func testTSX() throws {
        registers.sp = 0x00
        execute(value: 0x00, zero: true, negative: false, instruction: TSX.self)
        registers.sp = 0x7f
        execute(value: 0x7f, zero: false, negative: false, instruction: TSX.self)
        registers.sp = 0x80
        execute(value: 0x80, zero: false, negative: true, instruction: TSX.self)
        registers.sp = 0xff
        execute(value: 0xff, zero: false, negative: true, instruction: TSX.self)
    }

    static var allTests = [
        ("testTSX", testTSX)
    ]
}

