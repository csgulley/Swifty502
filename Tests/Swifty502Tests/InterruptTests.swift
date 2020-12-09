//
// Created by Chris Gulley on 12/9/20.
//

import XCTest
@testable import Swifty502

class InterruptTests : XCTestCase {
    var processor: Processor!

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
    }

    func testSingleInterrupt() throws {
        processor.memory[0x300] = CLI.opcode
        processor.memory[0x301] = LDA.Immediate.opcode
        processor.memory[0x302] = 0x00
        processor.memory[0x303] = CLV.opcode
        processor.memory[0x304] = CLD.opcode
        processor.memory[0x305] = CLC.opcode
        processor.memory[0x306] = NOP.opcode
        processor.memory[0x307] = BRK.opcode
        processor.memory.writeWord(address: 0xfffc, value: 0x300)
        processor.memory.writeWord(address: 0xfffe, value: 0x500)
        
        processor.memory[0x500] = PLA.opcode
        processor.memory[0x501] = STA.ZeroPage.opcode
        processor.memory[0x502] = 0x40
        processor.memory[0x503] = PLA.opcode
        processor.memory[0x504] = STA.ZeroPage.opcode
        processor.memory[0x505] = 0x41
        processor.memory[0x506] = PLA.opcode
        processor.memory[0x507] = STA.ZeroPage.opcode
        processor.memory[0x508] = 0x42
        processor.memory[0x509] = PHA.opcode
        processor.memory[0x50a] = LDA.ZeroPage.opcode
        processor.memory[0x50b] = 0x41
        processor.memory[0x50c] = PHA.opcode
        processor.memory[0x50d] = LDA.ZeroPage.opcode
        processor.memory[0x50e] = 0x40
        processor.memory[0x50f] = PHA.opcode

        processor.memory[0x510] = RTI.opcode
        
        processor.brkHandler = { _,_ in true }
        
        struct Interceptor: InstructionInterceptor {
            func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
                if address == 0x306 {
                    processor.irq = true
                } else if address == 0x50f {
                    processor.irq = false
                }
            }
        }
     
        processor.addDebugInterceptor(Interceptor())
        try! processor.start()
        
        let status = processor.memory[0x40]
        XCTAssertEqual(status, 0x22)
        let address = processor.memory.readWord(0x41)
        XCTAssertEqual(address, 0x307)
    }
    
    func testMultipleInterrupts() throws {
        processor.memory[0x300] = CLI.opcode
        processor.memory[0x301] = LDX.Immediate.opcode
        processor.memory[0x302] = 0x00
        processor.memory[0x303] = CLI.opcode
        processor.memory[0x304] = LDA.Immediate.opcode
        processor.memory[0x305] = 0x00
        processor.memory[0x306] = CLV.opcode
        processor.memory[0x307] = CLD.opcode
        processor.memory[0x308] = CLC.opcode
        processor.memory[0x309] = NOP.opcode
        processor.memory[0x30a] = BRK.opcode
        processor.memory.writeWord(address: 0xfffc, value: 0x300)
        processor.memory.writeWord(address: 0xfffe, value: 0x500)
        
        processor.memory[0x500] = PLA.opcode
        processor.memory[0x501] = STA.ZeroPage.opcode
        processor.memory[0x502] = 0x40
        processor.memory[0x503] = PLA.opcode
        processor.memory[0x504] = STA.ZeroPage.opcode
        processor.memory[0x505] = 0x41
        processor.memory[0x506] = PLA.opcode
        processor.memory[0x507] = STA.ZeroPage.opcode
        processor.memory[0x508] = 0x42
        processor.memory[0x509] = PHA.opcode
        processor.memory[0x50a] = LDA.ZeroPage.opcode
        processor.memory[0x50b] = 0x41
        processor.memory[0x50c] = PHA.opcode
        processor.memory[0x50d] = LDA.ZeroPage.opcode
        processor.memory[0x50e] = 0x40
        processor.memory[0x50f] = PHA.opcode
        processor.memory[0x510] = INX.opcode

        processor.memory[0x511] = RTI.opcode
        
        processor.brkHandler = { _,_ in true }
        
        struct Interceptor: InstructionInterceptor {
            func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
                if address == 0x309 {
                    processor.irq = true
                } else if address == 0x511 && processor.x >= 2 {
                    processor.irq = false
                }
            }
        }
     
        processor.addDebugInterceptor(Interceptor())
        try! processor.start()
        
        XCTAssertEqual(processor.x, 2)
    }
    
    func testDisabled() throws {
        processor.memory[0x300] = SEI.opcode
        processor.memory[0x301] = LDA.Immediate.opcode
        processor.memory[0x302] = 0x00
        processor.memory[0x303] = CLV.opcode
        processor.memory[0x304] = CLD.opcode
        processor.memory[0x305] = CLC.opcode
        processor.memory[0x306] = NOP.opcode
        processor.memory[0x307] = BRK.opcode
        processor.memory.writeWord(address: 0xfffc, value: 0x300)
        processor.memory.writeWord(address: 0xfffe, value: 0x500)
        
        processor.memory[0x500] = LDA.Immediate.opcode
        processor.memory[0x501] = 0x22
        processor.memory[0x502] = STA.ZeroPage.opcode
        processor.memory[0x503] = 0x40
        processor.memory[0x504] = RTI.opcode
        
        
        processor.brkHandler = { _,_ in true }
        
        struct Interceptor: InstructionInterceptor {
            func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
                if address == 0x306 {
                    processor.irq = true
                }
            }
        }
     
        processor.addDebugInterceptor(Interceptor())
        
        processor.memory[0x40] = 0x00
        try! processor.start()
        XCTAssertEqual(processor.memory[0x40], 0x00)
    }

    static var allTests = [
        ("testSingleInterrupt", testSingleInterrupt),
        ("testMultipleInterrupts", testMultipleInterrupts),
        ("testDisabled", testDisabled)
    ]
}
