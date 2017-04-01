
; machine generate routine from XML file
jump_sub
	pshs d,x,y
	nop ; println("WHEEE!")
	ldx #description_table
	lda #52 ; WHEEE!
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

