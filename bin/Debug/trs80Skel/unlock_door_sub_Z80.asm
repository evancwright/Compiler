
; machine generate Z80 routine from XML file
*MOD
unlock_door_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; test ((key.holder == player))
	 ld a,1 ; player
	ld b,a  ; move rhs in b
	push af
	push bc
	ld a,30; key
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
	cp b ; == player?
	jp nz,$a?
	nop ; println("THE DOOR IS NOW UNLOCKED")
	push af
	push ix
	ld ix,string_table
	ld b,78 ; THE DOOR IS NOW UNLOCKED
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; 29.open = 1
	push af
	push bc
	ld a,29; 29
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	set 5,(ix) ; set the open bit
	nop ; 29.locked = 0
	push af
	push bc
	ld a,29; 29
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	ld b,(ix) ; get property byte
	ld a,128 ; get locked bit
	cpl ; flip bits
	and b ; clear the bit
	ld (ix),a ; write bits back 
	jp $b? ; skip else 
$a?	nop ; close (key.holder == player)
	nop ; println("YOU NEED THE KEY.")
	push af
	push ix
	ld ix,string_table
	ld b,79 ; YOU NEED THE KEY.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
$b?	nop ; end else
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

