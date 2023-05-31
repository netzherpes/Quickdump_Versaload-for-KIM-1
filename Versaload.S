
;*****************************
;* VERSALOAD                 *
;* part2                     *
;*****************************

EALB     =       $c9
EALH     =       $ca
LFLG     =       $cb
SWI1     =       $d4
SWI2     =       $d5
OSAL     =       $d6
OSAH     =       $d7
CNTRL    =       $d8
IDTEMP   =       $d9
EOPL     =       $e2
EOPH     =       $e3
INH      =       $f9
POINTL   =       $fa
POINTH   =       $fb
RALOAD   =       $0227
smlRAM   =       $1780
CHKL     =       $17e7
CHKH     =       $17e8
SavX1    =       $17ea
VEB1     =       $17ed
VEB2     =       $17ee
SAL      =       $17f5
SAH      =       $17f6
EAL      =       $17f7
EAH      =       $17f8
ID       =       $17f9
LOADT    =       $188c
LOADT9   =       $1929
INTVEB   =       $1932
INITVEB12 =      $193e
CHKT     =       $194c
INCVEB   =       $19ea
RDBYT    =       $19f3
RDCHT    =       $1a24
SCANDS   =       $1f1f

         .org    $0800
Dupe:    lda     #$22
         bne     Gosub
Dictry:  lda 	 #$01
		 bne	 Gostr
LinkOE:  lda	 #$c0
		 bne	 Gostr
LinkBU:  lda	 #$e0
		 bne	 Gostr
Reloe:	 lda	 #$40
		 bne	 Gostr
RelBuf:	 lda	 #$62
Gostr: 	 jmp	 Entry
LoadOE:	 lda	 #$00
		 beq	 Gosub
LoadBU:  lda	 #$28
		 bne	 Gosub
DataLB:  lda	 #$24
Gosub:   jsr     Entry
         jmp     $1c4f

Entry:   asl     A
         sta     CNTRL
         bcc     NoLink
         lda     VEB1
         sta     SAL
         lda     VEB2
         sta     SAH
NoLink:  bit     CNTRL
         bvc     XID
         lda     EAL
         sta     EALB
         lda     EAH
         sta     EALH
XID:     lda     ID
         sta     IDTEMP
SuperL:  lda     #$00
         sta     ID
         sta     LFLG
         sta     SWI2
LoadOn:  lda     #$60
         sta     VEB1-1
         jsr     LOADT
         sta     SWI1
NextCH:  jsr     RDCHT
         lda     SavX1
         ldx     CNTRL
         cpx     #$02
         bne     next2
         jmp     ShowD1

next2:   ldx     SWI1
         bne     CompTB
         cmp     IDTEMP
         bne     next3
         sta     IDTEMP
         beq     NumbYT

next3:   cpx     IDTEMP
         beq     NumbYT
         bne     SuperL

CompTB:  ldx     SWI2
         cmp     smlRAM,x
         bne     LoadOn
         inc     SWI2
         lda     #$05
         cmp     SWI2
         bcs     NextCH
EOHead:  lda     SWI1
         cmp     SWI2
         bcc     NumbYT
         jsr     RDCHT
         lda     SavX1
         ldx     SWI2
         sta     smlRAM,x
         inc     SWI2
         jmp     EOHead

NumbYT:  lda     VEB1
         sta     OSAL
         lda     VEB2
         sta     OSAH
         lda     #$8d
         sta     VEB1-1
         jsr     RDCHT
         lda     CNTRL
         beq     initVEB
         cmp     #$10
         bne     XChng
initVEB: jsr     INITVEB12
         jmp     Compu

XChng:   jsr     INTVEB
Compu:   clc
         lda     SavX1
         adc     VEB1
         sta     EOPL
         php
         jsr     RDCHT
         plp
         lda     SavX1
         adc     VEB2
         sta     EOPH
Patch1:  jsr     RDCHT
         lda     SavX1
         jsr     CHKT
         jsr     VEB1-1
         jsr     INCVEB
         lda     VEB1
         bit     CNTRL
         bvc     Patch3
         cmp     EALB
         bne     Patch3
         beq     Patch4

Patch3:  cmp     EOPL
         bne     Patch1
Patch4:  lda     VEB2
         bit     CNTRL
         bvc     Patch5
         cmp     EALH
         bne     Patch5
         cmp     EOPH
         bne     Error2
         lda     VEB1
         cmp     EOPL
         bne     Error2
         beq     Patch6

Patch5:  cmp     EOPH
         bne     Patch1
Patch6:  jsr     RDCHT
         cmp     #$2f
         bne     Error
         jsr     RDBYT
         cmp     CHKL
         bne     Error
         jsr     RDBYT
         cmp     CHKH
         bne     Error
         lda     CNTRL
         bpl     BufA
         lda     OSAL
         sta     EAL
         lda     OSAH
         sta     EAH
         jmp     RALOAD

BufA:    and     #$0c
         beq     Exit
         lda     VEB1
         sta     EAL
         lda     VEB2
         sta     EAH
         lda     CNTRL
         cmp     #$48
         beq     Exit
         lda     IDTEMP
         sta     ID
         lda     #$dd
         sta     INH
         sta     POINTL
         sta     POINTH
Show1:   jsr     SCANDS
         beq     Show1
         ldx     #$01
         jmp     $0611

Error:   dec     LFLG
Error2:  dec     LFLG
         bit     CNTRL
         bmi     @L097A
         pla
         pla
@L097A:  jmp     LOADT9

Exit:    rts

ShowD1:  sta     INH
         lda     VEB1
         sta     POINTL
         lda     VEB2
         sta     POINTH
Show2:   jsr     SCANDS
         beq     Show2
         jmp     SuperL

End:     nop
