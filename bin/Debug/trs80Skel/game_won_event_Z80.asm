
; machine generate Z80 routine from XML file
*MOD
game_won_event
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	nop ; test ((player.holder == inside tardis))
	 ld a,4 ; inside tardis
	ld b,a  ; move rhs in a
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
	cp b ; == inside tardis?
	jp z,$a?
	ld a,3
	ld b,a ; put rhs in b
	ld a,(countDown); countDown
	jp z,$b?
	nop ; println("CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.")
	push af
	push ix
	ld ix,string_table
	ld b,44 ; CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("STORY COMPLETE.")
	push af
	push ix
	ld ix,string_table
	ld b,45 ; STORY COMPLETE.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("TYPE 'QUIT' TO EXIT GAME.")
	push af
	push ix
	ld ix,string_table
	ld b,46 ; TYPE 'QUIT' TO EXIT GAME.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
$b?	nop ; close (countDown == 3)
$a?	nop ; close (player.holder == inside tardis)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

