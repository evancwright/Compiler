
; machine generate routine from XML file
talk_to_self_sub
	pshs d,x,y
	nop ; println("TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.")
	ldx #description_table
	lda #47 ; TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	puls y,x,d
	rts

