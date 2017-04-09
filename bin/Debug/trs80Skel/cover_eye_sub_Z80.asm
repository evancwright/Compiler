
; machine generate Z80 routine from XML file
*MOD
cover_eye_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.")
	push af
	push ix
	ld ix,string_table
	ld b,74 ; YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.")
	push af
	push ix
	ld ix,string_table
	ld b,75 ; IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'")
	push af
	push ix
	ld ix,string_table
	ld b,76 ; 'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.")
	push af
	push ix
	ld ix,string_table
	ld b,77 ; THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; eyestalk.holder=0
	ld a,0
	push af
	push bc
	ld a,27
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
	nop ; add(score,25)
	push af
	ld a,(score) ; get val of score
	add a,25 ; push val to add
	ld (score),a ; store it back
	pop af
	nop ; set(activated,1)
	push  af
	ld a,1 ; load new val
	ld (activated),a  ; store it back
	pop af
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

