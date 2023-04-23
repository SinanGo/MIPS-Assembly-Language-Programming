	.data
#menu messages:
menuStart:	.asciiz "\nWelcome to our MIPS project!\nMain Menu:\n1. Find Palindrome\n2. Reverse Vowels\n3. Find Distinct Prime\n4. Lucky Number\n5. Exit\nPlease select an option: "
menuEnd:	.asciiz "Program ends. Bye :)"
#program 1 spesific data

sub1: .space 1024
sub2: .space 1024
userstring: .space 1024
msgp1: .asciiz "Enter a string: "

#program 2 specific data
prg2inputPromt:		.asciiz "Input: "
prg2outputPromt: 	.asciiz "Output: "
prg2title:			.asciiz "Program 2: Reverse Vowels !!!\n"
prg2vowels: 		.ascii "aeiouAEIOU"

#program 3 spesific data
prg3enterNumber: 	.asciiz "enter a number: "
prg3squareFree: 		.asciiz " is a square free number and has two distinct prime factors: "
prg3notSquareFree: 	.asciiz " is not a square free number. \n"
prg3blank:			.asciiz " "
prg3alreadyPrime:	.asciiz " is a square free number because it is a prime number. \n"
prg3output:		.asciiz "Output: "
prg3nextLine:		.asciiz "\n"

#program 4 specific data
prg4inputPromt:		.asciiz "Enter the number of rows: "
prg4inputPromt2: 	.asciiz "Enter the number of columns: "
prg4inputPrompt3:	.asciiz "Enter the elements of the matrix one by one:\n"
prg4inputPrompt4:   .asciiz ": "
prg4outputPrompt:	.asciiz "The matrix should have only unique values.\n"
prg4outputPrompt2:	.asciiz "The lucky number is "
prg4title:			.asciiz "Program 4: Lucky Number !!!\n"



.text

main:
	la $a0, menuStart
	li $v0, 4
	syscall	#displaying menu

menu:
	li $v0, 5
	syscall	#reading user choice
	li $t0, 0
	move $t0, $v0
	beq $t0, 1, findPalindrome
	beq $t0, 2, reverseVowels
	beq $t0, 3, findDistinctPrime
	beq $t0, 4, luckyNumber
	beq $t0, 5, exitMenu
	
exitMenu:
	la $a0, menuEnd
	li $v0, 4
	syscall	#display bye bye
	li $v0, 10
	syscall


#>>>>>>>>>>>>>>> program 1 <<<<<<<<<<<<<<<<<<<<<<<

