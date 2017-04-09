;movement.asm
;puts move dir in a

move_player

	ret

enter_sub
		ret
	
;puts move dir (attr) in a 	
get_move_dir
		push de
		push ix
		ld ix,direction_map
		ld a,(sentence) ; get verb
		sub n_verb_id
		ld d,0
		ld e,a
		add ix,de
		ld a,(ix)	
		pop ix
		push de
		ret

;direction table
;maps direction verb id to the attribute numbers
direction_map
	DB 5 ; N
	DB 6 ; SOUTH
	DB 7 ; EAST
	DB 8 ; WEST 
	DB 9 ; NORTHEAST 
	DB 10 ; SOUTHEAST 
	DB 11 ;SOUTHWEST
	DB 12 ;NORTHWEST
	DB 13 ;UP 
	DB 14 ;DOWN 
	DB 15 ;ENTER 
	DB 16 ;OUT 
	DB 0ffh