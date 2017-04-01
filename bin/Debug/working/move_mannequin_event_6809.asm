
; machine generate routine from XML file
move_mannequin_event
	pshs d,x,y
	nop ; test ((player.holder == 2nd floor))
	lda #10 ; 2nd floor
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
	nop ; test ((mannequinMoved == 0))
	lda mannequinMoved ; mannequinMoved
	pshs a    ; push right left
	lda #0 ; 0
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @b
	nop ; dalek.holder = inside tardis
	lda #4 ; inside tardis
	pshs a ; save value to put in attr
	lda #22 ; dalek
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; tardis.locked=1
	nop ; set tardis.locked=1
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
	ora #128   ; set the locked bit
	sta ,x  ; store it
	nop ; tardis.open=0
	nop ; set tardis.open=0
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
	nop ; mannequinMoved=1
	nop ; mannequin.holder=inventory room
	lda #12 ; inventory room
	pshs a ; save value to put in attr
	lda #19 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; inventory room.locked = 0
	nop ; set inventory room.locked=0
	lda #12 ; inventory room
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
	nop ; inventory room.lockable = 0
	nop ; set inventory room.lockable=0
	lda #12 ; inventory room
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
	nop ; mannequin.description = "THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	lda #35 ; "THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	pshs a ; save value to put in attr
	lda #19 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 3,x   ;description
	puls a ; restore rhs
	sta ,x
	nop ; mannequin.initial_description = "THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	lda #36 ; "THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	pshs a ; save value to put in attr
	lda #19 ; mannequin
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 2,x   ;initial_description
	puls a ; restore rhs
	sta ,x
	nop ; hat.initial_description = "A STYLISH HAT LIES ON THE FLOOR."
	lda #37 ; "A STYLISH HAT LIES ON THE FLOOR."
	pshs a ; save value to put in attr
	lda #23 ; hat
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 2,x   ;initial_description
	puls a ; restore rhs
	sta ,x
@b	nop ; close (mannequinMoved == 0)
@a	nop ; close (player.holder == 2nd floor)
	puls y,x,d
	rts

