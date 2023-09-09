#importonce 

#import "equ.asm"

clear_screen: {
        ldx #$f9

    loop:
        lda CLR_CHAR
        sta SCREEN_RAM, x
        sta SCREEN_RAM+$00fa, x
        sta SCREEN_RAM+$01f4, x
        sta SCREEN_RAM+$02ee, x

        lda CLR_COL
        sta COLOR_RAM, x
        sta COLOR_RAM+$00fa, x
        sta COLOR_RAM+$01f4, x
        sta COLOR_RAM+$02ee, x

        dex
        cpx #$ff
        bne loop

        rts
}
