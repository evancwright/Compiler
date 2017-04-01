
; machine generate routine from XML file
judoon_rule_event
	pshs d,x,y
	nop ; test ((player.holder == lobby))
	lda #14 ; lobby
	pshs a    ; push right side
	lda #1 ; player
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
	nop ; test ((mannequin.holder != 0))
	lda #0 ; 0
	pshs a    ; push right side
	lda #19 ; mannequin
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
	nop ; println("AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE."
	ldx #description_table
	lda #41 ; AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; player.holder = north street
	lda #7 ; north street
	pshs a ; save value to put in attr
	lda #1 ; player
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
@b	nop ; close (mannequin.holder != 0)
@a	nop ; close (player.holder == lobby)
	puls y,x,d
	rts

