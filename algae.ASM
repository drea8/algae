
section .data
;;; * database	
;;; ;;;;;;;;;;;;;;;;;;;;;;;; Syscall Constants
	NULL equ 0
	LINEFEED equ 10
	TRUE equ 1	
	STDIN equ 0
	STDOUT equ 1
	STDERR equ 2	
	SYS_read equ 0
	SYS_write equ 1
	SYS_open equ 2
	SYS_close equ 3
	SYS_fork equ 57	
	SYS_exit equ 60
	SYS_creat equ 85
	SYS_time equ 201	
	O_WRONLY equ 000001q
	S_IWUSR equ 00200q
	S_IRUSR equ 00400q
;;; ;;;;;;;;;;;;;;;;;;;; Flat Mem, Regs, & Dataflow	
	aReg db 0
	bReg db 0	
	cReg db 0
	ain equ 8
	bin equ 9
;;; Channel and Flat Memory Buffers
	msgLen db 16
	;; msg_buf db ".", NULL
	
	;; mem_len db 32
	;; mem_buf db ".................."
	;; mem_buf2 db ".................."

;;;  ^ flat mem buf yasm repeat?
	
;;; file and stdlib handles
	fileDesc dq 0
	fileName db 'out.buf', NULL
	readFileName db 'read.buf', NULL
	msg db "L k F x Refal!", LINEFEED
	stdi_buf db "00000000000000"

;;; ;;;;;;;;;;;;;;;;;;;;; Program	
section .text
	global _start
_start:	
	mov al, byte [aReg]
	add al, byte [bReg]
	mov byte [cReg], al
;;; ;;;;;;;;;;;;;;;;;;;;;; STDOUT
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, qword [msgLen]
	syscall
;;; ;;;;;;;;;;;;;;;;;;;;;; out.buf write (fileName)

	
;;;  open file handle for Read & Write
	mov rax, SYS_creat
	mov rdi, fileName
	mov rsi, S_IRUSR | S_IWUSR	
	syscall
	
;; write msg of msgLen to file handle buf?
	mov qword [fileDesc], rax	
	mov rax, SYS_write
	mov rdi, qword [fileDesc]

;;;  Summation Program
	mov ecx, ain
	add ecx, bin
	add ecx, bin	
	mov [msg], ecx
	
	mov rsi, msg
	;; write one byte of result to file
	mov rdx, 1
	syscall

;;;  REPL SECTION
repl:
	
;;; (read eval)
	xor eax, eax ; rax <- 0 syscall
	xor edi, edi ; rdi <- 0 stdin
	mov rsi, stdi_buf ; rsi <- buf_addr
	mov rdx, 5 ; rdx <- buf_siz
	syscall	
;;;  (buf read)
	mov rax, 1
	mov rdi, 1
	mov rsi, stdi_buf
	mov rdx, 10
	syscall
;;;  linux read file asm syscall		
;; End int to str out	
	jmp repl
;;; END REPL SECTION
skip:	
;;; ;;;;;;;;;;;;;;;;;;;;; SYS_exit
	mov rax, 60
	mov rdi, 0
	syscall	

;;; and or xor not dov mul inc cmp jne jge
;;; SCAS 
;;; CMPS 
