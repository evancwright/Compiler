;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VerbTableZ80.asm 
; Machine Generated Verb Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

n_verb_id equ 0
s_verb_id equ 1
e_verb_id equ 2
w_verb_id equ 3
ne_verb_id equ 4
se_verb_id equ 5
sw_verb_id equ 6
nw_verb_id equ 7
up_verb_id equ 8
down_verb_id equ 9
enter_verb_id equ 10
out_verb_id equ 11
get_verb_id equ 12
inventory_verb_id equ 13
kill_verb_id equ 14
drop_verb_id equ 15
light_verb_id equ 16
look_verb_id equ 17
examine_verb_id equ 18
look_in_verb_id equ 19
open_verb_id equ 20
lock_verb_id equ 21
unlock_verb_id equ 22
close_verb_id equ 23
eat_verb_id equ 24
drink_verb_id equ 25
put_verb_id equ 26
quit_verb_id equ 27
smell_verb_id equ 28
listen_verb_id equ 29
wait_verb_id equ 30
climb_verb_id equ 31
yell_verb_id equ 32
jump_verb_id equ 33
talk_to_verb_id equ 34
hit_verb_id equ 35
read_verb_id equ 36
wear_verb_id equ 37
push_verb_id equ 38


verb_table
	DB 0
	DB 1
	DB "N"
	DB 0 ; null
	DB 0
	DB 8
	DB "GO NORTH"
	DB 0 ; null
	DB 0
	DB 5
	DB "NORTH"
	DB 0 ; null
	DB 1
	DB 1
	DB "S"
	DB 0 ; null
	DB 1
	DB 8
	DB "GO SOUTH"
	DB 0 ; null
	DB 1
	DB 5
	DB "SOUTH"
	DB 0 ; null
	DB 2
	DB 1
	DB "E"
	DB 0 ; null
	DB 2
	DB 7
	DB "GO EAST"
	DB 0 ; null
	DB 2
	DB 4
	DB "EAST"
	DB 0 ; null
	DB 3
	DB 1
	DB "W"
	DB 0 ; null
	DB 3
	DB 7
	DB "GO WEST"
	DB 0 ; null
	DB 3
	DB 4
	DB "WEST"
	DB 0 ; null
	DB 4
	DB 2
	DB "NE"
	DB 0 ; null
	DB 4
	DB 12
	DB "GO NORTHEAST"
	DB 0 ; null
	DB 4
	DB 9
	DB "NORTHEAST"
	DB 0 ; null
	DB 5
	DB 2
	DB "SE"
	DB 0 ; null
	DB 5
	DB 12
	DB "GO SOUTHEAST"
	DB 0 ; null
	DB 5
	DB 9
	DB "SOUTHEAST"
	DB 0 ; null
	DB 6
	DB 2
	DB "SW"
	DB 0 ; null
	DB 6
	DB 12
	DB "GO SOUTHWEST"
	DB 0 ; null
	DB 6
	DB 9
	DB "SOUTHWEST"
	DB 0 ; null
	DB 7
	DB 2
	DB "NW"
	DB 0 ; null
	DB 7
	DB 12
	DB "GO NORTHWEST"
	DB 0 ; null
	DB 7
	DB 9
	DB "NORTHWEST"
	DB 0 ; null
	DB 8
	DB 2
	DB "UP"
	DB 0 ; null
	DB 8
	DB 5
	DB "GO UP"
	DB 0 ; null
	DB 8
	DB 1
	DB "U"
	DB 0 ; null
	DB 9
	DB 4
	DB "DOWN"
	DB 0 ; null
	DB 9
	DB 7
	DB "GO DOWN"
	DB 0 ; null
	DB 9
	DB 1
	DB "D"
	DB 0 ; null
	DB 10
	DB 5
	DB "ENTER"
	DB 0 ; null
	DB 10
	DB 5
	DB "GO IN"
	DB 0 ; null
	DB 10
	DB 7
	DB "GO INTO"
	DB 0 ; null
	DB 10
	DB 9
	DB "GO INSIDE"
	DB 0 ; null
	DB 11
	DB 3
	DB "OUT"
	DB 0 ; null
	DB 12
	DB 3
	DB "GET"
	DB 0 ; null
	DB 12
	DB 4
	DB "TAKE"
	DB 0 ; null
	DB 12
	DB 4
	DB "GRAB"
	DB 0 ; null
	DB 12
	DB 7
	DB "PICK UP"
	DB 0 ; null
	DB 13
	DB 9
	DB "INVENTORY"
	DB 0 ; null
	DB 13
	DB 1
	DB "I"
	DB 0 ; null
	DB 14
	DB 4
	DB "KILL"
	DB 0 ; null
	DB 15
	DB 4
	DB "DROP"
	DB 0 ; null
	DB 16
	DB 5
	DB "LIGHT"
	DB 0 ; null
	DB 17
	DB 4
	DB "LOOK"
	DB 0 ; null
	DB 17
	DB 1
	DB "L"
	DB 0 ; null
	DB 18
	DB 7
	DB "EXAMINE"
	DB 0 ; null
	DB 18
	DB 1
	DB "X"
	DB 0 ; null
	DB 18
	DB 7
	DB "LOOK AT"
	DB 0 ; null
	DB 19
	DB 7
	DB "LOOK IN"
	DB 0 ; null
	DB 19
	DB 7
	DB "INSPECT"
	DB 0 ; null
	DB 19
	DB 6
	DB "SEARCH"
	DB 0 ; null
	DB 20
	DB 4
	DB "OPEN"
	DB 0 ; null
	DB 21
	DB 4
	DB "LOCK"
	DB 0 ; null
	DB 22
	DB 6
	DB "UNLOCK"
	DB 0 ; null
	DB 23
	DB 5
	DB "CLOSE"
	DB 0 ; null
	DB 23
	DB 4
	DB "SHUT"
	DB 0 ; null
	DB 24
	DB 3
	DB "EAT"
	DB 0 ; null
	DB 25
	DB 5
	DB "DRINK"
	DB 0 ; null
	DB 26
	DB 3
	DB "PUT"
	DB 0 ; null
	DB 26
	DB 5
	DB "PLACE"
	DB 0 ; null
	DB 27
	DB 4
	DB "QUIT"
	DB 0 ; null
	DB 28
	DB 5
	DB "SMELL"
	DB 0 ; null
	DB 28
	DB 5
	DB "SNIFF"
	DB 0 ; null
	DB 29
	DB 6
	DB "LISTEN"
	DB 0 ; null
	DB 30
	DB 4
	DB "WAIT"
	DB 0 ; null
	DB 31
	DB 5
	DB "CLIMB"
	DB 0 ; null
	DB 32
	DB 4
	DB "YELL"
	DB 0 ; null
	DB 32
	DB 6
	DB "SCREAM"
	DB 0 ; null
	DB 32
	DB 5
	DB "SHOUT"
	DB 0 ; null
	DB 33
	DB 4
	DB "JUMP"
	DB 0 ; null
	DB 34
	DB 7
	DB "TALK TO"
	DB 0 ; null
	DB 35
	DB 3
	DB "HIT"
	DB 0 ; null
	DB 35
	DB 6
	DB "STRIKE"
	DB 0 ; null
	DB 36
	DB 4
	DB "READ"
	DB 0 ; null
	DB 37
	DB 4
	DB "WEAR"
	DB 0 ; null
	DB 38
	DB 4
	DB "PUSH"
	DB 0 ; null
	DB 38
	DB 5
	DB "PRESS"
	DB 0 ; null
	DB 255
