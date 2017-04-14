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
		call print_obj_name
		call printcr
		ld b,a
		call print_obj_desc
		ld h,a
		nop ; now print all visible objects
 		ld ix,obj_table
$lp?	ld a,(ix);get id
		cp 0		; skip offscreen
		jp z,$c?
		cp 1		; skip player
		jp z,$c?
		cp 0ffh
		jp z,$x?
		bit SCENERY_BIT,(ix+PROPERTY_BYTE_1)
		jp nz,$c?
;		nop ; is this object in this room?
		ld a,(ix+HOLDER) ; get holder byte
		cp b
		jp nz,$c?
		ld a,(ix) ; reload obj id byte
		push bc
		ld b,a ; 
		call z,list_object ; look at id 'b'
		pop bc
$c?		add ix,de ; skip object
		jp $lp?
$x?		pop ix
		pop hl
		pop de
		pop bc
		ret

;prints description of obj in 'b'
print_obj_desc
	push af
	push bc
	push ix
	ld c,DESC_ID
	call get_obj_attr ; res to 'a'
	ld b,a
	ld ix,string_table
	call print_table_entry
	call printcr
	pop ix
	pop bc
	pop af
	ret
		
;prints the initial description for object in b
;if it has one. Otherwise it defaults to "THERE IS A ____ HERE"
*MOD
list_object
	push af
	push bc
	push ix
	ld c,INITIAL_DESC_ID
	call get_obj_attr 
	cp 0ffh		
	jp z,$n?			
	ld b,a
	ld ix,string_table
	call print_table_entry ; uses b and ix
	call printcr
	jp $x? 
$n?	ld hl,thereisa
	push bc
    call OUTLIN
	pop bc
	ld a,b
	call print_obj_name
	ld hl,here
	call OUTLIN
	call printcr
$x?	pop ix
	pop bc
	pop af
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
		call b_ancestor_of_c ; is it a in same room as player
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
thereisa DB  "THERE IS A ",0h
here DB "HERE.",0h		
	