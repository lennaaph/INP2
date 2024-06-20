# Design of computer systems - 2.project

## Vernam Cipher Implementation on MIPS64

### Overview

This project implements a modified Vernam cipher using MIPS64 instructions and the EduMIPS64 simulator. The cipher substitutes each plaintext letter with a corresponding key letter using modular arithmetic. It encrypts a login string of lowercase letters and digits by applying cyclic shifts defined by the key and outputs the encrypted text.

## Project Structure

The project is divided into two main sections: the Data Segment and the Code Segment.

### Data Segment

The data segment is responsible for defining and storing the required data.

- **Login**: The user's login string that will be encrypted.
- **Cipher**: Space allocated for storing the encrypted version of the login.
- **Params_sys5**: Space allocated to store the address of the string to be printed using syscall 5 (print_string function).

### Code Segment

The code segment contains the main logic for the encryption process using the Vernam cipher.

#### Registers Used:
- **r0**: Always holds the value zero.
- **r2**: Used as a helper for subtraction operations.
- **r4**: Used as a counter and for holding the cipher address.
- **r12**: Used for comparisons.
- **r19**: Holds each character from the login for encryption.
- **r26**: Used as a counter for tracking the position in the login string.

## Notes

- The program includes bounds checking to ensure the transformed characters remain within the valid ASCII range for letters.
