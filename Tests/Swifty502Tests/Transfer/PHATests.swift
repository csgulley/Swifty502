//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class PHATests: NoProcessorTestCase {
    func testPHA() {
        registers.a = 0xab
        PHA.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(stack.popByte(), 0xab)
    }

    static var allTests = [
        ("testPHA", testPHA)
    ]
}

