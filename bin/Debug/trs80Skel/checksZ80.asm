;check rules for z80 shell

ID equ 0
HOLDER equ 1
OBJ_ATTRS_SIZE equ 17
OBJ_SIZE equ 19

;returns 1 or 0 in register a
check_see_dobj
	push af
	push bc
	push hl
    call get_player_room
	ld b,a
	ld a,(sentence+1)
	ld c,a
	call b_ancestor_of_c
	cp 1
	jp z,$y?;
	ld hl,nosee
	call OUTLIN
	call printcr
	jp $x?
$y?	pop hl
	pop bc
	pop af
	ret


;returns 1 or 0 in register a
check_see_iobj
	ret

check_dobj_supplied
	ret

check_iobj_supplied
	ret

check_have_dobj

	ret

;checks if the do is a child of the io	
check_not_self_or_child
	ret

check_prep_supplied
	ret
	
check_dont_have_dobj
	ret
;returns a property in a
;object is on top
;attr # is under that
get_attribute
	pop bc
	
	ret	
	
get_property
	ret	
	
;checks 
is_parent_of
	push bc	
	pop bc
	ret
	
;checks if the argument on the stack is visible to player	
is_visible
	ret
	
nosee DB "YOU DON'T SEE THAT.",0h	
	