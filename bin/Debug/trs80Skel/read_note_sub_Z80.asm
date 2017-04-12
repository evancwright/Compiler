
; machine generate Z80 routine from XML file
*MOD
read_note_sub
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; println("THE NOTE READS...")
	push af
	push ix
	ld ix,string_table
	ld b,56 ; THE NOTE READS...
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'")
	push af
	push ix
	ld ix,string_table
	ld b,57 ; 'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	ld a,0
	ld b,a ; put rhs in b
	ld a,(readNote); readNote
	cp b ; ==0?
	jp nz,$a?
	nop ; readNote = 1
	nop ; add(score, 5)
	push af
	ld a,(score) ; get val of score
	add a, 5 ; push val to add
	ld (score),a ; store it back
	pop af
$a?	nop ; close (readNote == 0)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