findPalindrome:
      li $v0,4
      la $a0, msgp1
      syscall
      
 
      li $v0,8
      la $a0,userstring
      li $a1, 20
      syscall
      


        la $a2, sub2
	la $a1, userstring
	li $t1, -1
	loop:
		lb $t0, ($a1)
		addi $a1, $a1, 1
		addi $t1, $t1, 1
		bne $t0, $zero, loop
	# a0 have the length
	move $a0, $t1
	la $a1, userstring
	
	
	addi $sp, $sp, -32	
	sw $s5, 28($sp)
	sw $ra, 24($sp)
	sw $a0, 20($sp)
	sw $s0, 16($sp)
	sw $s1, 12($sp)
	sw $s2, 8($sp)
	sw $s3, 4($sp)
	sw $s4, 0($sp)
        
        
        move $s2, $a0 # save length into s2
        move $s3, $a1 # save string into $s3
        move $s4, $zero # First Pointer of the palindrome
        addi $s5, $s4,1 # Second Pointer of the Palindrome
        li   $t6, 95  #t6=_ The char we are gonna replace in the string
        
         move $t1, $zero # i = 0
         move $s0, $zero # i = 0
  for1:  slt $t0, $s0, $s2 #  $t0 = 0 if $s0 > $s2 (i > n)
         beq $t0, $zero, exit1 # go to exit1 if $s0 ? $s2 (i ? n) leave the loop completly
         beq $t6, $t3, exit2 # go to exit2 if v[i]=_ go to next iteration of outer loop
         
         addi $s1, $s0,1 # j = i + 1
  for2:  slt $t0, $s1,$s2  # $t0 = 0 if $s2 < length (j < n)
         beq $t0, $zero, exit2 # go to exit1 if $s0 ? $s2 (i ? n)
         beq $t6, $t4, exit3 # go to exit3 if v[j]=_ go to next iteration of inner loop
         
         add $t1, $s3, $s0 # $t1 = v + (j )
         add $t2, $s3, $s1 # $t1 = v + (j )
         lb $t3, ($t1) # $t3 = v[i]
         lb $t4, ($t2) # $t4 = v[j]
         bne $t3,$t4 exit3  #t3!=t4 out of inner loop
         #inner loop if t3 and t4 is the same we need to first hold them in seperate adress
         add $t5, $a2, $s4 # t5 = a2 +s4 First Pointer Of palindrome
       
         add $t6, $a2, $s5 # t6 = a2 +s5 Second Pointer of Palidrome
         sb $t3,($t5) #Storing the byte into a2 location 
         sb $t3,($t6) #Storing the byte into a2 location
         addi $s4, $s4,-1 # s4 -=1 First Pointer going Backwards
         addi $s5, $s5, 1 # s5 += 1 Second Pointer going Forword
         #We stored Palindrome elements in out a2 location now we need to Replace the bytes that we used
         sb $t6,($t1) # v[i]=_
         sb $t6,($t2) # v[j]=_
         j exit2        
   
      
         
         exit3:
         addi $s1, $s1, 1 # j += 1
         j for2 # jump to test of inner loop
         exit2: addi $s0, $s0, 1 # i += 1
         j for1 # jump to test of outer loop
         
         exit1: 
         
        li $v0, 4              # syscall code for printing a string
        la $a0,($t5)          
        syscall               	
        
        lw $s5, 28($sp)
        lw $ra, 24($sp)
	lw $a0, 20($sp)
	lw $s0, 16($sp)
	lw $s1, 12($sp)
	lw $s2, 8($sp)
	lw $s3, 4($sp)
	lw $s4, 0($sp)
	addi $sp, $sp, 28
        
        j main
         
             


#>>>>>>>>>>>>>>> program 2 <<<<<<<<<<<<<<<<<<<<<<<

reverseVowels:
	addi $sp, $sp, -32	
	sw $ra, 28($sp)			# return address
	sw $a0, 24($sp)			# variable in isVowel function
	sw $s0, 20($sp)			# input string
	sw $s1, 16($sp)			# array of vowels in the input string
	sw $s2, 12($sp)			# charCountInStr
	sw $s3, 8($sp)			# vowelCountInStr
	sw $s4, 4($sp)			# Counter i
	sw $s5, 0($sp)			# vowels array
	
	la $a0, prg2title		# print program2 title
	li $v0, 4
	syscall
	
	li $a0, 128				# allocation of memory for input string
	li $v0, 9
	syscall
	move $s0, $v0
	
	li $a0, 128				# allocation of memory for vowelsInStr string (array of chars)
	li $v0, 9
	syscall
	move $s1, $v0
	
	move $s2, $zero			# charCountInStr -> 0
	move $s3, $zero			# vowelCountInStr -> 0
	move $s4, $zero			# Counter i -> 0
	la $s5, prg2vowels
	
	la $a0, prg2inputPromt	# input prompt
	li $v0, 4
	syscall
	
	la $a0, 0($s0)			# store the input string
	li $a1, 128				
	li $v0, 8
	syscall
	
	move $t0, $s0			# t0 is also holding the address of the first element

prg2findCharCountInStr:
	
	lb $t1, 0($t0)			# t1 is the element in the string
	beqz $t1, prg2charCountIsFound
	addi $t0, $t0, 1 		# t1 and s2(charCountInStr) is incremented by one
	addi $s2, $s2, 1
	
	j prg2findCharCountInStr
	
