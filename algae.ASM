
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
;;; ;;;;;;;;;;;;;;;;;;;; Registers & Dataflow	
	aReg db 0
	bReg db 0	
	cReg db 0
;;; 
	fileDesc dq 0
	fileName db 'out.buf', NULL
	dispBuf db 'disp.buf', NULL
;;; asmbla string follow source for refal proecss relate to paper l k f x writing hand compile func
;;; calculation hand calculate vector assembly calculation, hand assembler macro refal sty lisp
;;; prolog solver common lisp to gen formal prove hand write matr calc	
;;;  FLAT MEMORY and Display Buffers	
	msg db "L k F x Refal!", LINEFEED
	stdi_buf db 5
	displayBuf db "oxxoooooo!", LINEFEED
	herBuf db "0000000000", LINEFEED
	goalBufC db "(compiler documentation)",LINEFEED
;;;  Documentation Buffers	
	docBuf1 db "(ALGAE - the alebraic-geometric automata environment)",LINEFEED
	docBuf2 db "(we want an automata/group theoretic geom solver)",LINEFEED	
	docBuf3 db "(we want to represent data cleanly, data entry repl?)",LINEFEED	
;;;  <---AX
	docBuf4 db "(SYM entry)",LINEFEED
	;; how to allocate buffers?
;;;  <---
	docBuf5 db "(print list of SYMs)",LINEFEED
	docBuf6 db "(compile sym cons cell run ASM program)",LINEFEED
	curStatus db "(a repl input -> buf store -> print loop)",LINEFEED
;;; bitmap buffer
;;;  lisp asm macro assmebler?
	otherBuf1 db "                "

	otherBuff db "0000000000"
;;;  end bitmap buffer
;;; Channel Buffers
	bufLen db 2
	msgLen db 16	
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
	mov rsi, msg
	mov rdx, [msgLen]
	syscall
	
;; ;;;  fileDesc displayBuf bufLen sys_write 	
;; 	mov rax, SYS_write
;; 	mov rdi, qword [fileDesc]
;; 	mov rsi, displayBuf
;; 	mov rdx, qword [bufLen]
;; 	syscall
;; 	jmp skip
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
	mov rdx, qword [msgLen]
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
