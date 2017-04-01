
; machine generate routine from XML file
hit_with_fists_sub
	pshs d,x,y
	nop ; println("YOUR FISTS DON'T DO MUCH DAMAGE.")
	ldx #description_table
	lda #53 ; YOUR FISTS DON'T DO MUCH DAMAGE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

