
; machine generate routine from XML file
listen_sub
	pshs d,x,y
	nop ; println("YOU HEAR NOTHING UNEXPECTED.")
	ldx #description_table
	lda #48 ; YOU HEAR NOTHING UNEXPECTED.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

