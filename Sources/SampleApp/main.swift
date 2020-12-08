import Swifty502
/**
 Sample code that demonstrates running simple program with Swifty6502
 */

class ArrayMemory: Memory {
    private var storage = Array<UInt8>(repeating: 0x00, count: Int(UInt16.max) + 1)
    subscript(address: UInt16) -> UInt8 {
        get { storage[Int(address)] }
        set(newValue) { storage[Int(address)] = newValue }
    }
}
let memory = ArrayMemory()

/**
 Load test program that loops for awhile an then executes BRK
 - Parameter at: starting address
 */
func loadProgram(at: UInt16) {
    let instructions: [UInt8] = [
        LDX.Immediate.opcode,
        0x08,
        DEX.opcode,
        BNE.opcode,
        0xfd,
        BRK.opcode
    ]

    for (i, byte) in instructions.enumerated() {
        memory[at + UInt16(i)] = byte
    }
}

loadProgram(at: 0x300)

/// Execution starts at address stored at 0xfffc
memory.writeWord(address: 0xfffc, value: 0x300)
let processor = Processor(memory: memory)

/// Break handlers are optional and can be used for debugging.
processor.brkHandler = { address, processor in
    print(String(format:"BRK at %04x x: %02x", address, processor.x))

    // stop processor execution
    return true
}

/// Debug interceptors are useful for stepping through code or displaying diagnostic information
processor.addDebugInterceptor(InstructionTracer())

try! processor.start()

