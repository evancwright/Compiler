;z80 - print returns
;these are long jumped to, not 'called'

print_ret_pardon
	ld hl,pardon
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

badword DB "I DON'T RECOGNIZE THE WORD '"
	DB 0 ; null	
	
badverb DB "I DON'T KNOW THE VERB '"
	DB 0 ; null	
	
pardon DB "PARDON"
	DB 3fh
	DB 0 ; null
		
period DB "'."
	DB 0 ; null
		