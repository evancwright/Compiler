;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NogoTableZ80.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

nogo_table
	DB 5
	DB "BLANK" ; 0
	DB 0 ; null terminator
	DB 22
	DB "YOU CAN'T GO THAT WAY." ; 1
	DB 0 ; null terminator
	DB 45
	DB "HIGH WALLS BLOCK ALL DIRECTIONS EXCEPT NORTH." ; 2
	DB 0 ; null terminator
	DB 47
	DB "THE TRAFFIC IS TOO CONGESTED IN THAT DIRECTION." ; 3
	DB 0 ; null terminator
	DB 255 ; end of table
