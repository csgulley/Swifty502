//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class PHPTests: NoProcessorTestCase {
    func testPHP() {
        registers.status[.Negative] = true
        registers.status[.Overflow] = false
        registers.status[.Decimal] = false
        registers.status[.InterruptDisable] = true
        registers.status[.Zero] = false
        registers.status[.Carry] = true
        let _ = PHP.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        let val = stack.popByte()
        XCTAssertEqual(val, 0xb5)
    }

    static var allTests = [
        ("testPHP", testPHP)
    ]
}

