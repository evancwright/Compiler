;look.asm

*MOD
look_sub
		push bc
		push de
		push hl
		push ix
		ld de,OBJ_ENTRY_SIZE
		nop ; can the player see?
		call get_player_room
		ld b,a
		ld h,a
		call print_obj_description
		nop ; now print all visible objects
		ld ix,obj_table
$lp?	ld a,(ix);get id
		cp 0		; skip offscreen
		jp z,$c?
		cp 1		; skip player
		jp z,$c?
		cp 0ffh
		jp z,$x?
		nop ; is this object in this room?
		ld b,a  ; put id byte in b for print_object
		ld a,(ix+1) ; get holder byte
		cp h		; compare to player's room (h)
		call z,print_obj ; look at id 'b'
$c?		add ix,de ; skip object
		jp $lp?
$x?		pop ix
		pop hl
		pop de
		pop bc
		ret

;prints the description for object in b
;if the object has an 'initial description', then that is printed
;otherwise, the 'description' string is printed
*MOD
print_obj_description
	push af
	ld c,INITIAL_DESC_ID
	call get_obj_attr
	cp 0ffh		
	jp nz,$x?			
	ld c,DESC_ID	;no inital description, print regular one
	call get_obj_attr
$x?	ld b,a
	ld ix,string_table
	call print_table_entry
	call printcr
	pop af
	ret
	
;obj id is in b
print_obj
		push bc
		call print_obj_description ;takes param in b
		nop ; print contents
		pop bc
		ret
		
;player has light	
;player has light result in 'a'
*MOD
player_has_light
		;is the room emitting light?
		call get_player_room 
		ld b,a
		ld c,EMITTING_LIGHT
		call get_obj_prop
		cp a
		jp z,$y?
		ld hl,OBJ_ENTRY_SIZE
		ld ix,obj_table ;loop over every object. if its a child of player
$lp?	ld a,(ix) ;and not inside a closed container return true
		cp 0ffh	;hit end? jump out
		nop ; is it emitting light?
		ld b,a  ; put obj id in 'b'
		ld c,EMITTING_LIGHT
		call get_obj_prop
		cp 0	
		jp z,$skp?	; if it's not 'lit' we don't care about it
		push af ; get player room into 'b'
		ld a,(player_room)
		ld b,a
		pop af
		ld c,a ; object id
		call is_descendant_of ; is it a in same room as player
		cp 0	
		jp z,$skp?	; if it's not 'lit' we don't care about it
		nop ; need to set up args
		call inside_closed_container;
		cp 0
		jp z,$skp?	; inside closed container -> skip it
$skp?	add ix,hl ; skip to next object
		jp $lp	;repeat
$y?		ld a,1
		jp $x?
$n?		ld a,0		
$x?		ret

*MOD
count_visible_objects
		push af
		push ix
		ld a,0
$lp?	cp 0ffh
		jp z,$x?
		jp $lp
$x?		pop ix
		pop af
		ret

look_at_sub
		push af
		ld a,(sentence+1)
		ld b,a
		ld c,DESC_ID
		call get_obj_attr
		ld b,a
		ld ix,string_table
		call print_table_entry
		call printcr
		pop af
		ret
		
visobjs DB 0		
		
	