//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class RTITests: NoProcessorTestCase {
    func testRTI() {
        stack.pushWord(0x1040)
        registers.status[.Negative] = true
        registers.status[.Overflow] = false
        registers.status[.Decimal] = false
        registers.status[.InterruptDisable] = false
        registers.status[.Zero] = false
        registers.status[.Carry] = true
        stack.pushByte(registers.status.statusByte)

        registers.pc = 0x1000
        registers.status.statusByte = ~registers.status.statusByte

        RTI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status.statusByte, 0xB1)
        XCTAssertEqual(registers.pc, 0x1040)
    }

    static var allTests = [
        ("testRTI", testRTI)
    ]
}

