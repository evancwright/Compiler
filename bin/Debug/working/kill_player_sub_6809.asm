
; machine generate routine from XML file
kill_player_sub
	pshs d,x,y
	nop ; println("***YOU HAVE DIED***.")
	ldx #description_table
	lda #46 ; ***YOU HAVE DIED***.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; player.holder=1
	lda #1 ; 1
	pshs a ; save value to put in attr
	lda #1 ; player
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	puls y,x,d
	rts

