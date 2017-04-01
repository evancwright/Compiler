;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJECT WORD TABLE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

obj_word_table
	.db 0,0,255,255   ;   OFFSCREEN
	.db 1,1,255,255   ;   PLAYER
	.db 2,4,5,255   ;   NARROW ALLEY
	.db 3,6,255,255   ;   TARDIS
	.db 4,10,6,255   ;   INSIDE TARDIS
	.db 5,11,255,255   ;   NOTE
	.db 6,12,13,255   ;   BUSY INTERSECTION
	.db 7,14,15,255   ;   NORTH STREET
	.db 8,16,15,255   ;   EAST STREET
	.db 9,17,18,255   ;   1ST FLOOR
	.db 10,19,18,255   ;   2ND FLOOR
	.db 11,20,255,255   ;   BASEMENT
	.db 12,21,22,255   ;   INVENTORY ROOM
	.db 13,23,255,255   ;   DOOR
	.db 14,24,255,255   ;   LOBBY
	.db 15,25,255,255   ;   ELEVATOR
	.db 16,26,255,255   ;   BUTTON
	.db 17,27,255,255   ;   HALLWAY
	.db 18,28,29,255   ;   ROSE'S APARTMENT
	.db 19,30,255,255   ;   MANNEQUIN
	.db 20,31,32,255   ;   CRICKET BAT
	.db 21,33,255,255   ;   ROSE
	.db 22,34,255,255   ;   DALEK
	.db 23,35,255,255   ;   HAT
	.db 24,37,38,255   ;   PLASTIC HEAD
	.db 25,39,255,255   ;   TORSO
	.db 26,40,41,255   ;   SONIC SCREWDRIVER
	.db 27,44,255,255   ;   EYESTALK
	.db 28,48,255,255   ;   TRENZALORE
	.db 0,-1,255,255   ;   synonyms for OFFSCREEN
	.db 1,2,3,255   ;   synonyms for PLAYER
	.db 3,7,8,9   ;   synonyms for TARDIS
	.db 8,-1,255,255   ;   synonyms for EAST STREET
	.db 22,-1,255,255   ;   synonyms for DALEK
	.db 23,36,255,255   ;   synonyms for HAT
	.db 26,42,43,255   ;   synonyms for SONIC SCREWDRIVER
	.db 27,45,46,47   ;   synonyms for EYESTALK
	.db 28,-1,255,255   ;   synonyms for TRENZALORE
	.db 255
obj_table_size	.db 29
