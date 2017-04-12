
; machine generate Z80 routine from XML file
*MOD
countdown_event
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	ld a,1
	ld b,a ; put rhs in b
	ld a,(activated); activated
	jp z,$a?
	ld a,3
	ld b,a ; put rhs in b
	ld a,(countDown); countDown
	jp z,$b?
	nop ; add(countDown,1)
	push af
	ld a,(countDown) ; get val of countDown
	add a,1 ; push val to add
	ld (countDown),a ; store it back
	pop af
	ld a,3
	ld b,a ; put rhs in b
	ld a,(countDown); countDown
	jp z,$c?
	nop ; println("AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.")
	push af
	push ix
	ld ix,string_table
	ld b,40 ; AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; dalek.holder=0
	ld a,0
	push af
	push bc
	ld a,22; dalek
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,1 ; get 'holder' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
	nop ; test ((player.holder == inside tardis))
	 ld a,4 ; inside tardis
	ld b,a  ; move rhs in a
	push af
	push bc
	ld a,1; player
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,1 ; get 'holder' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	ld a,(ix)
	cp b ; == inside tardis?
	jp z,$d?
	nop ; println("THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.")
	push af
	push ix
	ld ix,string_table
	ld b,41 ; THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; player.holder=trenzalore
	 ld a,28 ;trenzalore
	push af
	push bc
	ld a,1; player
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,1 ; get 'holder' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
	nop ; look()
	call look_sub
$d?	nop ; close (player.holder == inside tardis)
$c?	nop ; close (countDown==3)
$b?	nop ; close (countDown != 3)
$a?	nop ; close (activated==1)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

