;z80 - print returns
;these are long jumped to, not 'called'

print_ret_pardon
	ld hl,pardon
	call OUTLIN
	call printcr
	ret

print_ret_no_io
	ld hl,missing_io 
	call OUTLIN
	call printcr
	ret
	
	
print_ret_bad_verb
	ld hl,badverb
	call OUTLIN
	ld hl,word1
	call OUTLIN
	ld hl,period
	call OUTLIN	
	call printcr
	ret

print_ret_bad_do
	ld hl,badnoun
	call OUTLIN
	ld hl,word2
	call OUTLIN
	ld hl,period
	call OUTLIN	
	call printcr
	ret

print_ret_bad_io
	ld hl,badnoun
	call OUTLIN
	ld hl,word4
	call OUTLIN
	ld hl,period
	call OUTLIN	
	call printcr
	ret
	
badnoun DB "I DON'T RECOGNIZE THE WORD '"
	DB 0 ; null	
	
badverb DB "I DON'T KNOW THE VERB '"
	DB 0 ; null	
	
missing_io DB "IT LOOKS LIKE YOU ARE MISSING THE OBJECT OF THE PREPOSITION."
	DB 0 ; null
	
pardon DB "PARDON"
	DB 3fh
	DB 0 ; null
		
period DB "'."
	DB 0 ; null
		