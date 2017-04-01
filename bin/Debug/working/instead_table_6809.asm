;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SentenceTable6809.asm 
; Machine Generated Sentence Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

actions_table
	.db 14,1,255,255	;kill PLAYER  
	.dw kill_self_sub
	.db 34,1,255,255	;talk to PLAYER  
	.dw talk_to_self_sub
	.db 29,255,255,255	;listen   
	.dw listen_sub
	.db 28,255,255,255	;smell   
	.dw smell_sub
	.db 30,255,255,255	;wait   
	.dw wait_sub
	.db 32,255,255,255	;yell   
	.dw yell_sub
	.db 33,255,255,255	;jump   
	.dw jump_sub
	.db 36,5,255,255	;read NOTE  
	.dw read_note_sub
	.db 36,254,255,255	;read *  
	.dw read_anything_sub
	.db 35,19,10,20	;hit MANNEQUIN with CRICKET BAT
	.dw hit_mannequin_with_bat_sub
	.db 10,3,255,255	;enter TARDIS  
	.dw enter_tardis_sub
	.db 38,16,255,255	;push BUTTON  
	.dw push_button_sub
	.db 22,3,10,26	;unlock TARDIS with SONIC SCREWDRIVER
	.dw unlock_tardis_with_sonicscrewdriver_sub
	.db 20,3,10,26	;open TARDIS with SONIC SCREWDRIVER
	.dw unlock_tardis_with_sonicscrewdriver_sub
	.db 26,23,6,27	;put HAT on EYESTALK
	.dw cover_eye_sub
	.db 255

