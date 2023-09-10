#importonce 

irq_setup: {
        sei

        lda #%01111111          //disable CIA timers
        sta $DC0D
        sta $DD0D

        lda #%000000001         //enable raster interrupts
        sta $D01A

        lda #$33                //line number for raster interrupt - lsb
        sta $D012
        lda #%00011011          //bit 7: msb for lines above $ff
        sta $D011

        lda #<irq_main          //interrupt routine address - lsb
        sta $0314
        lda #>irq_main          //interrupt routine address - msb
        sta $0315

        lda $DC0D               //re-enable CIA timer A
        lda $DD0D               //re-enable CIA timer B
        bit $D019               //clear any pending interrupts

        cli

        rts
}

irq_main: {
        lda #%00000001          //are we dealing with a raster interrupt
        bit $D019               //and not a timer/etc?
        beq leave               //no, so leave & let the kernal handle it

        lda $D012               //get current raster line
        cmp #$f9                //are we at line $f9?
        bne blue_border         //no, change to blue border
        ldx #$05                //yes, switch border back to green
        lda #$33                //change raster interrupt line back to $33
        jmp irq_done

    blue_border:
        ldx #$06                //change border to blue
        lda #$f9                //change raster line to $f9
    
    irq_done:
        stx $D020               //store new border color
        sta $D012               //store new raster line
        asl $D019               //re-enble the interrupt

    leave:
        jmp $EA31
}
