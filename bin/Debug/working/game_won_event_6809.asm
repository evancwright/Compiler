
; machine generate routine from XML file
game_won_event
	pshs d,x,y
	nop ; test ((player.holder == inside tardis))
	lda #4 ; inside tardis
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
	nop ; test ((countDown == 3))
	lda countDown ; countDown
	pshs a    ; push right left
	lda #3 ; 3
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @b
	nop ; println("CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.")
	ldx #description_table
	lda #42 ; CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("STORY COMPLETE.")
	ldx #description_table
	lda #43 ; STORY COMPLETE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; println("TYPE 'QUIT' TO EXIT GAME.")
	ldx #description_table
	lda #44 ; TYPE 'QUIT' TO EXIT GAME.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
@b	nop ; close (countDown == 3)
@a	nop ; close (player.holder == inside tardis)
	puls y,x,d
	rts

