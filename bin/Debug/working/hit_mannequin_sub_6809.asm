
; machine generate routine from XML file
hit_mannequin_sub
	pshs d,x,y
	nop ; test ((cricket bat.holder==player))
	lda #1 ;player
	pshs a    ; push right side
	lda #10 ; cricket bat
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
	nop ; println("(WITH CRIKET BAT")
	ldx #description_table
	lda #57 ; (WITH CRIKET BAT
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; call hit_mannequin_with_bat()
	bra @b ; skip else 
@a	nop ; close (cricket bat.holder==player)
	nop ; println("YOUR FIST DO NO DAMAGE.")
	ldx #description_table
	lda #58 ; YOUR FIST DO NO DAMAGE.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
@b	nop ; end else
	puls y,x,d
	rts

