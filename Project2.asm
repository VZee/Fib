TITLE Fibonacci     (Project2.asm)

; Author: Louisa Katlubeck
; OSU email: katlubel@oregonstate.edu
; CS 271-400 Project 2                 Due Date: 1/28/2018
; Description: This program prompts the user to enter a number
; between 1 and 46, validates the user input (n), and then calculates
; and displays the Fibonacci numbers up to and including the nth term.

INCLUDE Irvine32.inc

.const
; min and max number of Fibonacci numbers to calculate
	MIN			EQU		1
	MAX			EQU		46

.data

; greeting and instructions to the user and closing message
	greeting1	BYTE	"Welcome to Project2.asm. My name is Louisa Katlubeck. What's your name? ", 0
	greeting2	BYTE	"Thanks for joining us, ", 0
	description	BYTE	"Today we're going to be calculating Fibonacci numbers. ", 0
	instruct	BYTE	"Please enter number of Fibonacci numbers you would like to calculate (between 1 and 46): ", 0
	error		BYTE	"Out of range. ", 0
	thanks		BYTE	"Thanks, ", 0
	goodbye		BYTE	", goodbye!", 0
	space		BYTE	"           ", 0
	extraSpace1	BYTE	" ", 0
	extraSpace2	BYTE	"  ", 0
	extraSpace3	BYTE	"   ", 0
	extraSpace4	BYTE	"    ", 0
	extraSpace5	BYTE	"     ", 0
	extraSpace6	BYTE	"      ", 0
	extraSpace7	BYTE	"       ", 0
	extraSpace8	BYTE	"        ", 0
	extraSpace9	BYTE	"         ", 0
	extraCredit	BYTE	"**EC: The program aligns the Fibonacci sequence in columns.", 0

; user-entered input
	userName	BYTE	33 DUP(0)
	num			DWORD	?

; Fibonacci numbers
	previous	DWORD	?
	current		DWORD	?
	temp		DWORD	?

	count		DWORD	?
	plusPlus	DWORD	1

.code
main PROC

; introduction
; welcome message to the user and get their name
	mov		edx, OFFSET greeting1
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, 32
	call	ReadString
	call	CrLf

; greet the user and describe the program
	mov		edx, OFFSET greeting2
	call	WriteString

	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf
	call	CrLf

; user instructions
	mov		edx, OFFSET description
	call	WriteString
	call	CrLf
	mov		edx, OFFSET	extraCredit
	call	WriteString
	call	CrLf
	call	CrLf

; get user data
; get the number from the user; repeat if invalid input entered

inputAgain:
	mov		edx, OFFSET instruct
	call	WriteString
	call	ReadInt
	mov		num, eax
	call	CrLf

; check to make sure the number entered by the user is between 1 and 46
; check that n is >= 1
	cmp		eax, MIN
	JL		errorMsg

; check that n is <= 46
	cmp		eax, MAX
	JG		errorMsg

; if the input is good, calculate the Fibonacci sequence and go to the closing message
; set the count equal to num and set ecx equal to count
	mov		eax, num
	mov		count, eax
	mov		ecx, count

; set the previous number equal to 0
	mov		eax, 0
	mov		previous, eax

; set the current number equal to 1 
	mov		eax, 1
	mov		current, eax

; display Fibs
; compute the next Fibonacci number and display to the screen
; while the current count is less than or equal to the number of Fibonacci numbers to be computed
FibLoop:
; display the Fibonacci number (display fibs)
	mov		eax, current
	call	WriteDec
	mov		edx, OFFSET space
	call	WriteString

; see how many spaces are needed for column alignment
	jmp		findSpaces

noSpaceNeeded:
; see if we are starting a new row (program outputs 5 columns per row)
	mov		eax, count
	mov		ebx, 5
	sub		edx, edx
	div		ebx
	cmp		edx, 0
	jne		noCrLf
	call	CrLf

noCrLf:
; calculate the current number 
	mov		eax, current
	mov		temp, eax

; compute the next Fibonacci number (our new current number)
	mov		ebx, previous
	add		eax, ebx
	mov		current, eax

; update the previous Fibonacci number
	mov		eax, temp
	mov		previous, eax

; increment count
	mov		eax, count
	mov		ebx, plusPlus
	add		eax, ebx
	mov		count, eax

; loop back to the top of the FibLoop
	loop	FibLoop

; after finding the requested number of Fibonacci numbers go to the closing message
	jmp		closingMsg;

findSpaces:
; calculate extra spaces needed for column alignment
	cmp		eax, 1000000000
	jge		noSpaceNeeded

	cmp		eax, 100000000
	jge		oneSpace

	cmp		eax, 10000000
	jge		twoSpaces

	cmp		eax, 1000000
	jge		threeSpaces

	cmp		eax, 100000
	jge		fourSpaces

	cmp		eax, 10000
	jge		fiveSpaces

	cmp		eax, 1000
	jge		sixSpaces

	cmp		eax, 100
	jge		sevenSpaces

	cmp		eax, 10
	jge		eightSpaces

	cmp		eax, 1
	jge		nineSpaces

oneSpace:
	mov		edx, OFFSET extraSpace1
	call	WriteString
	jmp noSpaceNeeded

twoSpaces:
	mov		edx, OFFSET extraSpace2
	call	WriteString
	jmp noSpaceNeeded

threeSpaces:
	mov		edx, OFFSET extraSpace3
	call	WriteString
	jmp noSpaceNeeded

fourSpaces:
	mov		edx, OFFSET extraSpace4
	call	WriteString
	jmp noSpaceNeeded

fiveSpaces:
	mov		edx, OFFSET extraSpace5
	call	WriteString
	jmp noSpaceNeeded

sixSpaces:
	mov		edx, OFFSET extraSpace6
	call	WriteString
	jmp noSpaceNeeded

sevenSpaces:
	mov		edx, OFFSET extraSpace7
	call	WriteString
	jmp noSpaceNeeded

eightSpaces:
	mov		edx, OFFSET extraSpace8
	call	WriteString
	jmp noSpaceNeeded

nineSpaces:
	mov		edx, OFFSET extraSpace9
	call	WriteString
	jmp noSpaceNeeded

; print the error message and have the user re-enter a number
errorMsg:
	mov		edx, OFFSET error
	call	WriteString
	call	CrLf
	call	CrLf
	jmp		inputAgain

; farewell
closingMsg:
; closing message
	call	CrLf
	call	CrLf
	mov		edx, OFFSET thanks
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET goodbye
	call	WriteString
	call	CrLf
	call	CrLf

	exit	; exit to operating system
main ENDP

END main
