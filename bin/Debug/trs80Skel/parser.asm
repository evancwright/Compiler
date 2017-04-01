;z80 parser 

parse
		ld a,0	
		ld (hit_end),a		; clear flag	
		ld (word_count),a	; reset to 0
		ld hl,word1	
		ld (copydest),hl	; set copy dest
		ld a,(INBUF)		; get 1st char?	
		cp 0		
		jp z,print_ret_pardon
		call clear_buffers
		ld ix,INBUF		   ; set ix to input buffer
		ld iy,INBUF		   ; set iy to input buffer
		call move_to_start ; move to start of text
		call copy_words_to_buffers
		ld	a,(word_count)
		inc a
		ld (word_count),a
		ld	a,(hit_end) ;hit end?
		cp 1
		jp z,$vv?	
		nop ; get 2nd word
		call move_to_start
		call move_to_end
		ld hl,word2
		ld (copydest),hl
		call store_word
		call handle_prep
		nop ; now validate the verb
$vv?	call get_verbs_id
		cp 0ffh
		jp z,print_ret_bad_verb
		ld (sentence),a			;store verb id
$_x?	ret
	
copy_words_to_buffers
		call move_to_end  ;get 1st word
		call store_word	;
_x?		ret


;if the word in word2 is a prep, the 
;word is stuck on the end of word 1
;and copy addr is "backed up" to word2
;and word 2 is zeroed out.
handle_prep
	push iy
	push ix
	push hl
	push bc
	ld ix,word2
	ld iy,prep_table
	call get_table_index	
	ld a,b
	cp 0ffh ; found?
	jp z,$x?
	call move_prep
	ld hl,word2
	ld (copydest),hl
	ld a,(word_count) ; wordcount--
	dec a
	ld (word_count),a
$x?	pop bc
	pop hl
	pop ix
	pop iy
	ret

;moves word pointed to by ix
;to the end of the word1 buffer
move_prep
		push ix					; 2nd word was a prep
		push iy
		ld iy,word1
		call move_to_end
		ld a,20h ; space
		ld (iy),a ; overwrite null with space
		inc iy 	  ;move past space
		call strcpyi
		pop iy
		pop ix
		ret


		
;clears the variables where the words are stored
clear_buffers
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
	
;skips over spaces until ix points
;to a non space
;uses a,ix	
*MOD
move_to_start
		push iy ;catch ix to end of last word
		pop ix
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

;copies from (iy-ix) chars from ix to copydest
store_word 
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
		ldir		; (hl)->(de)
		ret
	
word1 DS 32
word2 DS 32
word3 DS 32
word4 DS 32
word5 DS 32
word6 DS 32
word7 DS 32
word8 DS 32
copydest DW 0000h
hit_end DB 0
word_count DB 0
sentence DS 4
