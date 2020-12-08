//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class UnknownInstructionTests: XCTestCase {
    var processor: Processor!

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
    }

    func testUnknownInstruction() throws {
        processor.memory[0] = 0x22

        processor.memory.writeWord(address: 0xfffc, value: 0)
        XCTAssertThrowsError(try processor.start()) { error in
            XCTAssert(error is Processor.UnknownInstruction)
        }
    }

    static var allTests = [
        ("testUnknownInstruction", testUnknownInstruction),
    ]
}

