;z80 routines

;returns property c of object b in register a
*MOD
get_obj_attr
		push bc
		push de
		push hl
		push ix
		ld de,OBJ_ENTRY_SIZE
		ld ix,obj_table
		ld a,b 
$lp?	cp 0	
		jp z,$out?
		add ix,de ;(skip OBJ_ENTRY_SIZE bytes) NOTE: ld ix,hl shouldn't assemble but does
		dec a   
		jp $lp?
$out?	ld d,0
		ld e,c
		add ix,de	 ; add attr offset to ix
		ld a,(ix)    ; finally get the byte
		pop ix
		pop hl
		pop de
		pop bc
		ret

;returns property c of object b in register a
get_obj_prop
		push bc
		push de
		ld d,PROPERTY_BYTE_1
		ld a,c ; get the correct byte
		cp 8
		jp c,$s? ;jump on carry (less than)
		inc d	; property is in the next byte
$s?		ld c,d
		call get_obj_attr ; put attr byte 'c' in 'a'		
		call make_prop_mask ; puts mask in 'b'
		and b ; test the bit in the mask
		pop de
		pop bc
		ret

;looks up the mask for the property number in b
;mask is returned in 'b'
;c is not changed
make_prop_mask
	push de
	push hl
	push iy
	ld iy,mask_table 
	ld d,0	
	ld e,b
	add iy,de
	ld b,(iy)	; load mask from table
	pop iy
	pop hl
	pop de
	ret

;player room in 'a'
get_player_room
		ld b,PLAYER_ID	
		ld c,HOLDER_ID
		call get_obj_attr
		ld (player_room),a
		ret

inside_closed_container
		ret
		
;put 1 or 0 in a if c is a descendant of b		
*MOD
is_descendant_of
		push bc
		push de
		ld d,b ; save parent
		ld c,HOLDER_ID
$lp?	call get_obj_attr ; puts holder in a
		cp d	 	; ancestor found
		jp z,$y?
		cp 0		; hit top level - ancestor not found
		jp z,$n?
		ld b,a
		jp $lp?
$n?		ld a,0
		jp $x?
$y?		ld a,1
$x?		pop de
		pop bc
		ret
		
player_room DB 0
	
;table of mask bytes for looking up
;properties of objects		
mask_table
	DB SCENERY_MASK ;equ 1 
	DB SUPPORTER_MASK ;equ 2
	DB CONTAINER_MASK ;equ 4
	DB TRANSPARENT_MASK ;equ 8
	DB OPENABLE_MASK ;equ 16
	DB OPEN_MASK ;equ 32
	DB LOCKABLE_MASK ;equ 64
	DB LOCKED_MASK ;equ 128
	DB PORTABLE_MASK ;equ 1
	DB BACKDROP_MASK ;equ 2
	DB DRINKABLE_MASK ;equ 4
	DB FLAMMABLE_MASK ;equ 8
	DB LIGHTABLE_MASK ;equ 16
	DB LIT_MASK ;equ 32	
	DB DOOR_MASK ;equ 64
	DB UNUSED_MASK ;equ 128

		