
; machine generate routine from XML file
setupAttack_event
	pshs d,x,y
	nop ; test ((mannequinAttack==0))
	lda mannequinAttack ; mannequinAttack
	pshs a    ; push right left
	lda #0 ; 0
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; test ((player.holder==13))
	lda #13 ;13
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
	lbne @b
	nop ; println("MOVING MANNEQUIN")
	ldx #description_table
	lda #23 ; MOVING MANNEQUIN
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; set(mannequinAttack,1)
	pshs a
	lda #1 ; load new val
	sta mannequinAttack ; store it back
	puls a
	nop ; mannequin.holder=supply room
	lda #14 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	lda #11
	sta ,x
	nop ; mannequin.description="THOUGH PLASTIC, THE MANNEQUIN IS OBVIOUSLY ALIVE AND DANGEROUS."
	lda #14 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 3,x   ;description
	lda #24
	sta ,x
	nop ; mannequin.initial_description="THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	lda #14 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 2,x   ;initial_description
	lda #25
	sta ,x
@b	nop ; close (player.holder==13)
@a	nop ; close (mannequinAttack==0)
	puls y,x,d
	rts

