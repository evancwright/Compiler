
; machine generate routine from XML file
cover_eye_sub
	pshs d,x,y
	nop ; println("YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.")
	ldx #description_table
	lda #71 ; YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.")
	ldx #description_table
	lda #72 ; IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'")
	ldx #description_table
	lda #73 ; 'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.")
	ldx #description_table
	lda #74 ; THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; eyestalk.holder=0
	lda #0 ; 0
	pshs a ; save value to put in attr
	lda #27 ; eyestalk
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; add(score,25)
	pshs a
	lda score
	pshu a ; push var value
	lda #25 ; push val to add
	adda ,u ; add it 
	sta score ; store it back
	pulu a ; remove temp
	puls a
	nop ; set(activated,1)
	pshs a
	lda #1 ; load new val
	sta activated ; store it back
	puls a
	puls y,x,d
	rts

