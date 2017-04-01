
; machine generate routine from XML file
moveMannequin_event
	pshs d,x,y
	nop ; test ((player.holder==2nd floor))
	lda #9 ;2nd floor
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
	nop ; test ((mannequinMoved==0))
	lda mannequinMoved ; mannequinMoved
	pshs a    ; push right left
	lda #0 ; 0
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @b
	nop ; mannequinMoved=1
	nop ; mannequin.holder=inventory room
	lda #14 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	lda #13
	sta ,x
	nop ; mannequin.description="THE MANNEQUIN IS ALIVE AND OBVIOUSLY VERY DANGEROUS."
	lda #14 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 3,x   ;description
	lda #35
	sta ,x
	nop ; mannequin.initial_description = "THE MANNEQUIN IS STANDING OVER ROSE'S UNCONSCIOUS BODY."
	lda #14 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 2,x   ;initial_description
	lda #36
	sta ,x
	nop ; door.open=1
	nop ; set door.open=1
	lda #12 ; door
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
	nop ; door.locked=0
	nop ; set door.locked=0
	lda #12 ; door
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
	nop ; dalek.holder=inside tardis
	lda #19 ; dalek
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	lda #4
	sta ,x
@b	nop ; close (mannequinMoved==0)
@a	nop ; close (player.holder==2nd floor)
	puls y,x,d
	rts

