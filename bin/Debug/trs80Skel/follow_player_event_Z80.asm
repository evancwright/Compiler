
; machine generate Z80 routine from XML file
*MOD
follow_player_event
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
	nop ; test ((dalek.holder != 0))
	ld a,0
	ld b,a  ; move rhs in a
	push af
	push bc
	ld a,22
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
	cp b ; == 0?
	jp z,$b?
	nop ; println("THE DALEK IS FOLLOWING YOU.")
	push af
	push ix
	ld ix,string_table
	ld b,42 ; THE DALEK IS FOLLOWING YOU.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; dalek.holder = player.holder
	push af
	push bc
	ld a,1
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,1 ; get 'holder' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	ld a,(ix) ; get attr byte byte
	push af
	push bc
	ld a,22
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
$b?	nop ; close (dalek.holder != 0)
$a?	nop ; close (activated==1)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

