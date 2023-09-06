BasicUpstart2(main)

#import "equ.asm"
#import "utils.asm"
#import "machine_state.asm"
#import "irq.asm"

main:
        jsr save_machine_state
        jsr clear_screen                //or jsr $E544

        lda #$05                        //yellow background
        sta $D020
        lda #$07                        //green border
        sta $D021

        lda $01                         //load processor state
        and #%11111000                  //grab lower 3 bits
        ora #%00000110                  //bank out BASIC
        sta $01

        lda #$fc                        //disable run/stop
        sta $0328

        jsr irq_setup

    main_loop:
        lda $DC01                       //load keyboard row matrix
        cmp #$ef                        //check if spacebar is pressed
        beq done                        //if so, break
        jmp main_loop

    done:
        jsr restore_machine_state
        jsr $E544                       //kernal clear screen routine
        lda #$00
        sta $00C6                       //clear the keyboard buffer

        rts