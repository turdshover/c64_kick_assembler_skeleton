#importonce 

STATE_0001: .byte $00           //processor
STATE_0289: .byte $00           //keyboard
STATE_D020: .byte $00           //border color
STATE_D021: .byte $00           //background color
STATE_0286: .byte $00           //character color
STATE_0328: .byte $00           //STOP routine

STATE_D01A: .byte $00           //interrupt control register
STATE_0314: .byte $00           //IRQ routine address - lsb
STATE_0315: .byte $00           //IRQ routine address - msb


save_machine_state: {
        lda $0001               //save processor state
        sta STATE_0001

        lda $0289               //save keyboard buffer state
        sta STATE_0289

        lda $D020               //save border color
        sta STATE_D020

        lda $D021               //save background color
        sta STATE_D021

        lda $0286               //save character color
        sta STATE_0286

        lda $0328               //save STOP routine address
        sta STATE_0328

        sei

        lda $D01A               //save interrupt control register state
        sta STATE_D01A
        lda $0314               //save lsb of interrupt routine address
        sta STATE_0314
        lda $0315               //save msb of interrupt routine address
        sta STATE_0315

        cli

        rts
}

restore_machine_state: {
        sei
        lda STATE_0001          //restore processor state 
        sta $0001
    
        lda STATE_D01A          //restore interrupt control register state
        sta $D01A

        jsr $FDA3               //Initialize CIA's, SID volume; setup memory configuration; set and start interrupt timer

        lda STATE_0314          //restore lsb of interrupt routine address
        sta $0314
        lda STATE_0315          //restore msb of interrupt routine address
        sta $0315

        cli

        lda STATE_0289          //restore keyboard buffer state
        sta $0289

        lda STATE_D020          //restore border color
        sta $D020

        lda STATE_D021          //restore background color
        sta $D021

        lda STATE_0286          //restore character color
        sta $0286

        lda STATE_0328          //restore STOP routine address
        sta $0328

        rts
}
