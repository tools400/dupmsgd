       // =================================================================== *
       //                                                                     *
       //  Kurzdokumentation :                                                *
       //                                                                     *
       //  Bereich . . . : DUPMSGD                                            *
       //  Objekt  . . . : DUPMSGDR1                                          *
       //  Beschreibung  : Tool: DUPMSGD    (Duplicate MessageD )             *
       //  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
       //  Datum . . . . : ?                                                  *
       //                                                                     *
       //=====================================================================*
       //                                                                     *
       //  This software is free software, you can redistribute it and/or     *
       //  modify it under the terms of the GNU General Public License (GPL)  *
       //  as published by the Free Software Foundation.                      *
       //                                                                     *
       //  See GNU General Public License for details.                        *
       //          http://www.opensource.org                                  *
       //          http://www.opensource.org/licenses/gpl-license.html        *
       //                                                                     *
       //=====================================================================*
       //  History:                                                           *
       //                                                                     *
       //  Datum       Name          Änderung                                 *
       //  ----------  ------------  ---------------------------------------  *
       //  16.12.2002  Th.Raddatz    Changed '§msgid' to 'sds_msgid' and      *
       //                                    '§msgdt' to 'sds_msgdt'.         *
       //                            Changed all occurences where '§' was     *
       //                            used: §l, §s, §errcd.                    *
       //                            Added parameters:                        *
       //                               LOGPRB()                              *
       //                               DFT()                                 *
       //                               TYPE()                                *
       //  05.02.2019  Th.Raddatz    Converted to /free.                      *
       //                                                                     *
       // =================================================================== *
       // >>PRE-COMPILER<<                                                    *
       //   >>CRTCMD<< CRTBNDRPG    PGM(&LI/&OB) +                            *
       //                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
       //   >>IMPORTANT<<                                                     *
       //     >>PARM<< DBGVIEW(*LIST);                                        *
       //     >>PARM<< TRUNCNBR(*NO);                                         *
       //     >>PARM<< DFTACTGRP(*NO);                                        *
       //     >>PARM<< ACTGRP(*NEW);                                          *
       //     >>PARM<< OPTION(*EVENTF);                                       *
       //   >>END-IMPORTANT<<                                                 *
       //   >>EXECUTE<<                                                       *
       // >>END-PRE-COMPILER<<                                                *
       // =================================================================== *
       //                                                                     *
       //  Attention: If you have applied one of the PTFs listed              *
       //             below or if you are running V4R3 or above               *
       //             you should set constant OFS to 1.                       *
       //             Otherwise you should set OFS to 0.                      *
       //                                                                     *
       //             V3R1M0 - SF51811                                        *
       //             V3R2M0 - SF51812                                        *
       //             V3R6M0 - SF51813                                        *
       //             V3R7M0 - SF51814                                        *
       //             V4R1M0 - SF51815                                        *
       //             V4R2M0 - SF51817                                        *
       //                                                                     *
       // =================================================================== *
     H debug decedit('0,') datedit(*dmy.)
      /copy qdupmsgd,copyright
       // =================================================================== *

      /copy qdupmsgd,qmhrtvm
      /copy qdupmsgd,fderrcode

     D rtvm0400        ds                  likeds(rtvm0400_t) inz
     D substVar        ds                  likeds(qmhrtvm_substVarFmt_t)
     D                                     based(pSubstVar)
     D errCode         ds                  likeds(errCode_t)

     D qMsgF           ds                  qualified
     D name                          10a   inz
     D lib                           10a   inz

     D fldDef          ds                  qualified
     D  length                       10i 0 inz
     D  decPos                       10i 0 inz
     D  hasDecPos                      n   inz
     D  orgType                      20a   inz varying

     D dateISO         s               d   inz
     D dateJob         s             10a   inz

     D tempText        ds          1024
     D text            ds          1024

       //  Program information data structure
     D sds            sds                  qualified
     D msgId                  40     46
     D msgDta                 91    170

     D i               s             10i 0
     D x               s             10i 0
     D numVars         s             10i 0

     D DUPMSGDR2...
     D                 pr                  extpgm('DUPMSGDR1')
     D  i_frmLib                     10a   const
     D  i_frmMsgF                    10a   const
     D  i_frmMsgId                    7a   const
     D  i_toLib                      10a   const
     D  i_toMsgF                     10a   const
     D  i_toMsgId                     7a   const
     D  o_cmd                      2048a
     D  o_errId                       7a
     D  o_errData                    80a

     D DUPMSGDR2...
     D                 pi
     D  i_frmLib                     10a   const
     D  i_frmMsgF                    10a   const
     D  i_frmMsgId                    7a   const
     D  i_toLib                      10a   const
     D  i_toMsgF                     10a   const
     D  i_toMsgId                     7a   const
     D  o_cmd                      2048a
     D  o_errId                       7a
     D  o_errData                    80a
      /free

       o_errId = *blanks;
       o_errData = *blanks;

       qMsgF.name = i_frmMsgF;
       qMsgF.lib = i_frmLib;

       clear errCode;
       errCode.bytPrv = %size(errCode);

       callp(e) QMHRTVM(rtvm0400: %size(rtvm0400): 'RTVM0400'
                        : i_frmMsgId: qMsgF: '': 0: '*NO': '*NO': errCode);

       if (%error());
          o_errId = 'CPF9897';
          o_errData = 'QMHRTVM returned an error';
       else;
          if (errCode.bytAvl > *zero);
             o_errId = errCode.excID;
             o_errData = errCode.excDta;
          else;
             exsr prdCmd;
          endif;
       endif;

       return;

       //*****************************************************
       // Produce ADDMSGD command
       //*****************************************************

       begsr prdCmd;

          // ADDMSGD
          o_cmd = 'ADDMSGD';

          // MSGID()
          o_cmd = %trimr(o_cmd) + ' ' + 'MSGID';
          exsr opnbrk;
          o_cmd = %trimr(o_cmd) + i_toMsgId;
          exsr clsbrk;

          // MSGF()
          o_cmd = %trimr(o_cmd) + ' ' + 'MSGF';
          exsr opnbrk;
          o_cmd = %trimr(o_cmd) + %trim(i_toLib) + '/' + %trim(i_toMsgF);
          exsr clsbrk;

          // MSG()
          if (rtvm0400.LENMSGR > *zeros);
             o_cmd = %trimr(o_cmd) + ' ' + 'MSG';
             exsr opnbrk;

             text = %subst(rtvm0400: rtvm0400.OFSMSG + 1: rtvm0400.lenMsgR);

             exsr rplhpn;
             text = '''' + %trimr(text) + '''';

             o_cmd = %trimr(o_cmd) + text;
             exsr clsbrk;
          endif;

          // SECLVL()
          if (rtvm0400.lenMsgHlpR > 0);
             o_cmd = %trimr(o_cmd) + ' ' + 'SECLVL';
             exsr opnbrk;

             text = %subst(rtvm0400: rtvm0400.ofsMsgHlp+1: rtvm0400.lenMsgHlpR);
             exsr rplhpn;
             text = '''' + %trimr(text) + '''';

             o_cmd = %trimr(o_cmd) + text;
             exsr clsbrk;
          endif;

          // SEV()
          o_cmd = %trimr(o_cmd) + ' ' + 'SEV';
          exsr opnbrk;
          o_cmd = %trimr(o_cmd) + %char(rtvm0400.msgSev);
          exsr clsbrk;

          // Compute number of replacement variables
          if (rtvm0400.lenVarFmtR > 0);
             numVars = rtvm0400.lenVarFmtR / rtvm0400.lenVarFmtE;
          else;
             numVars = *zeros;
          endif;

          // FMT()
          if (numVars > *zeros);
             o_cmd = %trimr(o_cmd) + ' ' + 'FMT';
             exsr opnbrk;
          endif;

          for x = 1 to numVars;

             o_cmd = %trimr(o_cmd) + ' ' + '(';

             // Get next replacement variable
             if (x = 1);
                pSubstVar = %addr(rtvm0400) + rtvm0400.ofsVarFmt;
             else;
                pSubstVar = pSubstVar + rtvm0400.lenVarFmtE;
             endif;

             // Check field type
             exsr chktyp;
             if (o_errId <> '');
                Leavesr;
             endif;

             // Get field definition
             exsr getFldDef;
             o_cmd = %trimr(o_cmd) + fldDef.orgType;

             // ... Field length
             o_cmd = %trimr(o_cmd) + ' ' + %char(fldDef.length);

             // ... Fraction
             if (fldDef.hasDecPos);
                o_cmd = %trimr(o_cmd) + ' ' + %char(fldDef.decPos);
             endif;

             exsr clsbrk;
          endfor;

          if (numVars > *zeros);
             exsr clsbrk;
          endif;

          // ALROPT()
          o_cmd = %trimr(o_cmd) + ' ' + 'ALROPT';
          exsr opnbrk;
          o_cmd = %trimr(o_cmd) + rtvm0400.ALTOPT;
          if (rtvm0400.ALTIDX >= 1 and rtvm0400.ALTIDX <= 99);
             o_cmd = %trimr(o_cmd) + ' ' + %char(rtvm0400.altIdx);
          endif;
          exsr clsbrk;

          // LOGPRB()
          o_cmd = %trimr(o_cmd) + ' ' + 'LOGPRB';
          exsr opnbrk;
          If rtvm0400.LOGIND = 'Y';
             o_cmd = %trimr(o_cmd) + '*YES';
          else;
             o_cmd = %trimr(o_cmd) + '*NO';
          endif;
          exsr clsbrk;

          // CCSID()
          o_cmd = %trimr(o_cmd) + ' ' + 'CCSID';
          exsr opnbrk;
          o_cmd = %trimr(o_cmd) + %char(rtvm0400.ccsidTxt);
          exsr clsbrk;

          // DFT()
          if (rtvm0400.lenDftRpyR > 0);
             o_cmd = %trimr(o_cmd) + ' ' + 'DFT';
             exsr opnbrk;
             o_cmd = %trimr(o_cmd) +
                     %subst(rtvm0400.data:rtvm0400.ofsDftR:rtvm0400.lenDftRpyA);
             exsr clsbrk;
          endif;

          // TYPE()
          o_cmd = %trimr(o_cmd) + ' ' + 'TYPE';
          exsr opnbrk;
          o_cmd = %trimr(o_cmd) + rtvm0400.rpyType;
          exsr clsbrk;

          // LEN()
          o_cmd = %trimr(o_cmd) + ' ' + 'LEN';
          exsr opnbrk;
          If rtvm0400.RPYTYPE = '*NONE';
             o_cmd = %trimr(o_cmd) + '*NONE';
          else;
             If rtvm0400.MAXRPYLEN > 0;
                o_cmd = %trimr(o_cmd) + %char(rtvm0400.maxRpyLen);
                If rtvm0400.RPYTYPE = '*DEC';
                   o_cmd = %trimr(o_cmd) + ' ' + %char(rtvm0400.maxRpyDecPos);
                endif;
             else;
                o_cmd = %trimr(o_cmd) + '*TYPE';
             endif;
          endif;
          exsr clsbrk;

          // VALUES()

          // SPCVAL()

          // RANGE()

          // REL()

          // LVL()
          o_cmd = %trimr(o_cmd) + ' ' + 'LVL';
          exsr opnbrk;
          dateISO = %date(rtvm0400.modDate: *cymd0);
          dateJob = %char(dateISO: *jobrun);
          o_cmd = %trimr(o_cmd) + ''''
                                + %trim(dateJob)
                                + ''''
                                + ' ' + %char(rtvm0400.crtLvlNbr);
          exsr clsbrk;

       endsr;

       //*****************************************************
       // Double hyphens
       //*****************************************************

       begsr rplhpn;

          i = 1;

          dou (i = 0);

             i = %scan('''': text: i);
             if (i > 0);

                i = i + 1;
                if (i <= 1024);
                   tempText = %subst(text: i);
                else;
                   //  "ASSERT"
                   sds.msgId = 'CPF9897';
                   sds.msgDta = 'i > 1024';
                   exsr *pssr;
                endif;

                %subst(text: i: 1) = '''';
                if (i <= 1024);
                   text = %subst(text: 1: i) + tempText;
                else;
                   //  "ASSERT"
                   sds.msgId = 'CPF9897';
                   sds.msgDta = 'i > 1024';
                   exsr *pssr;
                endif;

                i = i + 1;
             endif;

          enddo;

       endsr;

       //*****************************************************
       // Add opening bracket
       //*****************************************************

       begsr opnbrk;

          o_cmd = %trimr(o_cmd) + '(';

       Endsr;

       //*****************************************************
       // Add closing bracket
       //*****************************************************

       begsr clsbrk;

          o_cmd = %trimr(o_cmd) + ')';

       endsr;

       //*****************************************************
       // Check data type of replacement variable
       //*****************************************************

       begsr chktyp;

          if (substVar.type <> '*QTDCHAR'  and
             substVar.type <> '*CHAR'  and
             substVar.type <> '*DEC'  and
             substVar.type <> '*HEX');
             o_errId = 'CPF9897';
             o_errData = 'MSG-ID: ' + rtvm0400.MSGID + 'Unerlaubter Typ: ' +
                         substVar.type;
          endif;

       endsr;

       //*****************************************************
       // Get field definition of replacement variable
       //*****************************************************

       begsr getFldDef;

          select;
          when (substVar.type = '*QTDCHAR');
             fldDef.length = substVar.length;
             fldDef.decPos = -1;
             fldDef.hasDecPos = *off;
             fldDef.orgType = substVar.type;

          when (substVar.type = '*CHAR');
             fldDef.length = substVar.length;
             fldDef.decPos = -1;
             fldDef.hasDecPos = *off;
             fldDef.orgType = substVar.type;

          when (substVar.type = '*HEX');
             fldDef.length = substVar.length;
             fldDef.decPos = -1;
             fldDef.hasDecPos = *off;
             fldDef.orgType = substVar.type;

          when (substVar.type = '*DEC');
             fldDef.length = substVar.length;
             fldDef.decPos = substVar.decPos;
             fldDef.hasDecPos = *on;
             fldDef.orgType = substVar.type;

          endsl;

       endsr;

       //*****************************************************
       // Error handler
       //*****************************************************

       begsr *pssr;

          Dump;

       endsr '*CANCL';

      /end-free
