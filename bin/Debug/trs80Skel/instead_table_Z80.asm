;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; instead_table_Z80.asm
; Machine Generated Sentence Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

actions_table
	DB 14,1,255,255	;kill PLAYER  
	DW kill_self_sub
	DB 34,1,255,255	;talk to PLAYER  
	DW talk_to_self_sub
	DB 29,255,255,255	;listen   
	DW listen_sub
	DB 28,255,255,255	;smell   
	DW smell_sub
	DB 30,255,255,255	;wait   
	DW wait_sub
	DB 32,255,255,255	;yell   
	DW yell_sub
	DB 33,255,255,255	;jump   
	DW jump_sub
	DB 36,5,255,255	;read NOTE  
	DW read_note_sub
	DB 36,254,255,255	;read *  
	DW read_anything_sub
	DB 35,19,10,20	;hit MANNEQUIN with CRICKET BAT
	DW hit_mannequin_with_bat_sub
	DB 10,3,255,255	;enter TARDIS  
	DW enter_tardis_sub
	DB 38,16,255,255	;push BUTTON  
	DW push_button_sub
	DB 22,3,10,26	;unlock TARDIS with SONIC SCREWDRIVER
	DW unlock_tardis_with_sonicscrewdriver_sub
	DB 20,3,10,26	;open TARDIS with SONIC SCREWDRIVER
	DW unlock_tardis_with_sonicscrewdriver_sub
	DB 26,23,6,27	;put HAT on EYESTALK
	DW cover_eye_sub
	DB 22,29,10,30	;unlock ROSE'S DOOR with KEY
	DW unlock_door_with_key_sub
	DB 22,29,255,255	;unlock ROSE'S DOOR  
	DW unlock_door_sub
	DB 255

