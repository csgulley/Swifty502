//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class TXSTests: NoProcessorTestCase {
    func testTXS() throws {
        registers.x = 0x22
        TXS.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.sp, 0x22)
    }

    static var allTests = [
        ("testTXS", testTXS)
    ]
}

