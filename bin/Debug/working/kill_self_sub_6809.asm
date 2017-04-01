
; machine generate routine from XML file
kill_self_sub
	pshs d,x,y
	nop ; println("IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.")
	ldx #description_table
	lda #45 ; IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

