
; machine generate routine from XML file
hit_mannequin_with_bat_sub
	pshs d,x,y
	nop ; println("WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.")
	ldx #description_table
	lda #57 ; WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("ROSE STAGGERS TO HER FEET.")
	ldx #description_table
	lda #58 ; ROSE STAGGERS TO HER FEET.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; mannequin.holder = 0
	lda #0 ; 0
	pshs a ; save value to put in attr
	lda #19 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; torso.holder=inventory room
	lda #12 ; inventory room
	pshs a ; save value to put in attr
	lda #25 ; torso
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; plastic head.holder=inventory room
	lda #12 ; inventory room
	pshs a ; save value to put in attr
	lda #24 ; plastic head
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; rose.initial_description = "ROSE IS HERE CHECKING THE INVENTORY."
	lda #59 ; "ROSE IS HERE CHECKING THE INVENTORY."
	pshs a ; save value to put in attr
	lda #21 ; rose
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 2,x   ;initial_description
	puls a ; restore rhs
	sta ,x
	nop ; add(score,10)
	pshs a
	lda score
	pshu a ; push var value
	lda #10 ; push val to add
	adda ,u ; add it 
	sta score ; store it back
	pulu a ; remove temp
	puls a
	puls y,x,d
	rts

