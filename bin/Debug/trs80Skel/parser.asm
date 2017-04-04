;z80 parser 
*MOD
parse
		ld a,0	
		ld (hit_end),a		; clear flag			ld (word_count),a	; reset to 0
		ld hl,word1	
		ld (copydest),hl	; set copy dest
		ld a,(INBUF)		; get 1st char?	
		cp 0		
		jp z,print_ret_pardon
		call clear_buffers
		ld ix,INBUF		   ; set ix to input buffer
		ld iy,INBUF		   ; set iy to input buffer
		call move_to_next  ; move to end of 1st word	
		call store_word	   ; save word 1	
		call move_to_next	; try to bracket at 2nd word
		ld a,(ix) ;hit end? (single verb command)
		cp 0 
		jp z,$_x?
		call handle_prep ; compress preposition if needed and go to word 3
		ld hl,word2		 ; copy direct object	
		ld (copydest),hl
		call skip_article	; skip article if present
		ld a,(ix) ;hit end? (single verb command)
		cp 0 
		jp z,$_x?
		call store_word		; store direct object
		call find_preposition  ;stores prep
		ld a,(prep_found)
		cp 0
		jp z, $_x? ; if no prep, we're done since we already have the d.o.
		nop ; store prep and move past it, then get io 
		ld a,(ix) ;hit end?
		cp 0 
		jp z,print_ret_no_io
		call skip_article
		ld a,(ix) ;hit end?
		cp 0 
		jp z,print_ret_no_io
		ld (iy),a
		ld hl,word4
		ld (copydest),hl
		call store_word
$_x?	ret

;skip_article
;moves to the next word, if that word is an article
;if it's not the last word
;ix must point to the word to look at
;ix are positioned at the start of the next word
*MOD
skip_article
		push af
		push de
		push hl
		ld a,(iy) 	
		ld d,a	;save char (null or space)
		ld a,0	;put a null there	
		ld (iy),a
		push iy 
		ld iy,article_table ; iy is table to search
		call get_table_index
		pop iy
		ld (iy),d ;replace null or space
		ld a,b
		cp 0ffh  ; not found -> take no action
		jp z,$x?		
		ld hl,DbgSA
		call OUTLIN
		call printcr
		call move_to_next ; move to end of next word
$x?		pop hl
		pop de
		pop af
		ret

;this subroutin e looks for a preposition
;if a prep is found, prep_found is set to 1,
;and the prep id is stored in sentence+2
*MOD
find_preposition
		push af
		push bc
		push de
		push hl
$lp?	ld a,(ix)
		cp 0
		jp z,$x?
		call move_to_next
		ld d,(iy)	; save char we're going to null out
		ld (iy),0   ;null out end of word
		push iy
		ld iy,prep_table
		call get_table_index
		pop iy		;
		ld (iy),d	; restore byte
		ld a,b		; move result to a
		cp 0ffh
		jp z,$lp?   ; if not prep hit, repeat
		nop 		; hit a preposition
		ld hl,word3
		ld (copydest),hl
		call store_word
		ld (sentence+2),a
		ld a,1
		ld (prep_found),a 
		call move_to_next ; find next word
$x?		pop hl
		pop de
		pop bc
		pop af
		ret

;if the word between ix and iy is a prep, the 
;word is stuck on the end of word 1 and ix,iy
;are moved to bracket the next word
;and word 2 is zeroed out.
*MOD
handle_prep
	push af
	push bc
	push de
	push hl
	push iy
	ld d,(iy) ; save char at end of word1
	ld (iy),0 ; null terminate word for string cmp
	ld iy,prep_table
	call get_table_index	
	pop iy
	ld a,b
	cp 0ffh ; found?
	jp z,$x? ; exit on not found
;	ld hl,DbgPF
;	call OUTLIN
	call move_prep ; doesn't change ix,iy
	ld (iy),d	; restore null or space
	call move_to_next ; move to next word
	jp $y?
$x?	ld (iy),d	; restore null or space
$y?	pop hl
	pop de
	pop bc
	pop af
	ret

;moves word pointed to by ix
;to the end of the word1 buffer
move_prep
		push ix					; 2nd word was a prep
		push iy
		push de
		ld a,(hit_end)	; save old flag
		ld d,a
		ld iy,word1
		call move_to_end
		ld a,20h ; space
		ld (iy),a ; overwrite null with space
		inc iy 	  ;move past space
		call strcpyi
		ld a,d
		ld (hit_end),a
		pop de
		pop iy
		pop ix
		ret


		
