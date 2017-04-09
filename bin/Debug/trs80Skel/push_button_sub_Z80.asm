
; machine generate Z80 routine from XML file
*MOD
push_button_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; test ((elevator.e == lobby))
	 ld a,14 ; lobby
	ld b,a  ; move rhs in a
	push af
	push bc
	ld a,15
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,6 ; get 'e' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	ld a,(ix)
	cp b ; == lobby?
	jp z,$a?
	nop ; println("THE LIFT SLOWLY RISES TO THE UPPER FLOOR.")
	push af
	push ix
	ld ix,string_table
	ld b,66 ; THE LIFT SLOWLY RISES TO THE UPPER FLOOR.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("THE DOOR OPENS, LEADING EAST TO A HALLWAY.")
	push af
	push ix
	ld ix,string_table
	ld b,67 ; THE DOOR OPENS, LEADING EAST TO A HALLWAY.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; elevator.e = hallway
	 ld a,17 ;hallway
	push af
	push bc
	ld a,15
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,6 ; get 'e' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
	jp $b? ; skip else 
$a?	nop ; close (elevator.e == lobby)
	nop ; println("THE LIFT SLOWLY DESCENDS FLOOR.")
	push af
	push ix
	ld ix,string_table
	ld b,68 ; THE LIFT SLOWLY DESCENDS FLOOR.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("THE DOOR OPENS, LEADING EAST TO THE LOBBY.")
	push af
	push ix
	ld ix,string_table
	ld b,69 ; THE DOOR OPENS, LEADING EAST TO THE LOBBY.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; elevator.e = lobby
	 ld a,14 ;lobby
	push af
	push bc
	ld a,15
	ld b,a
	ld c, 19
	call bmulc
	ld ix,obj_table
	add ix,bc ; jump to object
	ld bc,6 ; get 'e' byte
	add ix,bc ; jump to the object's byte we need
	pop bc
	pop af
	 ld (ix), a ; store rhs in lhs
$b?	nop ; end else
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

