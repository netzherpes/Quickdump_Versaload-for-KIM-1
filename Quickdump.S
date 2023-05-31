
;*****************************
;* Quickdump                 *
;* 1978                      *
;* (c) John Oliver           *
;* UoFl                      *
;*****************************
        
GANG     =       $cc
TIC      =       $cd
COUNT    =       $ce
TRIB     =       $cf
NPUL     =       $d0
TIMG     =       $d1
SWI1     =       $d4
SWI2     =       $d5
OSAL     =       $d6
OSAH     =       $d7
SBD      =       $1743
CLK1T    =       $1744
CLKRD1   =       $1747
CHKL     =       $17e7
CHKH     =       $17e8
VEB      =       $17ec
SAL      =       $17f5
SAH      =       $17f6
EAL      =       $17f7
ID       =       $17f9
INTVEB   =       $1932
CHKT     =       $194c
INCVEB   =       $19ea
KIM      =       $1c4f

         .org    $0600
StartA:  lda     #$00
         tax
         beq     Gosub
StartB:  lda     #$05
         ldx     #$00
Gosub:   jsr     Entry1
         jmp     KIM

Entry1:  sta     SWI1
         stx     SWI2
         ldx     #$04
StoTab:  lda     Tab,x
         sta     TRIB,x
         dex
         bne     StoTab
SuperD:  lda     #$ad
         sta     VEB
         jsr     INTVEB
         lda     #$27
         sta     GANG
         lda     #$bf
         sta     SBD
         lda     #$20
         sta     TIC
         lda     #$16
Hic1:    pha
         jsr     OutCHT
         pla
         dec     TIC
         bne     Hic1
         lda     #$2a
         jsr     OutCHT
         lda     #$00
         jsr     OutBT
         lda     SWI2
         bne     Dup1
         lda     SAL
         jsr     OutBT
         lda     SAH
         jsr     OutBT
         jmp     SendID

Dup1:    lda     OSAL
         jsr     OutBT
         lda     OSAH
         jsr     OutBT
SendID:  lda     SWI1
         jsr     OutBT
         lda     SWI1
         bne     SendTB
         lda     ID
         jsr     OutCHT
         jmp     NumbOb

SendTB:  lda     #$00
         sta     SWI2
LoSwi:   ldx     SWI2
         lda     $1780,x
         jsr     OutCHT
         inc     SWI2
         lda     SWI1
         cmp     SWI2
         bcs     LoSwi
NumbOb:  sec
         lda     EAL
         sbc     SAL
         php
         jsr     OutCHT
         plp
         lda     ID-1
         sbc     SAH
         jsr     OutCHT
         jsr     $1943
SupDP1:  jsr     VEB
         jsr     OutCHC
         jsr     INCVEB
         lda     VEB+1
         cmp     EAL
         lda     VEB+2
         sbc     ID-1
         bcc     SupDP1
         lda     #$2f
         jsr     OutCHT
         lda     CHKL
         jsr     OutBT
         lda     CHKH
         jsr     OutBT
         lda     #$04
         jsr     OutCHT
         rts

OutBT:   pha
         lsr     A
         lsr     A
         lsr     A
         lsr     A
         jsr     HexTA
         jsr     OutCHT
         pla
         jsr     HexTA
         jsr     OutCHT
         rts

HexTA:   and     #$0f
         cmp     #$0a
         clc
         bmi     HexTA1
         adc     #$07
HexTA1:  adc     #$30
         rts

OutCHC:  jsr     CHKT
OutCHT:  ldy     #$08
         sty     COUNT
Try:     ldy     #$02
         sty     TRIB
Zon:     ldx     NPUL,y
         pha
Zon1:    sei
Zon2:    bit     CLKRD1
         bpl     Zon2
         lda     TIMG,y
         sta     CLK1T
         lda     GANG
         eor     #$80
         sta     SBD-1
         cli
         sta     GANG
         dex
         bne     Zon1
         pla
         dec     TRIB
         beq     SetZ
         bmi     ROut
         lsr     A
         bcc     Zon
SetZ:    ldy     #$00
         beq     Zon

ROut:    dec     COUNT
         bne     Try
         rts

Tab:     .byte   $17
         .byte   $02
         .byte   $c3
         .byte   $03
         .byte   $7e
End:     nop
