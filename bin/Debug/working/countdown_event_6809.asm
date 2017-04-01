
; machine generate routine from XML file
countdown_event
	pshs d,x,y
	nop ; test ((activated==1))
	lda activated ; activated
	pshs a    ; push right left
	lda #1 ; 1
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @a
	nop ; test ((countDown != 3))
	lda countDown ; countDown
	pshs a    ; push right left
	lda #3 ; 3
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbeq @b
	nop ; add(countDown,1)
	pshs a
	lda countDown
	pshu a ; push var value
	lda #1 ; push val to add
	adda ,u ; add it 
	sta countDown ; store it back
	pulu a ; remove temp
	puls a
	nop ; test ((countDown==3))
	lda countDown ; countDown
	pshs a    ; push right left
	lda #3 ; 3
	cmpa ,s ; compare to right side
	pshu cc ; save flags
	leas 1,s ; pop right side
	pulu cc ; restore flags
	lbne @c
	nop ; println("AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.")
	ldx #description_table
	lda #38 ; AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; dalek.holder=0
	lda #0 ; 0
	pshs a ; save value to put in attr
	lda #22 ; dalek
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
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
	lbne @d
	nop ; println("THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.")
	ldx #description_table
	lda #39 ; THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.
	pshu a
	jsr print_table_entry
	jsr PRINTCR
	nop ; player.holder=trenzalore
	lda #28 ; trenzalore
	pshs a ; save value to put in attr
	lda #1 ; player
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	leax 1,x   ;holder
	puls a ; restore rhs
	sta ,x
	nop ; look()
	jsr look_sub
@d	nop ; close (player.holder == inside tardis)
@c	nop ; close (countDown==3)
@b	nop ; close (countDown != 3)
@a	nop ; close (activated==1)
	puls y,x,d
	rts

