
; machine generate routine from XML file
yell_sub
	pshs d,x,y
	nop ; println("AAAAAAAAAAAAARRRRGGGGGG!")
	ldx #description_table
	lda #51 ; AAAAAAAAAAAAARRRRGGGGGG!
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

