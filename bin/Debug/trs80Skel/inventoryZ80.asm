;inventory_sub
*MOD
inventory_sub
		push af
		call player_has_items
		cp 1
		jp nz,$n?
		ld hl,carrying
	    call OUTLIN
		call printcr
		jp $x?		
$n?		ld hl,noitems
	    call OUTLIN
		call printcr
$x?		pop af
		ret

;if player has any visible items
;1 is returned in 'a' otherwise 0
*MOD
player_has_items
		push bc
		push de
		push hl
		push ix
		ld b,0	; found flag
		ld de,OBJ_ENTRY_SIZE
		ld ix,obj_table
$lp?	ld a,(ix)
		cp 0ffh
		jp z,$x?
		ld a,(ix+HOLDER_ID)
		cp PLAYER_ID
		jp nz,$c?
		bit SCENERY_BIT,(ix+PROPERTY_BYTE_1)  ; test scenery bit
		jp nz,$c?
		ld b,1
		jp $x?
$c?		add ix,de
		jp $lp?
$x?		ld b,a	; found flag->a
		pop ix
		pop hl
		pop de
		pop bc
		ret
		
get_sub
		push af
		push bc
		push de
		push hl
		push ix
		push iy
		ld a,(sentence+1)
		ld b,a
		ld c,HOLDER_ID
		ld a,PLAYER_ID
		call set_obj_attr
		ld hl,taken
		call OUTLIN
		call printcr
		pop iy
		pop ix
		pop hl
		pop de
		pop bc
		pop af
		ret
		
drop_sub
		push af
		push bc
		push ix
		push iy
		call get_player_room
		push af
		ld a,(sentence+1)
		ld b,a
		ld c,HOLDER_ID
		pop af
		call set_obj_attr
		ld hl,dropped
		call OUTLIN
		call printcr
		pop iy
		pop ix
		pop bc
		pop af
		ret
		
taken DB "TAKEN.",0h		
dropped DB "DROPPED.",0h
noitems DB "YOU ARE EMPTY HANDED.",0h
carrying DB "YOU ARE CARRYING:",0h