prg2charCountIsFound:		# after finding the size of the input string
	move $t0, $s0			# we continue with finding vowels in it.
	move $t1, $s1			# t0 is holding the address of the first element in the string
	j prg2loopFindVowelsInStr	# t1 is holding the address of the first element in vowelsInStr

prg2loopFindVowelsInStr:
	slt $t2, $s4, $s2			# t2 = 0 if i >= charCountInStr
	beqz $t2, prg2endLoopFindVowelsInStr
	
	lb $t3, 0($t0)
	move $a0, $t3
	jal prg2isItVowel
	
	beqz $v0, prg2continueLoopFindVowelsInStr	
	sb $t3, 0($t1)
	addi $t1, $t1, 1
	addi $s3, $s3, 1
	
prg2continueLoopFindVowelsInStr:
	addi $t0, $t0, 1
	addi $s4, $s4, 1
	j prg2loopFindVowelsInStr
	
prg2endLoopFindVowelsInStr:
	
	add $s4, $zero, $zero		# counter i is 0 again for another loop.
	move $t0, $s0			# we continue with replacing vowels in str.
	
	add $t1, $t1, -1			# t0 is holding the address of the FIRST element in the string
	j prg2loopReverseVowels	# t1 is holding the address of the LAST element in vowelsInStr
	
prg2loopReverseVowels:
	slt $t2, $s4, $s2
	beqz $t2, prg2endLoopReverseVowels
	
	lb $t3, 0($t0)					# start from the beginning in t0
	move $a0, $t3 					# start from the ending in t1 (vowels in input)
	jal prg2isItVowel				# if a vowel is faced in t0, replace it
									# with the element in t1 starting from last element 
	beqz $v0, prg2continueLoopReverseVowels
	
	lb $t4, 0($t1)
	sb $t4, 0($t0)
	addi $t1, $t1, -1
	
prg2continueLoopReverseVowels:
	addi $t0, $t0, 1
	addi $s4, $s4, 1
	j prg2loopReverseVowels

prg2endLoopReverseVowels:
	
	la $a0, prg2outputPromt		# output prompt
	li $v0, 4
	syscall
	
	move $a0, $s0		# result
	li $v0, 4
	syscall
	
	lw $ra, 28($sp)
	lw $a0, 24($sp)			
	lw $s0, 20($sp)			
	lw $s1, 16($sp)			
	lw $s2, 12($sp)			
	lw $s3, 8($sp)			
	lw $s4, 4($sp)
	lw $s5, 0($sp)
	addi $sp, $sp, 32
	j main
	
prg2isItVowel:
	addi $sp, $sp, -4        # allocate space on the stack
    sw $ra, 0($sp)           # save return address
    
    li $t5, 0                # initialize loop index
	
prg2isItVowelLoop:					#check if the character is vowel by
	beq $t5, 10, prg2notVowel		# checking its inclusion in vowels array
	
	lb $t6, prg2vowels($t5)			
	beq $a0, $t6, prg2isVowel
	addi $t5, $t5, 1
	j prg2isItVowelLoop
	
prg2isVowel:				# return $v0 
	li $v0, 1
	j prg2isItVowelEnd

prg2notVowel:
	li $v0, 0
	
prg2isItVowelEnd:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#>>>>>>>>>>>>>>> program 3 <<<<<<<<<<<<<<<<<<<

findDistinctPrime:
	jal distinctPrime
	j main

