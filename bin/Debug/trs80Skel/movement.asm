;movement.asm

get_move_dir
		push de
		push ix
		ld ix,direction_map
		ld a,(sentence) get verb
		sub north_verb_id
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
DB NORTH
DB SOUTH
DB EAST
DB WEST
DB NORTHEAST
DB SOUTHEAST
DB SOUTHWEST
DB NORTHWEST
DB UP
DB DOWN
DB ENTER
DB OUT
DB 0ffh