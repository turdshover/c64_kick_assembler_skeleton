#importonce 

.label SCREEN_RAM = $0400       //start of screen ram
.label COLOR_RAM = $D800        //start of color ram

CLR_CHAR: .byte $20             //space character
CLR_COL: .byte $00              //black color