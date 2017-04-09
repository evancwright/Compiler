;inventory_sub
*MOD

inventory_sub
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