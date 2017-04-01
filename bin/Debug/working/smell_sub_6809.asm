
; machine generate routine from XML file
smell_sub
	pshs d,x,y
	nop ; println("YOU SMELL NOTHING UNEXPECTED.")
	ldx #description_table
	lda #49 ; YOU SMELL NOTHING UNEXPECTED.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

