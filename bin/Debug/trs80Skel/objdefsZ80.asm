;object definitions

OFFSCREEN equ 0
PLAYER_ID equ 1

NO_OBJECT equ 255
ANY_OBJECT equ 254

;byte 1
PORTABLE_MASK equ 1
EDIBLE_MASK equ 2
BACKDROP_MASK equ 2
DRINKABLE_MASK equ 4
FLAMMABLE_MASK equ 8
LIGHTABLE_MASK equ 16
LIT_MASK equ 32	
EMITTING_LIGHT_MASK equ 32
DOOR_MASK equ 64
UNUSED_MASK equ 128

PORTABLE_BIT EQU 0
EDIBLE_BIT EQU 1
DRINKABLE_BIT EQU 2
FLAMMABLE_BIT EQU 3
LIGHTABLE_BIT EQU 4
LIT_BIT	 EQU 5
DOOR_BIT EQU 6
UNUSED_BIT EQU 7

;(PROPERTY_BYTE_2)
SCENERY_MASK equ 1
SUPPORTER_MASK equ 2
CONTAINER_MASK equ 4
TRANSPARENT_MASK equ 8
OPENABLE_MASK equ 16
OPEN_MASK equ 32
LOCKABLE_MASK equ 64
LOCKED_MASK equ 128
OPEN_CONTAINER equ OPEN+CONTAINER 

;byte 2
SCENERY_BIT EQU 0
SUPPORTER_BIT EQU 1
CONTAINER_BIT EQU 2
TRANSPARENT_BIT EQU 3
OPENABLE_BIT EQU 4
OPEN_BIT EQU 5
LOCKABLE_BIT EQU 6
LOCKED_BIT	EQU 7

; objdefs.asm

OBJ_ID equ 0
HOLDER_ID equ 1
INITIAL_DESC_ID equ  2
DESC_ID equ 3
NORTH equ 4
SOUTH equ 5
EAST equ 6
WEST equ 7
NORTHEAST equ 8
SOUTHEAST equ 9
SOUTHWEST equ 10
NORTHWEST equ 11
UP equ 12
DOWN equ 13
ENTER equ 14
OUT equ 15
MASS equ 16

OBJ_ENTRY_SIZE equ 19
PROPERTY_BYTE_1 equ 17
PROPERTY_BYTE_2 equ 18
;byte 1
SCENERY equ 1 
SUPPORTER equ 2
CONTAINER equ 3
TRANSPARENT equ 4
OPENABLE equ 5
OPEN equ 6
LOCKABLE equ 7
LOCKED equ 8
PORTABLE equ 9
BACKDROP equ 10
DRINKABLE equ 11
FLAMMABLE equ 12
LIGHTABLE equ 13
LIT equ 14
EMITTING_LIGHT equ 14
DOOR equ 15
UNUSED equ 16
;byte 2
PORTABLE_MASK equ 1
BACKDROP_MASK equ 2
DRINKABLE_MASK equ 4
FLAMMABLE_MASK equ 8
LIGHTABLE_MASK equ 16
LIT_MASK equ 32	
EMITTING_LIGHT_MASK equ 32
DOOR_MASK equ 64
UNUSED_MASK equ 128
