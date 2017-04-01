
; machine generate routine from XML file
get_torso_sub
	pshs d,x,y
	nop ; println("THE TORSO IS TOO HEAVY TO PICK UP.")
	ldx #description_table
	lda #54 ; THE TORSO IS TOO HEAVY TO PICK UP.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

