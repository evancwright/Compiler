
; machine generate Z80 routine from XML file
*MOD
take_portable_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	push af
	push bc
	ld a,(sentence+1)
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,PROPERTY_BYTE_2 ; get prop byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	bit 0,(ix) ; test prop bit
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
	srl a ; right justify z bit
	cp b ; == 1 ?
	jp z,$a?
	nop ; test (($dobj.holder != player))
	 ld a,1 ; player
	ld b,a  ; move rhs in a
	push af
	push bc
	ld a,(sentence+1)
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
	jp z,$b?
	nop ; println("(TAKEN)")
	push af
	push ix
	ld ix,string_table
	ld b,55 ; (TAKEN)
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; $dobj.holder = player
	 ld a,1 ;player
	push af
	push bc
	ld a,(sentence+1)
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
$b?	nop ; close ($dobj.holder != player)
$a?	nop ; close ($dobj.portable==1)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

