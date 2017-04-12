
; machine generate Z80 routine from XML file
*MOD
kill_player_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("***YOU HAVE DIED***.")
	push af
	push ix
	ld ix,string_table
	ld b,48 ; ***YOU HAVE DIED***.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; player.holder=1
	ld a,1
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
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

