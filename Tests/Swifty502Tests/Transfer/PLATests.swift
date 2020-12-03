//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class PLATests: NoProcessorTestCase {
    func execute(a: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type) {
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.a, a)
    }

    func testPLA() {
        stack.pushByte(0x00)
        stack.pushByte(0x01)
        stack.pushByte(0xff)
        execute(a: 0xff, negative: true, zero: false, instruction: PLA.self)
        execute(a: 0x01, negative: false, zero: false, instruction: PLA.self)
        execute(a: 0x00, negative: false, zero: true, instruction: PLA.self)
    }

    static var allTests = [
        ("testPLA", testPLA)
    ]
}