distinctPrime:
	addi $sp, $sp, -28	
	sw $ra, 24($sp)
	sw $a0, 20($sp)
	sw $s0, 16($sp)
	sw $s1, 12($sp)
	sw $s2, 8($sp)
	sw $s3, 4($sp)
	sw $s4, 0($sp)

	li $s0, 0		#division = 0
	li $s1, 2		#i (divider) = 2
	li $s2, 0		#squareFree = 0 boolean variable.
	li $s3, 0		#number = 0 (will be read from console)

	li $v0, 4		#printing prg3enterNumber string
	la $a0, prg3enterNumber
	syscall

	li $v0, 5			#reading int from console
	syscall
	move $s3, $v0		#assign the int value from console

	move $a0, $s3		#assign $s3 =  to isPrime function
	jal prg3isPrime		#jump and link to isPrime function.

	bne $v0, $zero, primeSquare		#If number is already prime, go to primeSquare function.
					
	addi $s4, $s3, 1		#calculating (number + 1) / 2
	srl $s4, $s4, 1		# for while( i<= half) C code.

prg3Loop:
	sle $t5, $s1, $s4		#checking while condition.
	bne $t5, 1, exitLoop		#if i > half, jump exitLoop

#Checking i can divide number. $t6 = remaining value. If 
#t6 = 0, means that i can divide number. 	
	div $s3, $s1			
	mfhi $t6				
	bne $t6, $zero, prg3incrI	#If t6!=0 , add 1 to i,

#If i can divide number, check that I is prime or not.
#If i is prime, go to check the division also prime.
	move $a0, $s1
	jal prg3isPrime
	bne $v0, $zero, prg3findDivision
	j prg3incrI

prg3incrI:			#This label increments i (divider) value.
	addi $s1, $s1, 1
	j prg3Loop

prg3findDivision:	#This label calculates the division value
	div $s3, $s1	# dividing number / i
	mflo $t7		# assigning division value to $t7
	move $a0, $t7
	jal prg3isPrime
	bne $v0, $zero, prg3checkEquality
	j prg3incrI

#If divider and division are distinct, print the msg, else
# increment i and do steps again.

prg3checkEquality:
	bne $s1, $t7, squareFree
	j prg3incrI

primeSquare:	#If number is already prime

	li $v0, 4
	la $a0, prg3output
	syscall

	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, prg3alreadyPrime
	syscall
	
	j prg3exit

squareFree:	#number has distinct prime factors

	li $v0, 4
	la $a0, prg3output
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, prg3squareFree
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, prg3blank
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall

	li $v0, 4
	la $a0, prg3nextLine
	syscall
	
	j prg3exit


notSquareFree:	#number not a prime or hasn't distinct primes

	li $v0, 4
	la $a0, prg3output
	syscall

	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, prg3notSquareFree
	syscall
	j prg3exit

exitLoop:		#This label exits while loop inside the main.
	bne $s2, 1, notSquareFree
	j squareFree


prg3exit:		#This label recalls ra and jumps to j main.	
	lw $ra, 24($sp)
	lw $a0, 20($sp)
	lw $s0, 16($sp)
	lw $s1, 12($sp)
	lw $s2, 8($sp)
	lw $s3, 4($sp)
	lw $s4, 0($sp)
	addi $sp, $sp, 24
	jr $ra

prg3isPrime:		#calculate given number is prime or not.

	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s0, 8($sp)
	
	move $s0, $a0
	
	sle $t1, $s0, 1			# $a0<= 1->number is not prime
	
	beq $t1, 1, prg3exit1		
	
	beq $s0, 2, prg3exit2		# $a0 = 2 or 3 number is prime
	beq $s0, 3, prg3exit2

	addi $t0, $zero, 1		#isPrime = 1 
	addi $t1, $zero, 2		#k = 2
	addi $t2, $s0, 1			#z = x + 1
	srl $t2, $t2, 1			#z = z / 2

prg3isPrimeWhile:
	sle $t3, $t1, $t2		#checking k <= z
	bne $t3, 1, prg3exit2		#if not, go to exit2
	div $s0, $t1
	mfhi $t4				#assign remaining to $t4
	beq $t4, $zero, prg3exit1	#if $t4=0, number is not prime
	addi $t1, $t1, 1
	j prg3isPrimeWhile

prg3exit1:	#indicates that the number is not prime.
	li $v0, 0
	j exitIsPrime

