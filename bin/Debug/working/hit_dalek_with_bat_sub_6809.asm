
; machine generate routine from XML file
hit_dalek_with_bat_sub
	pshs d,x,y
	nop ; println("TBD")
	ldx #description_table
	lda #60 ; TBD
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

