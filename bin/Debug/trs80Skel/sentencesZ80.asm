;sentences running routines
*MOD
run_sentence
		;run checks (these return if not met)
		;return before
		ld ix,preactions_table
		call run_actions
		;run instead
		ld ix,actions_table
		call run_actions
		;run actions
		ld ix,postactions_table
		call run_actions
		;run after
		;do events
		ret

;actions table in ix		
*MOD
run_actions
		push bc
		push de
		push hl
		push iy 
		ld iy,sentence
		ld bc,6 	;size of entry
@lp?	ld a,(ix)	; load verb from table
		cp 0ffh		; hit end of table
		jp z,$x? 
		cp (iy)		; verb match
		jp nz,$c?
		ld a,(ix+1)
		cp (iy+1)				
		jp nz,$c?			; d.o.'s don't match
		ld a,(ix+2)
		cp (iy+2)		
		jp nz,$c?			; preps don't match
		ld a,(ix+3)
		cp (iy+3)		
		jp nz,$c?			; i.o. 's don't match
		push ix	; ix -> hl
		pop hl
		inc hl	; move 4 bytes to sub routine
		inc hl
		inc hl
		inc hl
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de	; de -> hl
		pop hl
     	ld bc,$c?      ; push return addr on stack
		push bc
		jp (hl)			; return will pop stack
$c?		add ix,de			; skip to next entry 
		jp @lp?
$x?		pop iy
		pop hl
		pop de
		pop bc
		ret
		
run_events
		ret