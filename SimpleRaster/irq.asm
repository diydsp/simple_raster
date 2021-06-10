*=$cd00
; ---------------------------
; IRQ test
irq_test

        sei        ;disable maskable IRQs

        lda #$7f        
        sta $dc0d  ;disable timer interrupts which can be generated by the two CIA chips
        sta $dd0d  ;the kernal uses such an interrupt to flash the cursor and scan the keyboard, so we better
                   ;stop it.

        lda $dc0d  ;by reading this two registers we negate any pending CIA irqs.
        lda $dd0d  ;if we don't do this, a pending CIA irq might occur after we finish setting up our irq.
                   ;we don't want that to happen.

        lda #$01   ;this is how to tell the VICII to generate a raster interrupt
        sta $d01a

        lda #$01   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        lda #$1b   ;as there are more than 256 rasterlines, the topmost bit of $d011 serves as
        sta $d011  ;the 8th bit for the rasterline we want our irq to be triggered.
                   ;here we simply set up a character screen, leaving the topmost bit 0.

        ;lda #$37   ;we turn off the BASIC here
        ;sta $01    ;the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of
        ;           ;SID/VICII/etc are visible
        lda #$35   ;we turn off the BASIC and KERNAL rom here
        sta $01    ;the cpu now sees RAM everywhere except at $d000-$e000, where still the registers of
                   ;SID/VICII/etc are visible

        lda #<irq  ;this is how we set up
        sta $fffe  ;the address of our interrupt code
        lda #>irq
        sta $ffff

        lda $dc0d  ;by reading this two registers we negate any pending CIA irqs.
        lda $dd0d  ;if we don't do this, a pending CIA irq might occur after we finish setting up our irq.
                   ;we don't want that to happen.


        cli        ;enable maskable interrupts again 
        
        rts
        
irq


        pha        ;store register A in stack
        txa
        pha        ;store register X in stack
        tya
        pha        ;store register Y in stack


        sec
        rol $d019



        ;lda #$ff   ;this is the orthodox and safe way of clearing the interrupt condition of the VICII.
        ;sta $d019

        ;do stuff
        
        ;inc $d020   ; test operation to tweak screen
call_irq_here
        jsr irq_row0


        ;this is how to tell at which rasterline we want the irq to be triggered
        ;lda $d012
        ;clc
        ;adc #20
        ;lda #255    ; override to exec irq once per frame
        ;sta $d012


        pla
        tay        ;restore register Y from stack (remember stack is FIFO: First In First Out)
        pla
        tax        ;restore register X from stack
        pla        ;restore register A from stack

        rti       


upd_col_regs
        ldx col_rows_idx

        ldy cols_row0,x
        sty $d020
        inx
        ldy cols_row0,x
        ;lda #$00

        ;sta $d021
        sty $d021
        ;sta $d021
        ;sty $d021

        inx
        ;lda cols_row0,x
        ;sta $d022
        inx
        ;lda cols_row0,x
        ;sta $d023
        inx

        stx col_rows_idx

        rts

col_rows_idx
        byte 0


irq_row0
        ; do stuff
        ldx #$00
        stx col_rows_idx

        jsr upd_col_regs
        
        lda #$08   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row1
        sta call_irq_here+1
        lda #>irq_row1
        sta call_irq_here+2
        rts

irq_row1
        ; do stuff
        jsr upd_col_regs

        lda #$10   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row2
        sta call_irq_here+1
        lda #>irq_row2
        sta call_irq_here+2
        rts

irq_row2
        ; do stuff
        jsr upd_col_regs

        lda #$1a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row3
        sta call_irq_here+1
        lda #>irq_row3
        sta call_irq_here+2
        rts

irq_row3
        ; do stuff
        jsr upd_col_regs

        lda #$22   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row4
        sta call_irq_here+1
        lda #>irq_row4
        sta call_irq_here+2
        rts

irq_row4
        ; do stuff
        jsr upd_col_regs

        lda #$2a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row5
        sta call_irq_here+1
        lda #>irq_row5
        sta call_irq_here+2
        rts

irq_row5
        ; do stuff
        jsr upd_col_regs

        lda #$32   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row6
        sta call_irq_here+1
        lda #>irq_row6
        sta call_irq_here+2
        rts

irq_row6
        ; do stuff
        jsr upd_col_regs

        lda #$3a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row7
        sta call_irq_here+1
        lda #>irq_row7
        sta call_irq_here+2
        rts

irq_row7
        ; do stuff
        jsr upd_col_regs

        lda #$42   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row8
        sta call_irq_here+1
        lda #>irq_row8
        sta call_irq_here+2
        rts

irq_row8
        ; do stuff
        jsr upd_col_regs

        lda #$4a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row9
        sta call_irq_here+1
        lda #>irq_row9
        sta call_irq_here+2
        rts

