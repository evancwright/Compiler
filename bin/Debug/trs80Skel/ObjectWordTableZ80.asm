;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJECT WORD TABLE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

obj_word_table
	DB 0,0,255,255   ;   OFFSCREEN
	DB 1,1,255,255   ;   PLAYER
	DB 2,4,5,255   ;   NARROW ALLEY
	DB 3,6,255,255   ;   TARDIS
	DB 4,10,6,255   ;   INSIDE TARDIS
	DB 5,11,255,255   ;   NOTE
	DB 6,12,13,255   ;   BUSY INTERSECTION
	DB 7,14,15,255   ;   NORTH STREET
	DB 8,16,15,255   ;   EAST STREET
	DB 9,17,18,255   ;   1ST FLOOR
	DB 10,19,18,255   ;   2ND FLOOR
	DB 11,20,255,255   ;   BASEMENT
	DB 12,21,22,255   ;   INVENTORY ROOM
	DB 13,23,255,255   ;   DOOR
	DB 14,24,255,255   ;   LOBBY
	DB 15,25,255,255   ;   ELEVATOR
	DB 16,26,255,255   ;   BUTTON
	DB 17,27,255,255   ;   HALLWAY
	DB 18,28,29,255   ;   ROSE'S APARTMENT
	DB 19,30,255,255   ;   MANNEQUIN
	DB 20,31,32,255   ;   CRICKET BAT
	DB 21,33,255,255   ;   ROSE
	DB 22,34,255,255   ;   DALEK
	DB 23,35,255,255   ;   HAT
	DB 24,37,38,255   ;   PLASTIC HEAD
	DB 25,39,255,255   ;   TORSO
	DB 26,40,41,255   ;   SONIC SCREWDRIVER
	DB 27,44,255,255   ;   EYESTALK
	DB 28,48,255,255   ;   TRENZALORE
	DB 29,28,23,255   ;   ROSE'S DOOR
	DB 30,49,255,255   ;   KEY
	DB 0,-1,255,255   ;   synonyms for OFFSCREEN
	DB 1,2,3,255   ;   synonyms for PLAYER
	DB 3,7,8,9   ;   synonyms for TARDIS
	DB 8,-1,255,255   ;   synonyms for EAST STREET
	DB 22,-1,255,255   ;   synonyms for DALEK
	DB 23,36,255,255   ;   synonyms for HAT
	DB 26,42,43,255   ;   synonyms for SONIC SCREWDRIVER
	DB 27,45,46,47   ;   synonyms for EYESTALK
	DB 28,-1,255,255   ;   synonyms for TRENZALORE
	DB 255
obj_table_size	DB 31
