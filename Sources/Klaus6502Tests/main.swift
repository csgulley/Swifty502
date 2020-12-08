import Foundation
import Swifty502
/**
 Configuration for running tests available here: https://github.com/amb5l/6502_65C02_functional_tests. The
 binary and listing file is not part of this package so you'll need to compile them and then update the
 path below.
 */
let filename = "/Users/csgulley/LocalProjects/6502_65C02_functional_tests/bin_files/6502_functional_test.bin"

class ArrayMemory: Memory {
    private var storage = Array<UInt8>(repeating: 0x00, count: Int(UInt16.max) + 1)
    subscript(address: UInt16) -> UInt8 {
        get { storage[Int(address)] }
        set(newValue) { storage[Int(address)] = newValue }
    }
}

/**
 Test ends in a tight loop on the same instruction which this code detects
 */
class TerminationCheck: InstructionInterceptor {
    var originalResetVector: UInt16?
    var last: UInt16 = 0xffff
    var isComplete = false
    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        if let o = originalResetVector {
            processor.memory.writeWord(address: 0xfffc, value: o)
            originalResetVector = nil
        }

        if (last == address && !isComplete) {
            let msg = String(format: "test trapped at %04x", address)
            print(msg)
            isComplete = true
            processor.memory[address] = BRK.opcode
        }
        last = address
    }
}


let memory = ArrayMemory()
let data = NSData(contentsOfFile: filename)!
for i in 0..<data.count {
    memory[UInt16(i)] = data[i]
}

let processor = Processor(memory: memory)

let terminationCheck = TerminationCheck()
processor.addDebugInterceptor(terminationCheck)

// Test needs to start at 0x400 so we replace the value the test stores in 0xfffc with that value
terminationCheck.originalResetVector = processor.memory.readWord(0xfffc)
processor.memory.writeWord(address: 0xfffc, value: 0x400)

processor.brkHandler = { _,_ in
    // First break is to test behavior and second is to stop
    // execution
    terminationCheck.isComplete
}
try! processor.start()

