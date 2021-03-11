# MipsStringCompression
Data Compression (45 points): Write a MIPS assembly program in the MARS simulator that accepts an input string of size less than 40 characters, and applies the following compression algorithm to the string, and then prints the resulting compressed string. The input string will only consist of alphabets, i.e., a-z and A-Z. First check the string to make sure it's a valid input (if not, print an error message and quit). Then walk through the string looking for consecutive occurrences of the same character and replace them with the character and a count (called a "run length encoding"). For example, if you see AAAAA, you would replace them with A5. If you see BBBBBBBBBBBB, you would replace them with B12. Note that the number 12 is represented as characters "1" and "2" within the output string. Single character occurrences do not need a count. For reference, here is an ASCII table. Here is an example run of the program: Provide an input string with less than 40 characters and only containing a-z or A-Z: AACCCCCGTTTTTTTTTTTTTTAAAabbcd The compressed string is: A2C5GT14A3ab2cd
