
; machine generate routine from XML file
enter_tardis_sub
	pshs d,x,y
	nop ; test ((tardis.open == 1))
	lda #1
	pshs a    ; push right side
	lda #3
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax PROPERTY_BYTE_1,x  ; 
	lda ,x  ; get property byte
	anda #32 ; isolate open  bit 
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; player.holder = inside tardis
	lda #4 ; inside tardis
	pshs a ; save value to put in attr
	lda #1 ; player
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; look()
	jsr look_sub
	bra @b ; skip else 
@a	nop ; close (tardis.open == 1)
	nop ; { println("THE TARDIS IS CLOSED.")
	ldx #description_table
	lda #62 ; THE TARDIS IS CLOSED.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
@b	nop ; end else
	puls y,x,d
	rts

