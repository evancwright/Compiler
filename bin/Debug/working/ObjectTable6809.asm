;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJECT_TABLE
; FORMAT: ID,HOLDER,INITIAL DESC,DESC,N,S,E,W,NE,SE,SW,NW,UP,DOWN,OUT,MASS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

obj_table
	.db 0,0,255,0,255,255,255,255,255,255,255,255,255,255,255,255,0   ; OFFSCREEN
	.db 0    ;  flags 1 - 8
	.db 0    ;  flags 9 - 16
	.db 1,2,255,1,255,255,255,255,255,255,255,255,255,255,255,255,0   ; PLAYER
	.db 0    ;  flags 1 - 8
	.db 0    ;  flags 9 - 16
	.db 2,0,255,2,6,255,255,255,255,255,255,255,255,255,255,255,0   ; NARROW ALLEY
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 3,2,4,3,255,255,255,255,255,255,255,255,255,255,255,255,0   ; TARDIS
	.db OPENABLE_MASK ; flags 1-8
	.db 0    ;  flags 9 - 16
	.db 4,0,255,5,255,255,255,2,255,255,255,255,255,255,255,2,0   ; INSIDE TARDIS
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 5,4,6,3,255,255,255,255,255,255,255,255,255,255,255,255,0   ; NOTE
	.db 0    ;  flags 1 - 8
	.db PORTABLE_MASK ; flags 9-16
	.db 6,0,255,7,7,2,8,255,255,255,255,255,255,255,255,255,0   ; BUSY INTERSECTION
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 7,0,255,8,255,6,255,14,255,255,255,255,255,255,255,255,0   ; NORTH STREET
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 8,0,255,9,9,255,255,6,255,255,255,255,255,255,255,255,0   ; EAST STREET
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 9,0,255,10,255,8,255,255,255,255,255,255,10,11,255,255,0   ; 1ST FLOOR
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 10,0,255,11,255,255,255,255,255,255,255,255,255,9,255,255,0   ; 2ND FLOOR
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 11,0,255,12,255,12,255,255,255,255,255,255,9,255,255,255,0   ; BASEMENT
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 12,0,255,13,11,255,255,255,255,255,255,255,255,255,255,255,0   ; INVENTORY ROOM
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 13,11,255,3,255,13,255,255,255,255,255,255,255,255,255,255,0   ; DOOR
	.db SCENERY_MASK|OPENABLE_MASK|LOCKABLE_MASK|LOCKED_MASK ; flags 1-8
	.db DOOR_MASK ; flags 9-16
	.db 14,0,255,14,255,255,7,15,255,255,255,255,255,255,255,255,0   ; LOBBY
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 15,0,255,15,255,255,14,255,255,255,255,255,255,255,255,255,0   ; ELEVATOR
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 16,15,16,3,255,255,255,255,255,255,255,255,255,255,255,255,0   ; BUTTON
	.db 0    ;  flags 1 - 8
	.db 0    ;  flags 9 - 16
	.db 17,0,255,17,255,255,18,15,255,255,255,255,255,255,255,255,0   ; HALLWAY
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 18,0,255,18,255,255,255,17,255,255,255,255,255,255,255,17,0   ; ROSE'S APARTMENT
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 19,9,20,19,255,255,255,255,255,255,255,255,255,255,255,255,0   ; MANNEQUIN
	.db 0    ;  flags 1 - 8
	.db 0    ;  flags 9 - 16
	.db 20,10,22,21,255,255,255,255,255,255,255,255,255,255,255,255,0   ; CRICKET BAT
	.db 0    ;  flags 1 - 8
	.db PORTABLE_MASK ; flags 9-16
	.db 21,12,23,3,255,255,255,255,255,255,255,255,255,255,255,255,0   ; ROSE
	.db 0    ;  flags 1 - 8
	.db 0    ;  flags 9 - 16
	.db 22,0,25,24,255,255,255,255,255,255,255,255,255,255,255,255,0   ; DALEK
	.db SUPPORTER_MASK ; flags 1-8
	.db 0    ;  flags 9 - 16
	.db 23,9,27,26,255,255,255,255,255,255,255,255,255,255,255,255,0   ; HAT
	.db 0    ;  flags 1 - 8
	.db PORTABLE_MASK ; flags 9-16
	.db 24,0,29,28,255,255,255,255,255,255,255,255,255,255,255,255,0   ; PLASTIC HEAD
	.db 0    ;  flags 1 - 8
	.db PORTABLE_MASK ; flags 9-16
	.db 25,0,31,30,255,255,255,255,255,255,255,255,255,255,255,255,0   ; TORSO
	.db 0    ;  flags 1 - 8
	.db 0    ;  flags 9 - 16
	.db 26,18,255,32,255,255,255,255,255,255,255,255,255,255,255,255,0   ; SONIC SCREWDRIVER
	.db 0    ;  flags 1 - 8
	.db PORTABLE_MASK ; flags 9-16
	.db 27,22,255,33,255,255,255,255,255,255,255,255,255,255,255,255,0   ; EYESTALK
	.db SCENERY_MASK ; flags 1-8
	.db 0    ;  flags 9 - 16
	.db 28,0,255,34,255,255,255,255,255,255,255,255,255,255,255,255,0   ; TRENZALORE
	.db 0    ;  flags 1 - 8
	.db EMITTING_LIGHT_MASK ; flags 9-16
	.db 255
