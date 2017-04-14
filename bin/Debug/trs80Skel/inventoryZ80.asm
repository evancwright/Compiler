;inventory_sub
*MOD
inventory_sub
		push af
		ld a,PLAYER_ID
		call has_contents
		cp 1
		jp nz,$n?
		ld hl,carrying
	    call OUTLIN
		call printcr
		nop; recurse through child items
		ld a,PLAYER_ID
		call print_contents
		jp $x?		
$n?		ld hl,noitems
	    call OUTLIN
		call printcr
$x?		pop af
		ret

;prints contains of obj in 'a'
*MOD
print_contents
		push bc
		push de
		push hl
		push ix
		ld b,a	; save parent
		ld de,OBJ_ENTRY_SIZE
		ld ix,obj_table
$lp?	ld a,(ix)
		cp 0ffh
		jp z,$x?
		ld a,(ix+HOLDER_ID)
		cp b
		jp nz,$c?
		bit SCENERY_BIT,(ix+PROPERTY_BYTE_1)  ; test scenery bit
		jp nz,$c?
		ld a,(ix)
		call print_obj_name
		call printcr
		nop ; need to test container/supporter
		bit CONTAINER_BIT,(ix+PROPERTY_BYTE_1)
		call z,print_container_contents
		bit SUPPORTER_BIT,(ix+PROPERTY_BYTE_1)
		call z,print_supporter_contents
$c?		add ix,de
		jp $lp?
$x?		ld b,a	; found flag->a
		pop ix
		pop hl
		pop de
		pop bc		
		ret
		
;if 'a' has any visible items
;1 is returned in 'a' otherwise 0
*MOD
has_contents
		push bc
		push de
		push hl
		push ix
		ld h,a
		ld b,0	; found flag
		ld de,OBJ_ENTRY_SIZE
		ld ix,obj_table
$lp?	ld a,(ix)
		cp 0ffh
		jp z,$x?
		ld a,(ix+HOLDER_ID)
		cp h
		jp nz,$c?
		bit SCENERY_BIT,(ix+PROPERTY_BYTE_1)  ; test scenery bit
		jp nz,$c?
		ld a,1
		jp $x?
$c?		add ix,de
		jp $lp?
$x?		ld b,a	; found flag->a
		pop ix
		pop hl
		pop de
		pop bc
		ret
*MOD		
get_sub
		push af
		push bc
		push de
		push hl
		push ix
		push iy
		ld a,(sentence+1) ; get dobj
		ld b,a
		ld c,PORTABLE
		call get_obj_prop
		cp 1
		jp z,$y?
		ld hl,notportable
		call OUTLIN
		call printcr
		jp $x? 
$y?		nop; move to player
		ld a,(sentence+1)  ; get dobj
		ld b,a
		ld c,HOLDER_ID
		ld a,PLAYER_ID
		call set_obj_attr
		nop ; clear initial description
		ld c,INITIAL_DESC_ID
		ld a,255
		call set_obj_attr		
		ld hl,taken
		call OUTLIN
		call printcr
$x?		pop iy
		pop ix
		pop hl
		pop de
		pop bc
		pop af
		ret
		
*MOD
drop_sub
		push af
		push bc
		ld a,(sentence+1)
		ld b,a
		ld c,HOLDER_ID
		call get_player_room
		call set_obj_attr
		ld hl,dropped
		call OUTLIN
		call printcr
		pop bc
		pop af
		ret

*MOD		
;print contents of container in 'a'
print_container_contents
		push bc
		push hl
		call has_contents
		cp 1
		jp nz,$x?
		ld hl,initis
		call OUTLIN
		call printcr
		call print_contents
$x?		pop hl
		pop bc
		ret

*MOD		
;print contents of container in 'a'
print_supporter_contents
		push bc
		push hl
		call has_contents
		cp 1
		jp nz,$x?
		ld hl,onitis
		call OUTLIN
		call printcr
		call print_contents
$x?		pop hl
		pop bc
		ret
		
taken DB "TAKEN.",0h		
dropped DB "DROPPED.",0h
noitems DB "YOU ARE EMPTY HANDED.",0h
carrying DB "YOU ARE CARRYING:",0h
onitis DB "ON IT IS...",0h;
initis DB "IN IT IS...",0h;
notportable DB "YOU CAN'T PICK THAT UP.",0h