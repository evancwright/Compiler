;container routines
*MOD
put_sub
		ld a,(sentence+3) 
		ld b,a
		ld c,CONTAINER_BIT
		call get_obj_prop
		cp 1
		jp z,$c?
		ld c,SUPPORTER_BIT
		call get_obj_prop
		cp 1
		jp z,$c?
		inc sp
		inc sp
		jp print_ret_not_container
$c?		nop ; move obj
		ld hl,done
	    call OUTLIN
		call printcr
		ret
		
open_sub
		ret
				
close_sub
		ret
		
done DB "DONE.",0h