prg3exit2:	#indicates that the number is prime.
	li $v0, 1
	j exitIsPrime

exitIsPrime:	#loads saved values and return to $ra
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $s0, 8($sp)
	addi $sp, $sp, 12
	jr $ra

#>>>>>>>>>>>>>>> program 4 <<<<<<<<<<<<<<<<<<<

luckyNumber:
	
	addi $sp, $sp, -32	
	sw $ra, 28($sp)			# return address
	sw $a0, 24($sp)			# 
	sw $a1, 20($sp)			# 
	sw $a2, 16($sp)			# 
	sw $s0, 12($sp)			# row count
	sw $s1, 8($sp)			# column count
	sw $s2, 4($sp)			# address of array
	sw $s3, 0($sp)			# 
	
	
	la $a0, prg4title		# print program4 title
	li $v0, 4
	syscall
	
	la $a0, prg4inputPromt	# get number of rows from the console and store in $s0
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	la $a0, prg4inputPromt2	# get number of rows from the console and store in $s1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	mul $a0, $s0, $s1		# allocation of memory for integer array
	sll $a0, $a0, 2			# rows*columns*4bytes
	li $v0, 9				
	syscall
	move $s2, $v0			# $s2 is the starting point of the array
	
	mul $t0, $s0, $s1		# t0 -> rows*columns
	move $t1, $s2			# $t1 -> pointer to the matrix
	li $t2, 0				# $t2 -> counter for input loop 
	
	la $a0, prg4inputPrompt3		# enter the elements "ONE BY ONE"
	li $v0, 4
	syscall
	
prg4inputLoop:						# if end of file is reached, 
	beq $t2, $t0, prg4checkUnique	# continue with uniqueness check
	
	addi $a0, $t2, 1
	li $v0, 1
	syscall
	
	la $a0, prg4inputPrompt4
	li $v0, 4
	syscall
	
	li $v0, 5						
	syscall
	
	sw $v0, 0($t1)
	addi $t2, $t2, 1
	addi $t1, $t1, 4
	j prg4inputLoop
	
prg4checkUnique:
	move $t1, $s2			# t1 and t2 are pointing to the array of ints.
	move $t2, $s2			# t2 is one step further
	addi $t2, 4
	
	addi $t5, $zero, 1		# t5 -> outer loop counter
	addi $t6, $zero, 1		# t6 -> inner loop counter
	
prg4checkUniqueLoop1:
	beq $t5, $t0, prg4checkUniqueLoop1Exit
	
prg4checkUniqueLoop2:
	beq $t6, $t0, prg4checkUniqueLoop2Exit
	lw $t3, 0($t1)								# t3 -> current element in t1
	lw $t4, 0($t2)								# t4 -> current element in t2
	beq $t3, $t4, prg4notUnique
	addi $t6, $t6, 1
	addi $t2, $t2, 4
	j prg4checkUniqueLoop2
	
prg4checkUniqueLoop2Exit:					# for(int i = 1; i < arraySize; i++){
	addi $t5, $t5, 1							#	for(int j = 1; j < arraySize; j++){
	move $t6, $t5							#		if (*t1 == *t2)
	addi $t1, $t1, 4							#			goto notUnique
	move $t2, $t1							#		else
	addi $t2, $t2, 4							#			t2++
	j prg4checkUniqueLoop1					#	}	
											# t1++
prg4checkUniqueLoop1Exit:					# }
	j prg4findLuckyNumber
	
prg4notUnique:
	la $a0, prg4outputPrompt		# print uniqueness failure
	li $v0, 4
	syscall
	
	lw $ra, 28($sp)
	lw $a0, 24($sp)			 
	lw $a1, 20($sp)			 
	lw $a2, 16($sp)			 
	lw $s0, 12($sp)			
	lw $s1, 8($sp)			
	lw $s2, 4($sp)			
	lw $s3, 0($sp)			
	addi $sp, $sp, 32
	j main



