
; machine generate routine from XML file
take_portable_sub
	pshs d,x,y
	nop ; test (($dobj.portable==1))
	lda #1
	pshs a    ; push right side
	lda sentence+1
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax PROPERTY_BYTE_2,x  ; 
	lda ,x  ; get property byte
	anda #1 ; isolate portable  bit 
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; test (($dobj.holder != player))
	lda #1 ; player
	pshs a    ; push right side
	lda sentence+1 ; $dobj
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
	lbeq @b
	nop ; println("(TAKEN)")
	ldx #description_table
	lda #53 ; (TAKEN)
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; $dobj.holder = player
	lda #1 ; player
	pshs a ; save value to put in attr
	lda #-1 ; $dobj
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
@b	nop ; close ($dobj.holder != player)
@a	nop ; close ($dobj.portable==1)
	puls y,x,d
	rts

