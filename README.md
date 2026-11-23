# FISHINIPARSER
Hello there! I made this parser for hack club phantom program, and here i will show you how to use it.
The function is: **parseini** and here is the structure of the command: **parseini [FILEPATH] [SECTION] [KEY] \[REPLACEMENT_KEY](OPTIONAL)**
The help prompt displays this: 
```
Usage: parseini [FILEPATH] [SECTION] [KEY] [REPLACEMENT_KEY](OPTIONAL)

            Options:
            --list_sections List all sections
            --set Replaces the value of the key selected with [REPLACEMENT_KEY]
            --help|-h  Print help.
```
And i think you already understtod what all the functions do. Unfortunately i had some trouble with fish and had to end the project earlier than expected, but i've still managed to pack in some functions. Enjoy using the program!
# Oh, and another thing
This script runs in fish shell, so you should:
1. Install WSL(if you are using windows. If you're on Linux, then proceed to the next step).
2. Install Fish shell
3. Run the script
And that's it!
**DISCLAIMER**
This script can save the comments written in the ini file but not the comments that are in between keys in a section. E.g.:
```
[App]
version=1.2.1
# This is a comment
release=1.2
```