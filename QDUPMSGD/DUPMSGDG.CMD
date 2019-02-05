/* =================================================================== */
/*                                                                     */
/*  Kurzdokumentation :                                                */
/*                                                                     */
/*  Bereich . . . : DUPMSGD                                            */
/*  Objekt  . . . : DUPMSGD                                            */
/*  Beschreibung  : Tool: DUPMSGD    (Duplicate MessageD ) Ger         */
/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
/*  Datum . . . . : ?                                                  */
/*                                                                     */
/* =================================================================== */
/*                                                                     */
/*  This software is free software, you can redistribute it and/or     */
/*  modify it under the terms of the GNU General Public License (GPL)  */
/*  as published by the Free Software Foundation.                      */
/*                                                                     */
/*  See GNU General Public License for details.                        */
/*          http://www.opensource.org                                  */
/*          http://www.opensource.org/licenses/gpl-license.html        */
/*                                                                     */
/* =================================================================== */
/*  History:                                                           */
/*                                                                     */
/*  Datum       Name          Änderung                                 */
/*  ----------  ------------  ---------------------------------------  */
/*                                                                     */
/* =================================================================== */
/* >>PRE-COMPILER<<                                                    */
/*                                                                     */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */
/*                           SRCFILE(&SL/&SF) +                        */
/*                           SRCMBR(&SM);                              */
/*                                                                     */
/*   >>COMPILE<<                                                       */
/*     >>PARM<< PGM(*LIBL/DUPMSGDC);                                   */
/*     >>PARM<< HLPPNLGRP(*LIBL/DUPMSGDP);                             */
/*     >>PARM<< HLPID(DUPMSGD);                                        */
/*     >>PARM<< PRDLIB(&LI);                                           */
/*   >>END-COMPILE<<                                                   */
/*                                                                     */
/*   >>EXECUTE<<                                                       */
/*                                                                     */
/* >>END-PRE-COMPILER<<                                                */
/* =================================================================== */

             CMD        PROMPT('Nachrichtenbeschr. duplizieren')

             PARM       KWD(RANGE) +
                        TYPE(QMSGR) +
                        SNGVAL( +
                          (*ALL )) +
                        PROMPT('Bereich der Nachrichten-IDs' 1)

             PARM       KWD(FROMMSGF)                          +
                        TYPE(QUAL1)                            +
                        MIN(0)                                 +
                        PROMPT('Von Nachrichtendatei')

             PARM       KWD(TOMSGID)                           +
                        TYPE(*CHAR)                            +
                        LEN(7)                                 +
                        EXPR(*YES)                             +
                        DFT(*FROMID)                           +
                        PROMPT('Nach Nachrichten-ID')

             PARM       KWD(TOMSGF)                            +
                        TYPE(QUAL2)                            +
                        PROMPT('Nach Nachrichtendatei')

             PARM       KWD(REPLACE)                           +
                        TYPE(*CHAR)                            +
                        LEN(1)                                 +
                        EXPR(*YES)                             +
                        DFT(*NO)                               +
                        RSTD(*YES)                             +
                        SPCVAL((*YES Y)                        +
                               (*NO  N))                       +
                        PROMPT('Nachrichtenbeschr. ersetzen')

             PARM       KWD(MSGFLNG   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          CONSTANT(DUPMSGD  )

QMSGR:       ELEM       TYPE(*NAME) +
                        LEN(7) +
                        DFT(*FIRST) +
                        SPCVAL( +
                          (*FIRST *FIRST )) +
                        FULL(*YES) +
                        EXPR(*YES) +
                        PROMPT('Unterer Wert')
             ELEM       TYPE(*NAME) +
                        LEN(7) +
                        DFT(*ONLY) +
                        SPCVAL( +
                          (*ONLY *ONLY  ) +
                          (*LAST *LAST  )) +
                        FULL(*YES) +
                        EXPR(*YES) +
                        PROMPT('Oberer Wert')

QUAL1:       QUAL       TYPE(*NAME) LEN(10)                    +
                        DFT(QCPFMSG)
             QUAL       TYPE(*NAME)                            +
                        LEN(10)                                +
                        DFT(*LIBL)                             +
                        SPCVAL((*LIBL   )                      +
                               (*CURLIB ))                     +
                        PROMPT('Bibliothek')

QUAL2:       QUAL       TYPE(*NAME)                            +
                        LEN(10)                                +
                        DFT(*FROMMSGF)                         +
                        SPCVAL(*FROMMSGF)
             QUAL       TYPE(*NAME)                            +
                        LEN(10)                                +
                        DFT(*LIBL)                             +
                        SPCVAL((*LIBL   )                      +
                               (*CURLIB ))                     +
                        PROMPT('Bibliothek')

