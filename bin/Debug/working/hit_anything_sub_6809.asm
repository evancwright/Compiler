
; machine generate routine from XML file
hit_anything_sub
	pshs d,x,y
	nop ; println("YOUR HANDS DON'T DO MUCH DAMAGE.")
	ldx #description_table
	lda #56 ; YOUR HANDS DON'T DO MUCH DAMAGE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

