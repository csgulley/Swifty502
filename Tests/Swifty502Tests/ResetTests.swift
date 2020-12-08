//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class ResetTests : XCTestCase, InstructionInterceptor {
    var processor: Processor!

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
        processor.brkHandler = { _,_ in true }
        processor.addDebugInterceptor(self)
    }

    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        if processor.x == 0x01 {
            processor.memory.writeWord(address: 0xfffc, value: 0x100)
            processor.reset()
        }
    }

    func testReset() throws {
        processor.memory[0x00] = CLI.opcode
        processor.memory[0x01] = LDX.Immediate.opcode
        processor.memory[0x02] = 0xff
        processor.memory[0x03] = DEX.opcode
        processor.memory[0x04] = BNE.opcode
        processor.memory[0x05] = 0xfd
        processor.memory[0x100] = BRK.opcode

        processor.memory.writeWord(address: 0xfffc, value: 0)
        try! processor.start()
        XCTAssertEqual(processor.pc, 0x101)
        XCTAssertTrue(processor.status[.InterruptDisable])
    }

    static var allTests = [
        ("testReset", testReset)
    ]
}
