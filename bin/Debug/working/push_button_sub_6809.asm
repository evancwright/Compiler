
; machine generate routine from XML file
push_button_sub
	pshs d,x,y
	nop ; test ((elevator.e == lobby))
	lda #14 ; lobby
	pshs a    ; push right side
	lda #15 ; elevator
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 6,x  ; e
	lda ,x
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; println("THE LIFT SLOWLY RISES TO THE UPPER FLOOR.")
	ldx #description_table
	lda #63 ; THE LIFT SLOWLY RISES TO THE UPPER FLOOR.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("THE DOOR OPENS, LEADING EAST TO A HALLWAY.")
	ldx #description_table
	lda #64 ; THE DOOR OPENS, LEADING EAST TO A HALLWAY.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; elevator.e = hallway
	lda #17 ; hallway
	pshs a ; save value to put in attr
	lda #15 ; elevator
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 6,x   ;e
	puls a ; restore rhs
	sta ,x
	bra @b ; skip else 
@a	nop ; close (elevator.e == lobby)
	nop ; println("THE LIFT SLOWLY DESCENDS FLOOR.")
	ldx #description_table
	lda #65 ; THE LIFT SLOWLY DESCENDS FLOOR.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("THE DOOR OPENS, LEADING EAST TO THE LOBBY.")
	ldx #description_table
	lda #66 ; THE DOOR OPENS, LEADING EAST TO THE LOBBY.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; elevator.e = lobby
	lda #14 ; lobby
	pshs a ; save value to put in attr
	lda #15 ; elevator
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 6,x   ;e
	puls a ; restore rhs
	sta ,x
@b	nop ; end else
	puls y,x,d
	rts

