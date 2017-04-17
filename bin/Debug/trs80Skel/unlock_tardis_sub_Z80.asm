
; machine generate Z80 routine from XML file
*MOD
unlock_tardis_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; test ((sonic screwdriver.holder==player))
	 ld a,1 ;player
	ld b,a  ; move rhs in b
	push af
	push bc
	ld a,26; sonic screwdriver
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
	cp b ; ==player?
	jp nz,$a?
	nop ; println("(WITH SONIC SCREWDRIVER)")
	push af
	push ix
	ld ix,string_table
	ld b,74 ; (WITH SONIC SCREWDRIVER)
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; call unlock_tardis_with_sonicscrewdriver()
	jp $b? ; skip else 
$a?	nop ; close (sonic screwdriver.holder==player)
	nop ; println("YOU HAVE NOTHING TO UNLOCK IT WITH.")
	push af
	push ix
	ld ix,string_table
	ld b,75 ; YOU HAVE NOTHING TO UNLOCK IT WITH.
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

