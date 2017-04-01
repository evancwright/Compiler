
; machine generate routine from XML file
read_note_sub
	pshs d,x,y
	nop ; println("THE NOTE READS...")
	ldx #description_table
	lda #54 ; THE NOTE READS...
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'")
	ldx #description_table
	lda #55 ; 'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; test ((readNote == 0))
	lda readNote ; readNote
	pshs a    ; push right left
	lda #0 ; 0
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; readNote = 1
	nop ; add(score, 5)
	pshs a
	lda score
	pshu a ; push var value
	lda #5 ; push val to add
	adda ,u ; add it 
	sta score ; store it back
	pulu a ; remove temp
	puls a
@a	nop ; close (readNote == 0)
	puls y,x,d
	rts

