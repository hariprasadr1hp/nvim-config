; Assembly (x86) example to test editor settings
section .data
    hello_msg db 'Hello, Assembly!', 0xA   ; Define a message with a newline
    hello_len equ $ - hello_msg            ; Length of the message

section .bss
    num resb 1                            ; Reserve 1 byte for input

section .text
    global _start                         ; Declare the entry point for the linker

_start:
    ; Write the hello message to stdout (file descriptor 1)
    mov eax, 4                            ; syscall number for sys_write
    mov ebx, 1                            ; file descriptor 1 (stdout)
    mov ecx, hello_msg                    ; address of the string
    mov edx, hello_len                    ; length of the string
    int 0x80                              ; interrupt to make the syscall

    ; Read a byte from stdin (file descriptor 0)
    mov eax, 3                            ; syscall number for sys_read
    mov ebx, 0                            ; file descriptor 0 (stdin)
    mov ecx, num                          ; buffer to store input
    mov edx, 1                            ; number of bytes to read
    int 0x80                              ; interrupt to make the syscall

    ; Exit the program
    mov eax, 1                            ; syscall number for sys_exit
    xor ebx, ebx                          ; return code 0
    int 0x80                              ; interrupt to make the syscall

