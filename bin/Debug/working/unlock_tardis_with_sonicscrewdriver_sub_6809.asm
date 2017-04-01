
; machine generate routine from XML file
unlock_tardis_with_sonicscrewdriver_sub
	pshs d,x,y
	nop ; test ((tardis.locked==1))
	lda #1
	pshs a    ; push right side
	lda #3
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax PROPERTY_BYTE_1,x  ; 
	lda ,x  ; get property byte
	anda #128 ; isolate locked  bit 
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	lsra ; right justify bit
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; println("AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.")
	ldx #description_table
	lda #67 ; AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; tardis.open = 1
	nop ; set tardis.open=1
	lda #3 ; tardis
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax PROPERTY_BYTE_1,x
	lda ,x  ; get property byte
	ldb #32 ; get the mask for open
	comb 32 ; invert it
	pshs b
	anda ,s   ; clear the bit
	leas 1,s ; pop stack
	ora #32   ; set the open bit
	sta ,x  ; store it
	nop ; tardis.locked=0
	nop ; set tardis.locked=0
	lda #3 ; tardis
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax PROPERTY_BYTE_1,x
	lda ,x  ; get property byte
	ldb #128 ; get the mask for locked
	comb 128 ; invert it
	pshs b
	anda ,s   ; clear the bit
	leas 1,s ; pop stack
	sta ,x  ; store it
	nop ; tardis.lockable=0
	nop ; set tardis.lockable=0
	lda #3 ; tardis
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax PROPERTY_BYTE_1,x
	lda ,x  ; get property byte
	ldb #64 ; get the mask for lockable
	comb 64 ; invert it
	pshs b
	anda ,s   ; clear the bit
	leas 1,s ; pop stack
	sta ,x  ; store it
	bra @b ; skip else 
@a	nop ; close (tardis.locked==1)
	nop ; println("THE TARDIS IS ALREADY OPEN.")
	ldx #description_table
	lda #68 ; THE TARDIS IS ALREADY OPEN.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
@b	nop ; end else
	puls y,x,d
	rts

