
; machine generate Z80 routine from XML file
*MOD
move_mannequin_event
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; test ((player.holder == 2nd floor))
	 ld a,10 ; 2nd floor
	ld b,a  ; move rhs in b
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
	ld a,(ix)
	cp b ; == 2nd floor?
	jp nz,$a?
	ld a,0
	ld b,a ; put rhs in b
	ld a,(mannequinMoved); mannequinMoved
	cp b ; ==0?
	jp nz,$b?
	nop ; dalek.holder = inside tardis
	 ld a,4 ;inside tardis
	push af
	push bc
	ld a,22; dalek
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
	nop ; tardis.locked=1
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
	set 7,(ix) ; set the locked bit
	nop ; tardis.open=0
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
	ld a,32 ; get open bit
	cpl ; flip bits
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
	cpl ; flip bits
	and b ; clear the bit
	ld (ix),a ; write bits back 
	nop ; mannequinMoved=1
	nop ; mannequin.holder=inventory room
	 ld a,12 ;inventory room
	push af
	push bc
	ld a,19; mannequin
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
	nop ; door.locked = 0
	push af
	push bc
	ld a,13; door
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
	nop ; door.lockable = 0
	push af
	push bc
	ld a,13; door
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
	cpl ; flip bits
	and b ; clear the bit
	ld (ix),a ; write bits back 
	nop ; mannequin.description = "THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	ld a,37 ;"THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	push af
	push bc
	ld a,19; mannequin
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,3 ; get 'description' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
	nop ; mannequin.initial_description = "THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	ld a,38 ;"THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	push af
	push bc
	ld a,19; mannequin
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,2 ; get 'initial_description' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
	nop ; test ((hat.holder == 1st floor))
	 ld a,9 ; 1st floor
	ld b,a  ; move rhs in b
	push af
	push bc
	ld a,23; hat
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
	cp b ; == 1st floor?
	jp nz,$c?
	nop ; hat.initial_description = "A STYLISH HAT LIES ON THE FLOOR."
	ld a,39 ;"A STYLISH HAT LIES ON THE FLOOR."
	push af
	push bc
	ld a,23; hat
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,2 ; get 'initial_description' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
$c?	nop ; close (hat.holder == 1st floor)
$b?	nop ; close (mannequinMoved == 0)
$a?	nop ; close (player.holder == 2nd floor)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

