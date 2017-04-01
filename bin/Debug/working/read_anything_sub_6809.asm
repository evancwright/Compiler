
; machine generate routine from XML file
read_anything_sub
	pshs d,x,y
	nop ; println("THERE IS NOTHING TO READ ON THAT.")
	ldx #description_table
	lda #61 ; THERE IS NOTHING TO READ ON THAT.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

