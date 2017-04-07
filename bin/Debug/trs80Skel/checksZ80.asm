;check rules for z80 shell

ID equ 0
HOLDER equ 1
OBJ_ATTRS_SIZE equ 17
OBJ_SIZE equ 19

;returns 1 or 0 in register a
check_see_dobj
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
	
	
	