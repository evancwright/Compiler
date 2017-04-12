
; machine generate Z80 routine from XML file
*MOD
judoon_rule_event
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; test ((player.holder == lobby))
	 ld a,14 ; lobby
	ld b,a  ; move rhs in b
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
	cp b ; == lobby?
	jp nz,$a?
	nop ; test ((mannequin.holder != 0))
	ld a,0
	ld b,a  ; move rhs in b
	push af
	push bc
	ld a,19; mannequin
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
	nop ; println("AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE."
	push af
	push ix
	ld ix,string_table
	ld b,43 ; AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; player.holder = north street
	 ld a,7 ;north street
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
$b?	nop ; close (mannequin.holder != 0)
$a?	nop ; close (player.holder == lobby)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

