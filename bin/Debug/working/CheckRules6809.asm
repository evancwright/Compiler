;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; check rules table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

check_table
	.db 23 ; close
	.dw check_dobj_supplied
	.db 23 ; close
	.dw check_see_dobj
	.db 25 ; drink
	.dw check_dobj_supplied
	.db 25 ; drink
	.dw check_see_dobj
	.db 25 ; drink
	.dw check_have_dobj
	.db 15 ; drop
	.dw check_dobj_supplied
	.db 15 ; drop
	.dw check_see_dobj
	.db 15 ; drop
	.dw check_have_dobj
	.db 24 ; eat
	.dw check_dobj_supplied
	.db 24 ; eat
	.dw check_see_dobj
	.db 10 ; enter
	.dw check_dobj_supplied
	.db 10 ; enter
	.dw check_see_dobj
	.db 18 ; examine
	.dw check_dobj_supplied
	.db 18 ; examine
	.dw check_see_dobj
	.db 12 ; get
	.dw check_dobj_supplied
	.db 12 ; get
	.dw check_see_dobj
	.db 12 ; get
	.dw check_dont_have_dobj
	.db 14 ; kill
	.dw check_dobj_supplied
	.db 14 ; kill
	.dw check_see_dobj
	.db 16 ; light
	.dw check_dobj_supplied
	.db 16 ; light
	.dw check_see_dobj
	.db 16 ; light
	.dw check_have_dobj
	.db 20 ; open
	.dw check_dobj_supplied
	.db 20 ; open
	.dw check_see_dobj
	.db 26 ; put
	.dw check_dobj_supplied
	.db 26 ; put
	.dw check_see_dobj
	.db 26 ; put
	.dw check_prep_supplied
	.db 26 ; put
	.dw check_iobj_supplied
	.db 26 ; put
	.dw check_not_self_or_child
	.db 34 ; talk to
	.dw check_dobj_supplied
	.db 34 ; talk to
	.dw check_see_dobj
	.db -1 ; turn on
	.dw check_dobj_supplied
	.db -1 ; turn on
	.dw check_see_dobj
	.db -1 ; turn on
	.dw check_have_dobj
	.db 22 ; unlock
	.dw check_dobj_supplied
	.db 22 ; unlock
	.dw check_see_dobj
	.db -1 ; push,press
	.dw check_see_dobj
	.db -1 ; hit,strike
	.dw check_see_dobj
	.db 37 ; wear
	.dw check_have_dobj
	.db 36 ; read
	.dw check_see_dobj
	.db 255
