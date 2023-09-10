#importonce 

#import "equ.asm"

clear_screen: {
        ldx #$c7

    loop:
        lda CLR_CHAR
        sta SCREEN_RAM, x
        sta SCREEN_RAM+$00c8, x
        sta SCREEN_RAM+$0190, x
        sta SCREEN_RAM+$0258, x
        sta SCREEN_RAM+$0320, x

        lda CLR_COL
        sta COLOR_RAM, x
        sta COLOR_RAM+$00c8, x
        sta COLOR_RAM+$0190, x
        sta COLOR_RAM+$0258, x
        sta COLOR_RAM+$0320, x

        dex
        cpx #$ff
        bne loop

        rts
}

