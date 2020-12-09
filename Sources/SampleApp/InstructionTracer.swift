import Swifty502
/**
 Example of an interceptor that can be used with Processor.addDebugInterceptor to debug programs. Not all addressing
 modes are implemented.
 */
class InstructionTracer: InstructionInterceptor {
    private func formatOperand(address: UInt16, instruction: Instruction.Type, memory: Memory) -> String {
        let formatted: String
        switch instruction.addressMode {
        case .Absolute:
            let operand = memory.readWord(address)
            formatted = String(format: "$%02x", operand)
        case .Relative:
            let offset = memory[address + 1]
            let operand = UInt16(Int(Int8(bitPattern: offset)) + Int(address + 2))
            formatted = String(format: "$%04x", operand)
        case .Immediate:
            let operand = UInt16(memory[address + 1])
            formatted = String(format: "#$%02x", operand)
        case .ZeroPage:
            let operand = UInt16(memory[address + 1])
            formatted = String(format: "$%02x", operand)
        default:
            formatted = ""
        }
        return formatted
    }

    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        let formattedAddress = String(format: "%04x", address)
        let formattedOperand = formatOperand(address: address, instruction: instruction, memory: processor.memory)
        print("\(formattedAddress) \(instruction.mnemonic) \(formattedOperand)")
    }
}

