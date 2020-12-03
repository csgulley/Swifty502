//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class RTSTests: NoProcessorTestCase {
    func testRTS() {
        stack.pushByte(0xaa)
        stack.pushByte(0xbb)
        RTS.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.pc, 0xaabc)
    }

    static var allTests = [
        ("testRTS", testRTS)
    ]
}