prg4findLuckyNumber:
	
	move $t1, $zero
	
prg4findLuckyNumberLoop:
	beq $t1, $s0, prg4findLuckyNumberLoopExit
	
	sll $a0, $t1, 2
	mul $a0, $a0, $s1
	add $a0, $s2, $a0		# a0 points to the row
	move $a1, $s1			# a1 -> num of columns (lentgh of the row)
	
	jal prg4findSmallestInRow
	
	move $t2, $v0					# t2-> minimum in a row
	
	move $a0, $s2		# a0 points to the row
	move $a1, $t2		# a1 -> number to find index of
	
	jal prg4findIndex
	
	move $t3, $v0	# t3-> index of min
	
	divu $t3, $s1
	mfhi $t3			# t3-> column number of min
	
	mul $a0, $t3, 4 
	add $a0, $a0, $s2 	# a0 points to the start of the column
	move $a1, $s0		# a1 -> row count
	move $a2, $s1		# a2 -> column count
	
	jal prg4findBiggestInColumn
	
	move $t4, $v0 	# t4 -> max of column
	
	beq $t2, $t4, prg4YouAreLucky
	
	addi $t1, $t1, 1
	j prg4findLuckyNumberLoop
	
prg4YouAreLucky:
	
	la $a0, prg4outputPrompt2		# print result
	li $v0, 4
	syscall
	
	move $a0, $t4
	li $v0, 1
	syscall
	
	lw $ra, 28($sp)
	lw $a0, 24($sp)			 
	lw $a1, 20($sp)			 
	lw $a2, 16($sp)			 
	lw $s0, 12($sp)			
	lw $s1, 8($sp)			
	lw $s2, 4($sp)			
	lw $s3, 0($sp)			

	addi $sp, $sp, 32
	j main
	
prg4findLuckyNumberLoopExit:
	j main

	
prg4findSmallestInRow:
	addi $sp, $sp, -4       
    sw $ra, 0($sp)          
	
	lw $v0, 0($a0)			# v0 -> min element in the row
	move $t5, $zero
	prg4findSmallestInRowLoop:
		beq $t5, $a1, prg4findSmallestInRowLoopExit
		
		lw $t6, 0($a0)
		slt $t7, $t6, $v0
		
		bne $t7, $zero, prg4UpdateMin
		
		addi $t5, $t5, 1
		addi $a0, $a0, 4
		j prg4findSmallestInRowLoop
		
	prg4UpdateMin:
		move $v0, $t6
		addi $t5, $t5, 1
		addi $a0, $a0, 4
		j prg4findSmallestInRowLoop
		
	prg4findSmallestInRowLoopExit:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra



		
prg4findBiggestInColumn:

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lw $v0, 0($a0)		# v0 -> max element in the column
	move $t5, $zero
	prg4findBiggestInColumnLoop:
		beq $t5, $a1, prg4findBiggestInColumnLoopExit
		
		lw $t6, 0($a0)
		slt $t7, $t6, $v0
		bne $t7, $zero, prg4findBiggestInColumnLoopContinue
	
		move $v0, $t6
		addi $t5, $t5, 1
		sll $a2, $a2, 2
		add $a0, $a0, $a2
		j prg4findBiggestInColumnLoop
		
	prg4findBiggestInColumnLoopContinue:
		addi $t5, $t5, 1
		sll $a2, $a2, 2
		add $a0, $a0, $a2
		j prg4findBiggestInColumnLoop
	
	prg4findBiggestInColumnLoopExit:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra


prg4findIndex:
	addi $sp, $sp, -4       # allocate space on the stack
    sw $ra, 0($sp)          # save return address
	
	move $t5, $zero	
	prg4findIndexLoop:
		lw $t6, 0($a0)
		beq $t6, $a1, prg4findIndexLoopExit
		addi $t5, $t5, 1
		addi $a0, $a0, 4
		
	prg4findIndexLoopExit:
		move $v0, $t5
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra