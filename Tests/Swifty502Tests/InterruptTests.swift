//
// Created by Chris Gulley on 12/9/20.
//

import XCTest
@testable import Swifty502

class InterruptTests : XCTestCase, InstructionInterceptor {
    var processor: Processor!

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
        processor.addDebugInterceptor(self)
    }

    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        if address == 0x306 {
            processor.irq = true
        }
    }

    func testInterrupt() throws {
        processor.memory[0x300] = CLI.opcode
        processor.memory[0x301] = LDA.Immediate.opcode
        processor.memory[0x302] = 0x00
        processor.memory[0x303] = CLV.opcode
        processor.memory[0x304] = CLD.opcode
        processor.memory[0x305] = CLC.opcode
        processor.memory[0x306] = NOP.opcode
        processor.memory.writeWord(address: 0xfffc, value: 0x300)
        processor.memory.writeWord(address: 0xfffe, value: 0x500)
        
        processor.memory[0x500] = BRK.opcode

        processor.brkHandler = { address, processor in
            if (address == 0x500) {
                let status = processor.memory[0x100 + UInt16(processor.sp) + 1]
                XCTAssertEqual(status, 0x22)
                let address = processor.memory.readWord(0x100 + UInt16(processor.sp) + 2)
                XCTAssertEqual(address, 0x307)
            }
            return true
        }

        try! processor.start()
    }

    static var allTests = [
        ("testInterrupt", testInterrupt)
    ]
}
