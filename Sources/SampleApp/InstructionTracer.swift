import Swifty502
/**
 Example of an interceptor that can be used with Processor.addDebugInterceptor to debug programs. Not all addressing
 modes are implemented.
 */
class InstructionTracer: InstructionInterceptor {
    private func formatOperand(operand: UInt16, addressMode: AddressMode) -> String {
        let formatted: String
        switch addressMode {
        case .Absolute, .Relative:
            formatted = String(format: "$%04x", operand)
        case .Immediate:
            formatted = String(format: "#$%02x", operand)
        case .ZeroPage:
            formatted = String(format: "$%02x", operand)
        default:
            formatted = ""
        }
        return formatted
    }

    private func getOperand(address: UInt16, instruction: Instruction.Type, memory: Memory) -> UInt16 {
        let operand: UInt16
        switch instruction.addressMode {
        case .Absolute:
            operand = memory.readWord(address)
        case .Immediate, .ZeroPage:
            operand = UInt16(memory[address + 1])
        case .Relative:
            let offset = memory[address + 1]
            operand = UInt16(Int(Int8(bitPattern: offset)) + Int(address + 2))
        default:
            operand = 0
        }
        return operand
    }

    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        let operand = getOperand(address: address, instruction: instruction, memory: processor.memory)
        let formattedAddress = String(format: "%04x", address)
        let formattedOperand = formatOperand(operand: operand, addressMode: instruction.addressMode)
        print("\(formattedAddress) \(instruction.mnemonic) \(formattedOperand)")
    }
}

