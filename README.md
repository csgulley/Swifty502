# Swifty502
Swifty502 is a 6502 emulator written in Swift. The 6502 processor and variants were used in many popular platforms including the Apple II, Commodore 64, Atari 2600 and Nintendo Entertainment System.

It was developed as a component of a larger project and we are releasing it in case it is useful in other projects.
## Getting Started
You can add Swifty502 to your project using Swift Package Manager:
```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(
      url: "https://github.com/csgulley/Swifty502", 
      from: "0.5.0"
    )
  ],
  targets: [
    .target(
      name: "MyTarget",
      dependencies: [
        .product(name: "Swifty502", package: "Swifty502")
      ]
    )
  ]
)
```
Look at the SampleApp target for an example on how to configure and start the emulator.
## Supported Platforms
Swifty502 has been tested on macOS, Linux and iOS.
## 6502 Compatibility
Swifty502 implements the instruction set of the original MOS 6502. Its ADC/SBC implementation is also intended to be compatible with the MOS 6502. Instructions and other changes introduced by the 65C02 and other variants are not implemented.

No undocumented instructions are currently implemented and the processor exits when one is encountered. If needed, though, you can add instruction handlers with Processor.addInstruction. For a given opcode the last instruction added wins.
## Testing
Basic unit tests are included with the project. Additionally, the Klaus6502Tests target can be used to run the tests created by Klaus Dormann and Bruce Clark.

Swifty6502 is part of a basic Apple IIe emulator that runs well enough to load and run *Hitchhiker's Guide to the Galaxy.*
## Performance
Performance has not been a high development priority so far and not much benchmarking has been done. On my MacBook Pro it does around 8 MIPS running the Klaus Dormann tests. If anyone does any performance testing I'd be interested in the results.

## Licensing
Swifty502 is licensed under GPLv3. 

## Acknowledgements
The following resources were helpful in creating this project:
* [apple2js](https://github.com/whscullin/apple2js) Apple II emulator written in JavaScript and HTML5
* [AppleWin](https://github.com/AppleWin/AppleWin) Apple II emulator for Windows
* [KEGS](http://kegs.sourceforge.net/) Apple IIgs emulator
* [Klaus Dormann and Bruce Clark 6502 Tests](https://github.com/amb5l/6502_65C02_functional_tests) 6502 tests modified by Adam Barnes for cc65
* [6502.org](http://www.6502.org/tools/emu/) 6502 resources
* [6502 Instruction Set](https://www.masswerk.at/6502/6502_instruction_set.html) Summary of 6502 instructions
* [Easy 6502](https://skilldrick.github.io/easy6502/) Online 6502 emulator
* [Virtual \]\[](https://www.virtualii.com/) Apple II emulator
