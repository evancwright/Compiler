
; machine generate Z80 routine from XML file
*MOD
hit_mannequin_with_bat_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.")
	push af
	push ix
	ld ix,string_table
	ld b,59 ; WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("ROSE STAGGERS TO HER FEET.")
	push af
	push ix
	ld ix,string_table
	ld b,60 ; ROSE STAGGERS TO HER FEET.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; mannequin.holder = 0
	ld a,0
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
	nop ; torso.holder=inventory room
	 ld a,12 ;inventory room
	push af
	push bc
	ld a,25; torso
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
	nop ; plastic head.holder=inventory room
	 ld a,12 ;inventory room
	push af
	push bc
	ld a,24; plastic head
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
	nop ; rose.initial_description = "ROSE IS HERE CHECKING THE INVENTORY."
	 ld a,-1 ;"ROSE IS HERE CHECKING THE INVENTORY."
	push af
	push bc
	ld a,21; rose
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
	nop ; add(score,10)
	push af
	ld a,(score) ; get val of score
	add a,10 ; push val to add
	ld (score),a ; store it back
	pop af
	nop ; println("ROSE HANDS YOU THE KEY TO HER FLAT.")
	push af
	push ix
	ld ix,string_table
	ld b,62 ; ROSE HANDS YOU THE KEY TO HER FLAT.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; key.holder = player
	 ld a,1 ;player
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
	 ld (ix), a ; store rhs in lhs
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

