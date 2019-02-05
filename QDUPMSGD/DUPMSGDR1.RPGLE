      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : DUPMSGD                                            *
      *  Objekt  . . . : DUPMSGDR1                                          *
      *  Beschreibung  : Tool: DUPMSGD    (Duplicate MessageD )             *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : ?                                                  *
      *                                                                     *
      *=====================================================================*
      *                                                                     *
      *  This software is free software, you can redistribute it and/or     *
      *  modify it under the terms of the GNU General Public License (GPL)  *
      *  as published by the Free Software Foundation.                      *
      *                                                                     *
      *  See GNU General Public License for details.                        *
      *          http://www.opensource.org                                  *
      *          http://www.opensource.org/licenses/gpl-license.html        *
      *                                                                     *
      *=====================================================================*
      *  History:                                                           *
      *                                                                     *
      *  Datum       Name          Änderung                                 *
      *  ----------  ------------  ---------------------------------------  *
      *  16.12.2002  Th.Raddatz    Changed '§msgid' to 'sds_msgid' and      *
      *                                    '§msgdt' to 'sds_msgdt'.         *
      *                            Changed all occurences where '§' was     *
      *                            used: §l, §s, §errcd.                    *
      *                            Added parameters:                        *
      *                               LOGPRB()                              *
      *                               DFT()                                 *
      *                               TYPE()                                *
      *  05.02.2019  Th.Raddatz    Converted to /free.                      *
      *                                                                     *
      * =================================================================== *
      * >>PRE-COMPILER<<                                                    *
      *   >>CRTCMD<< CRTBNDRPG    PGM(&LI/&OB) +                            *
      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
      *   >>IMPORTANT<<                                                     *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DFTACTGRP(*NO);                                        *
      *     >>PARM<< ACTGRP(*NEW);                                          *
      *     >>PARM<< OPTION(*EVENTF);                                       *
      *   >>END-IMPORTANT<<                                                 *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      * =================================================================== *
      *                                                                     *
      *  Attention: If you have applied one of the PTFs listed              *
      *             below or if you are running V4R3 or above               *
      *             you should set constant OFS to 1.                       *
      *             Otherwise you should set OFS to 0.                      *
      *                                                                     *
      *             V3R1M0 - SF51811                                        *
      *             V3R2M0 - SF51812                                        *
      *             V3R6M0 - SF51813                                        *
      *             V3R7M0 - SF51814                                        *
      *             V4R1M0 - SF51815                                        *
      *             V4R2M0 - SF51817                                        *
      *                                                                     *
      * =================================================================== *
     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
      /copy qdupmsgd,copyright
      * =================================================================== *
      *
      /copy qdupmsgd,qmhrtvm
      /copy qdupmsgd,fderrcode
      *
     D rtvm0400        DS                  likeds(rtvm0400_t) inz
     D substVar        DS                  likeds(qmhrtvm_substVarFmt_t)
     D                                     based(pSubstVar)
     D errCode         DS                  likeds(errCode_t)
      *
     D qMsgF           DS                  QUALIFIED
     D  name                   1     10A   INZ
     D  lib                   11     20A   INZ
      *
     D fldDef          DS                  qualified
     D  length                       10I 0 inz
     D  decPos                       10I 0 inz
     D  hasDecPos                      N   inz
     D  orgType                      20A   inz varying
      *
     D dateISO         S               D   inz
     D dateJob         S             10A   inz
      *
     D tempText        DS          1024
     D text            DS          1024
      *
      *  Program information data structure
     D sds            SDS                  qualified
     D  msgId                 40     46
     D  msgDta                91    170
      *
     D i               S             10I 0
     D x               S              4P 0
     D numVars         S              2P 0
      *
     D DUPMSGDR2...
     D                 PR                  extpgm('DUPMSGDR1')
     D  i_frmLib                     10A   const
     D  i_frmMsgF                    10A   const
     D  i_frmMsgId                    7A   const
     D  i_toLib                      10A   const
     D  i_toMsgF                     10A   const
     D  i_toMsgId                     7A   const
     D  o_cmd                      2048A
     D  o_errId                       7A
     D  o_errData                    80A
      *
     D DUPMSGDR2...
     D                 PI
     D  i_frmLib                     10A   const
     D  i_frmMsgF                    10A   const
     D  i_frmMsgId                    7A   const
     D  i_toLib                      10A   const
     D  i_toMsgF                     10A   const
     D  i_toMsgId                     7A   const
     D  o_cmd                      2048A
     D  o_errId                       7A
     D  o_errData                    80A
      *
     C                   Eval      o_errId = *blanks
     C                   Eval      o_errData = *blanks
      *
     C                   Eval      qMsgF.name = i_frmMsgF
     C                   Eval      qMsgF.lib = i_frmLib
      *
     C                   Clear                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Callp(e)  QMHRTVM(rtvm0400
     C                                     : %size(rtvm0400)
     C                                     : 'RTVM0400'
     C                                     : i_frmMsgId
     C                                     : qMsgF
     C                                     : ''
     C                                     : 0
     C                                     : '*NO'
     C                                     : '*NO'
     C                                     : errCode)
      *
     C                   If        (%error())
     C                   Eval      o_errId = 'CPF9897'
     C                   Eval      o_errData = 'QMHRTVM returned an error'
     C                   Else
     C                   If        (errCode.bytAvl > *zero)
     C                   Eval      o_errId = errCode.excID
     C                   Eval      o_errData = errCode.excDta
     C                   Else
     C                   Exsr      prdCmd
     C                   Endif
     C                   Endif
      *
     C                   Return
      *
      ******************************************************
      * Produce ADDMSGD command
      ******************************************************
      *
     C     prdCmd        Begsr
      *
      * ADDMSGD
     C                   Eval      o_cmd = 'ADDMSGD'
      *
      * MSGID()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'MSGID'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) + i_toMsgId
     C                   Exsr      clsbrk
      *
      * MSGF()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'MSGF'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) +
     C                                    %trim(i_toLib) + '/' + %trim(i_toMsgF)
     C                   Exsr      clsbrk
      *
      * MSG()
     C                   If        (rtvm0400.LENMSGR > *zeros)
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'MSG'
     C                   Exsr      opnbrk
      *
     C                   Eval      text = %subst(rtvm0400         :
     C                                            rtvm0400.OFSMSG + 1:
     C                                            rtvm0400.LENMSGR      )
      *
     C                   Exsr      rplhpn
     C                   Eval      text = '''' + %trimr(text) + ''''
      *
     C                   Eval      o_cmd = %trimr(o_cmd) + text
     C                   Exsr      clsbrk
     C                   Endif
      *
      * SECLVL()
     C                   If        (rtvm0400.LENMSGHLPR > *zeros)
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'SEC'
     C                   Eval      o_cmd = %trimr(o_cmd) + 'LVL'
     C                   Exsr      opnbrk
      *
     C                   Eval      text = %subst(rtvm0400            :
     C                                            rtvm0400.OFSMSGHLP + 1:
     C                                            rtvm0400.LENMSGHLPR      )
     C                   Exsr      rplhpn
     C                   Eval      text = '''' + %trimr(text) + ''''
      *
     C                   Eval      o_cmd = %trimr(o_cmd) + text
     C                   Exsr      clsbrk
     C                   Endif
      *
      * SEV()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'SEV'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) +
     C                                    %char(rtvm0400.MSGSEV)
     C                   Exsr      clsbrk
      *
      * Compute number of replacement variables
     C                   If        (rtvm0400.lenVarFmtR > *zero)
     C                   Eval      numVars = rtvm0400.lenVarFmtR /
     C                                       rtvm0400.lenVarFmtE
     C                   Else
     C                   Eval      numVars = *zeros
     C                   Endif
      *
      * FMT()
     C                   If        (numVars > *zeros)
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'FMT'
     C                   Exsr      opnbrk
     C                   Endif
      *
     C     1             Do        numVars       x
      *
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + '('
      *
      * Get next replacement variable
     C                   If        (x = 1)
     C                   Eval      pSubstVar = %addr(rtvm0400) +
     C                                         rtvm0400.ofsVarFmt
     C                   Else
     C                   Eval      pSubstVar = pSubstVar +
     C                                         rtvm0400.lenVarFmtE
     C                   Endif
      *
      * prüfen, ob Datentyp korrekt, sonst Fehler
     C                   Exsr      chktyp
     C                   If        (o_errId <> '')
     C                   Leavesr
     C                   endif
      *
      * Get field definition
     C                   Exsr      getFldDef
     C                   Eval      o_cmd = %trimr(o_cmd) + fldDef.orgType
      * ... Field length
     C                   Eval      o_cmd =
     C                             %trimr(o_cmd) + ' ' + %char(fldDef.length)
      * ... Fraction
     C                   If        (fldDef.hasDecPos)
     C                   Eval      o_cmd =
     C                             %trimr(o_cmd) + ' ' + %char(fldDef.decPos)
     C                   Endif
      *
     C                   Exsr      clsbrk
     C                   Enddo
      *
     C                   If        (numVars > *zeros)
     C                   Exsr      clsbrk
     C                   Endif
      *
      * ALROPT()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'ALROPT'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) + rtvm0400.ALTOPT
     C                   If        (rtvm0400.ALTIDX >= 1 )  and
     C                             (rtvm0400.ALTIDX <= 99)
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' +
     C                                    %char(rtvm0400.ALTIDX)
     C                   Endif
     C                   Exsr      clsbrk
      *
      * LOGPRB()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'LOGPRB'
     C                   Exsr      opnbrk
     C                   If        rtvm0400.LOGIND = 'Y'
     C                   Eval      o_cmd = %trimr(o_cmd) + '*YES'
     C                   Else
     C                   Eval      o_cmd = %trimr(o_cmd) + '*NO'
     C                   Endif
     C                   Exsr      clsbrk
      *
      * CCSID()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'CCSID'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) +
     C                                    %char(rtvm0400.ccsidTxt)
     C                   Exsr      clsbrk
      *
      * DFT()
     C                   If        rtvm0400.LENDFTRPYR > 0
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'DFT'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) +
     C                                    %subst(rtvm0400.DATA       :
     C                                           rtvm0400.OFSDFTR    :
     C                                           rtvm0400.LENDFTRPYA )
     C                   Exsr      clsbrk
     C                   Endif
      *
      * TYPE()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'TYPE'
     C                   Exsr      opnbrk
     C                   Eval      o_cmd = %trimr(o_cmd) + rtvm0400.rpyType
     C                   Exsr      clsbrk
      * LEN()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'LEN'
     C                   Exsr      opnbrk
     C                   If        rtvm0400.RPYTYPE = '*NONE'
     C                   Eval      o_cmd = %trimr(o_cmd) + '*NONE'
     C                   Else
     C                   If        rtvm0400.MAXRPYLEN > 0
     C                   Eval      o_cmd = %trimr(o_cmd) +
     C                                    %editc(rtvm0400.maxRpyLen: 'X')
     C                   If        rtvm0400.RPYTYPE = '*DEC'
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' +
     C                                    %editc(rtvm0400.maxRpyDecPos: 'X')
     C                   Endif
     C                   Else
     C                   Eval      o_cmd = %trimr(o_cmd) + '*TYPE'
     C                   Endif
     C                   Endif
     C                   Exsr      clsbrk
      * VALUES()
      *
      * SPCVAL()
      *
      * RANGE()
      *
      * REL()
      *
      * LVL()
     C                   Eval      o_cmd = %trimr(o_cmd) + ' ' + 'LVL'
     C                   Exsr      opnbrk
     C                   Eval      dateISO = %date(rtvm0400.modDate: *cymd0)
     C                   Eval      dateJob = %char(dateISO: *jobrun)
     C                   Eval      o_cmd = %trimr(o_cmd)
     C                               + ''''
     C                               + %trim(dateJob)
     C                               + ''''
     C                               + ' '
     C                               + %char(rtvm0400.crtLvlNbr)
     C                   Exsr      clsbrk
      *
     C                   Endsr
      *
      ******************************************************
      * Double hyphens
      ******************************************************
      *
     C     rplhpn        Begsr
      *
     C                   Eval      i = 1
      *
     C                   Dou       (i = 0)
      *
     C                   Eval      i = %scan('''': text: i)
     C                   If        (i <= *zeros)
      *  Nichts weiter zu tun ...
     C                   Else
      *  Zweite "Hälfte" retten ...
     C                   Eval      i = i + 1
     C                   If        (i <= 1024)
     C                   Eval      tempText = %subst(text: i)
     C                   Else
      *  "ASSERT"
     C                   Eval      sds.msgId = 'CPF9897'
     C                   Eval      sds.msgDta = 'i > 1024'
     C                   Exsr      *pssr
     C                   Endif
      *
     C                   Eval      %subst(text: i: 1) = ''''
     C                   If        (i <= 1024)
     C                   Eval      text = %subst(text: 1: i) + tempText
     C                   Else
      *  "ASSERT"
     C                   Eval      sds.msgId = 'CPF9897'
     C                   Eval      sds.msgDta = 'i > 1024'
     C                   Exsr      *pssr
     C                   Endif
      *
     C                   Eval      i = i + 1
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endsr
      *
      ******************************************************
      * Add opening bracket
      ******************************************************
      *
     C     opnbrk        Begsr
      *
     C                   Eval      o_cmd = %trimr(o_cmd) + '('
      *
     C                   Endsr
      *
      ******************************************************
      * Add closing bracket
      ******************************************************
      *
     C     clsbrk        Begsr
      *
     C                   Eval      o_cmd = %trimr(o_cmd) + ')'
      *
     C                   Endsr
      *
      ******************************************************
      * Check data type of replacement variable
      ******************************************************
      *
     C     chktyp        Begsr
      *
     C                   If        (substVar.type <> '*QTDCHAR'  and
     C                              substVar.type <> '*CHAR'  and
     C                              substVar.type <> '*DEC'  and
     C                              substVar.type <> '*HEX')
     C                   Eval      o_errId = 'CPF9897'
     C                   Eval      o_errData = 'MSG-ID: ' + rtvm0400.MSGID +
     C                                      'Unerlaubter Typ: ' +
     C                                      substVar.type
     C                   Endif
      *
     C                   Endsr
      *
      ******************************************************
      * Get field definition of replacement variable
      ******************************************************
      *
     C     getFldDef     Begsr
      *
     C                   Select
     C                   When      (substVar.type = '*QTDCHAR')
     C                   Eval      fldDef.length = substVar.length
     C                   Eval      fldDef.decPos = -1
     C                   Eval      fldDef.hasDecPos = *off
     C                   Eval      fldDef.orgType = substVar.type
      *
     C                   When      (substVar.type = '*CHAR')
     C                   Eval      fldDef.length = substVar.length
     C                   Eval      fldDef.decPos = -1
     C                   Eval      fldDef.hasDecPos = *off
     C                   Eval      fldDef.orgType = substVar.type
      *
     C                   When      (substVar.type = '*HEX')
     C                   Eval      fldDef.length = substVar.length
     C                   Eval      fldDef.decPos = -1
     C                   Eval      fldDef.hasDecPos = *off
     C                   Eval      fldDef.orgType = substVar.type
      *
     C                   When      (substVar.type = '*DEC')
     C                   Eval      fldDef.length = substVar.length
     C                   Eval      fldDef.decPos = substVar.decPos
     C                   Eval      fldDef.hasDecPos = *on
     C                   Eval      fldDef.orgType = substVar.type
      *
     C                   Endsl
      *
     C                   Endsr
      *
      ******************************************************
      * Error handler
      ******************************************************
      *
     C     *pssr         Begsr
      *
     C                   Dump
      *
     C                   Endsr     '*CANCL'
      *
