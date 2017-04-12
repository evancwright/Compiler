
; machine generate Z80 routine from XML file
*MOD
unlock_tardis_with_sonicscrewdriver_sub
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
	bit 7,(ix) ; test locked prop bit
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
	srl a ; right justify z bit
	ld b,1
	cp b ; == 1 ?
	jp z,$a?
	nop ; println("AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.")
	push af
	push ix
	ld ix,string_table
	ld b,70 ; AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; tardis.open = 1
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
	set 5,(ix) ; set the open bit
	nop ; tardis.locked=0
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
	ld b,(ix) ; get property byte
	ld a,128 ; get locked bit
	xor 1 ; flip bits
	and b ; clear the bit
	ld (ix),a ; write bits back 
	nop ; tardis.lockable=0
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
	ld b,(ix) ; get property byte
	ld a,64 ; get lockable bit
	xor 1 ; flip bits
	and b ; clear the bit
	ld (ix),a ; write bits back 
	jp $b? ; skip else 
$a?	nop ; close (tardis.locked==1)
	nop ; println("THE TARDIS IS ALREADY OPEN.")
	push af
	push ix
	ld ix,string_table
	ld b,71 ; THE TARDIS IS ALREADY OPEN.
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