irq_row9
        ; do stuff
        jsr upd_col_regs

        lda #$52   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row10
        sta call_irq_here+1
        lda #>irq_row10
        sta call_irq_here+2
        rts

irq_row10
        ; do stuff
        jsr upd_col_regs

        lda #$5a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row11
        sta call_irq_here+1
        lda #>irq_row11
        sta call_irq_here+2
        rts

irq_row11
        ; do stuff
        jsr upd_col_regs

        lda #$62   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row12
        sta call_irq_here+1
        lda #>irq_row12
        sta call_irq_here+2
        rts

irq_row12
        ; do stuff
        jsr upd_col_regs

        lda #$6a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row13
        sta call_irq_here+1
        lda #>irq_row13
        sta call_irq_here+2
        rts

irq_row13
        ; do stuff
        jsr upd_col_regs

        lda #$72   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row14
        sta call_irq_here+1
        lda #>irq_row14
        sta call_irq_here+2
        rts

irq_row14
        ; do stuff
        jsr upd_col_regs

        lda #$7a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row15
        sta call_irq_here+1
        lda #>irq_row15
        sta call_irq_here+2
        rts

irq_row15
        ; do stuff
        jsr upd_col_regs

        lda #$82   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row16
        sta call_irq_here+1
        lda #>irq_row16
        sta call_irq_here+2
        rts

irq_row16
        ; do stuff
        jsr upd_col_regs

        lda #$8a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row17
        sta call_irq_here+1
        lda #>irq_row17
        sta call_irq_here+2
        rts

irq_row17
        ; do stuff
        jsr upd_col_regs

        lda #$92   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row18
        sta call_irq_here+1
        lda #>irq_row18
        sta call_irq_here+2
        rts

irq_row18
        ; do stuff
        jsr upd_col_regs

        lda #$9a   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row19
        sta call_irq_here+1
        lda #>irq_row19
        sta call_irq_here+2
        rts

irq_row19
        ; do stuff
        jsr upd_col_regs

        lda #$a2   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row20
        sta call_irq_here+1
        lda #>irq_row20
        sta call_irq_here+2
        rts

irq_row20
        ; do stuff
        jsr upd_col_regs

        lda #$aa   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row21
        sta call_irq_here+1
        lda #>irq_row21
        sta call_irq_here+2
        rts

irq_row21
        ; do stuff
        jsr upd_col_regs

        lda #$b2   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row22
        sta call_irq_here+1
        lda #>irq_row22
        sta call_irq_here+2
        rts

irq_row22
        ; do stuff
        jsr upd_col_regs

        lda #$ba   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row23
        sta call_irq_here+1
        lda #>irq_row23
        sta call_irq_here+2
        rts

irq_row23
        ; do stuff
        jsr upd_col_regs

        lda #$c2   ;this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row24
        sta call_irq_here+1
        lda #>irq_row24
        sta call_irq_here+2
        rts

irq_row24
        ; do stuff
        jsr upd_col_regs

        lda #$1b   ;as there are more than 256 rasterlines, the topmost bit of $d011 serves as
        sta $d011  ;the 8th bit for the rasterline we want our irq to be triggered.
                   ;here we simply set up a character screen, leaving the topmost bit 0.

        lda #$01    ;   this is how to tell at which rasterline we want the irq to be triggered
        sta $d012

        ; setup next row
        lda #<irq_row0
        sta call_irq_here+1
        lda #>irq_row0
        sta call_irq_here+2
        rts

cols_row0         byte  $0,$2,2,3      ; row 0
cols_row1         byte  $1,$0,3,4
cols_row2         byte  $e,$0,4,5      ;
cols_row3         byte  $e,$0,5,6
cols_row4         byte  $6,$6,6,7      ; row 4
cols_row5         byte  $6,$6,7,8
cols_row6         byte  $e,$e,8,9      ;
cols_row7         byte  $4,$4,9,10
cols_row8         byte  $4,$4,10,11    ; row 8
cols_row9         byte  $4,$4,11,12
cols_row10        byte  $4,$4,12,13  ;
cols_row11        byte  $a,$a,13,14
cols_row12        byte  $2,$2,14,15  ; row 12
cols_row13        byte  $2,$2,15,0
cols_row14        byte  $9,$9,0,1    ;
cols_row15        byte  $a,$a,1,2     
cols_row16        byte  $7,$7,2,3      ; row 16
cols_row17        byte  $7,$7,3,4
cols_row18        byte  $7,$7,4,5      ;
cols_row19        byte  $0,$5,5,6    
cols_row20        byte  $0,$0,6,7      ; row 20
cols_row21        byte  $0,$0,7,8
cols_row22        byte  $0,$0,8,9      ;
cols_row23        byte  $0,$0,9,10
cols_row24        byte  $0,$0,10,11    ; row 24

