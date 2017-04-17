
; machine generate Z80 routine from XML file
*MOD
game_won_event
	push af
	push bc
	push de
	push hl
	push ix
	push iy
	ld a,0
	ld b,a ; put rhs in b
	ld a,(gameOver); $gameOver
	cp b ; ==0?
	jp nz,$a?
	nop ; test ((player.holder == inside tardis))
	 ld a,4 ; inside tardis
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
	cp b ; == inside tardis?
	jp nz,$b?
	ld a,3
	ld b,a ; put rhs in b
	ld a,(countDown); countDown
	cp b ; ==3?
	jp nz,$c?
	nop ; println("CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.")
	push af
	push ix
	ld ix,string_table
	ld b,46 ; CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("STORY COMPLETE.")
	push af
	push ix
	ld ix,string_table
	ld b,47 ; STORY COMPLETE.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; println("TYPE 'QUIT' TO EXIT GAME.")
	push af
	push ix
	ld ix,string_table
	ld b,48 ; TYPE 'QUIT' TO EXIT GAME.
	call print_table_entry
	pop ix
	pop af
	call printcr ; newline
	nop ; $gameOver=1
$c?	nop ; close (countDown == 3)
$b?	nop ; close (player.holder == inside tardis)
$a?	nop ; close ($gameOver==0)
	pop iy
	pop ix
	pop hl
	pop de
	pop bc
	pop af
	ret

