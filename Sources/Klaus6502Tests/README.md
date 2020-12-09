# Tests by Klaus Dormann and Bruce Clark

This target is configured to run the 6502 tests by Klaus Dormann and Bruce Clark. The original tests are
here: https://github.com/Klaus2m5/6502_65C02_functional_tests
<br><br>
However, since the assembler used for that project is no longer available, the files included here are based on a
version updated to use cc65: https://github.com/amb5l/6502_65C02_functional_tests
<br><br>
cc65 is available here: https://github.com/cc65/cc65

## Building Tests
The binaries are not included in this project but can be built as follows.

> $ca65 -l 6502_functional_test.lst 6502_functional_test.ca65<br>
> $ld65 6502_functional_test.o -o 6502_functional_test.bin -m 6502_functional_test.map -C functional.cfg<br>
> <br>
> $ca65 -l 6502_decimal_test.lst 6502_decimal_test.ca65<br>
> $ld65 6502_decimal_test.o -o 6502_decimal_test.bin -m 6502_decimal_test.map -C decimal.cfg<br>

## Klaus Dormann Tests
The Dormann tests end by looping forever on a given address so an interceptor is provided that checks for this
condition and then prints the address. You can check the generated .lst file to see how the test ended.

## Bruce Clark Tests
I modified the Bruce Clark to end with a BRK instruction that stops the processor and prints a 0 or 1 status code.

