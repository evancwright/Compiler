
; machine generate routine from XML file
follow_player_event
	pshs d,x,y
	nop ; test ((activated==1))
	lda activated ; activated
	pshs a    ; push right left
	lda #1 ; 1
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; test ((dalek.holder != 0))
	lda #0 ; 0
	pshs a    ; push right side
	lda #22 ; dalek
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
	nop ; println("THE DALEK IS FOLLOWING YOU.")
	ldx #description_table
	lda #40 ; THE DALEK IS FOLLOWING YOU.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; dalek.holder = player.holder
nop ; setting up rhs attribute
	lda #1 ; player
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x  ; holder
	lda ,x
	pshs a ; save value to put in attr
	lda #22 ; dalek
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
@b	nop ; close (dalek.holder != 0)
@a	nop ; close (activated==1)
	puls y,x,d
	rts

