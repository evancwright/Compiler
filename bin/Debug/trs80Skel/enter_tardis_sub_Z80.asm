
; machine generate Z80 routine from XML file
*MOD
enter_tardis_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	push af
	push bc
	ld a,3; tardis
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_1 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	bit 5,(ix) ; test open prop bit
	push bc ; flags to a
	push af ; tfr flags to acc
	pop bc
	ld a,c ; get flags in acc 
	pop bc ; end flags to a
	srl a ; right justify z bit
	srl a ; right justify z bit
	srl a ; right justify z bit
	srl a ; right justify z bit
	srl a ; right justify z bit
	ld b,1
	cp b ; == 1 ?
	jp nz,$a?
	nop ; player.holder = inside tardis
	 ld a,4 ;inside tardis
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
	jp $b? ; skip else 
$a?	nop ; close (tardis.open == 1)
	nop ; { println("THE TARDIS IS CLOSED.")
	push af
	push ix
	ld ix,string_table
	ld b,65 ; THE TARDIS IS CLOSED.
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