;clears the variables where the words are stored
clear_buffers
		ld a,0				; clear the 
		ld (prep_found),a
		ld a,0ffh
		ld (sentence),a
		ld (sentence+1),a
		ld (sentence+2),a
		ld (sentence+3),a
		ld b, 0
		ld ix,copydest-1
$lp 	ld (ix),b
		dec ix
		dec a
		cp 0
		jp nz,$lp
		ret
		
;brackets the next word with ix,iy		
move_to_next
	push iy ; move ix to end of last word
	pop ix
	ld a,(ix)
	cp 0  ; null?
	ret z	
	call move_to_start ; move to start of text
	call move_to_end ; move to start of text
 	ret
	
;skips over spaces until ix points
;to a non space
;uses a,ix	
*MOD
move_to_start
		push af
$_lp	ld a,(ix)
		cp 20h 		; space?
		jp z,$cnt?	; quit
		cp 0 		; null?
		jp z,$cnt?	; quit
		jp $x?
$cnt?	inc ix		;next char
		jp $_lp		;repeat
$x?		push ix	;copy ix to iy
		pop iy	;iy needs to catch up
		pop af
		ret

;moves iy to the 1st space or null at the end of 
;a word.  Assumes iy is already pointing to the
;start of the word
;uses iy
;if null is hit, hit_end is set to 1
move_to_end
			push af
$_lp?		ld a,(iy)	; get char
			call atoupper
			ld (iy),a
			cp 20h		; space?
			jp z, $_x
			cp 0		; null
			jp z, _he?
			inc iy
			jp $_lp?
_he?    	ld a,1
			ld (hit_end),a
$_x			pop af
			ret
;read do
*MOD	
read_dobj
	ld a,(hit_end)
	cp 1
	ret z
	;	call skip_article  ; call skip_article
	ld hl,word2
	ld (copydest),hl
	call move_to_start
	call move_to_end
	call store_word
	ret
			
;copies from (iy-ix) chars from ix to copydest
store_word 
		push bc
		push de
		push hl
		scf	;clear the carry flag by setting it...
		ccf ;then flipping it
		push iy ; copy iy to hl
		pop hl
		push ix	; copy ix to bc
		pop bc
		sbc hl,bc
		push hl	; byte count to bc
		pop bc
		push ix  ; ix->hl	
		pop hl
		ld de,(copydest)
		ldir		; (hl)->(de) until bc=0
		pop hl
		pop de
		pop bc
		ret

*MOD
lkp_verb
	call get_verbs_id 
	cp 0ffh
	jp nz,$x?
	inc sp  ; return from caller
	inc sp
	jp print_ret_bad_verb
$x?	ld (sentence),a ; store verb
	ret		
		
*MOD
lkp_directobj
		push ix
		push iy
		push af
		ld ix,word2
		ld iy,dictionary
		call get_table_index
		ld a,b
		cp 0ffh	 ; was it found
		jp nz,$_x?
		nop ; look up obj and store it in sentence+1
		pop af ; clean up stack for return jump
		pop iy
		pop ix
		inc sp
		inc sp
		jp print_ret_bad_do
$_x?	pop af
		pop iy
		pop ix
		ret
		
		
*MOD
lkp_indirectobj
		push ix
		push iy
		push af
		ld ix,word4
		ld iy,dictionary
		call get_table_index
		ld a,b
		cp 0ffh	 ; was it found
		jp nz,$_x?
		nop ; look up obj and store it in sentence+
		pop af ; clean up stack for return jump
		pop iy
		pop ix
		inc sp
		inc sp
		jp print_ret_bad_io
$_x?	pop af
		pop iy
		pop ix
		ret

DbgPF DB "DBG:PREP FOUND",0h		
DbgSA DB "DBG:SKIPPING ARTICLE",0h		
		
word1 DS 32
word2 DS 32
word3 DS 32
word4 DS 32
word5 DS 32
word6 DS 32
word7 DS 32
word8 DS 32
copydest DW 0000h
prepaddr DW 0000h
hit_end DB 0
word_count DB 0
sentence DS 4
prep_found DB 0
parse_err DB 0