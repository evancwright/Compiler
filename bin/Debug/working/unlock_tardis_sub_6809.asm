
; machine generate routine from XML file
unlock_tardis_sub
	pshs d,x,y
	nop ; test ((sonic screwdriver.holder==player))
	lda #1 ;player
	pshs a    ; push right side
	lda #26 ; sonic screwdriver
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x  ; holder
	lda ,x
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; println("(WITH SONIC SCREWDRIVER)")
	ldx #description_table
	lda #69 ; (WITH SONIC SCREWDRIVER)
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; call unlock_tardis_with_sonicscrewdriver()
	bra @b ; skip else 
@a	nop ; close (sonic screwdriver.holder==player)
	nop ; println("YOU HAVE NOTHING TO UNLOCK IT WITH.")
	ldx #description_table
	lda #70 ; YOU HAVE NOTHING TO UNLOCK IT WITH.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
@b	nop ; end else
	puls y,x,d
	rts

