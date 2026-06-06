**free
// =================================================================== *
//                                                                     *
//  Kurzdokumentation :                                                *
//                                                                     *
//  Bereich . . . : DUPMSGD                                            *
//  Objekt  . . . : DUPMSGDR2                                          *
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
//  Datum       Name          Ändereung                                 *
//  ----------  ------------  ---------------------------------------  *
//  16.01.2002  Th.Raddatz    Changed output parameter name 'xmsg'     *
//                            to 'xmsgId'.                             *
//                            Removed *INZSR.                          *
//  10.01.2003  Th.Raddatz    Removed special character § from source. *
//  05.02.2019  Th.Raddatz    Converted to /free.                      *
//                                                                     *
// =================================================================== *
// >>PRE-COMPILER<<                                                    *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
//                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
//   >>IMPORTANT<<                                                     *
//     >>PARM<< DBGVIEW(*LIST);                                        *
//     >>PARM<< TRUNCNBR(*NO);                                         *
//     >>PARM<< OPTION(*EVENTF);                                       *
//   >>END-IMPORTANT<<                                                 *
//   >>EXECUTE<<                                                       *
// >>END-PRE-COMPILER<<                                                *
// =================================================================== *
ctl-opt debug decedit('0,') datedit(*dmy.);
/copy qdupmsgd,copyright
// =================================================================== *

/copy qdupmsgd,qmhrtvm
/copy qdupmsgd,fderrcode

dcl-ds rtvm0400 likeds(rtvm0400_t) inz;

dcl-ds qMsgF qualified;
  name char(10) inz;
  lib  char(10) inz;
end-ds;

dcl-ds errCode likeds(errCode_t) inz;

dcl-pr DUPMSGDR2 extpgm('DUPMSGDR2');
  i_lib      char(10) const;
  i_msgF     char(10) const;
  i_msgId    char(7) const;
  i_rtvOpt   char(7) const;
  o_rtnMsgId char(7);
  o_errId    char(7);
  o_errData  char(80);
end-pr;
dcl-pi DUPMSGDR2;
  i_lib      char(10) const;
  i_msgF     char(10) const;
  i_msgId    char(7) const;
  i_rtvOpt   char(7) const;
  o_rtnMsgId char(7);
  o_errId    char(7);
  o_errData  char(80);
end-pi;

o_rtnMsgId = '';
o_errId = '';
o_errData = '';

qMsgF.name = i_msgF;
qMsgF.lib = i_lib;

clear errCode;
errCode.bytPrv = %size(errCode);

Callp(e) QMHRTVM(rtvm0400: %size(rtvm0400): 'RTVM0400': i_msgId
                 : qMsgF: '': 0: '*NO': '*NO': errCode
                 : i_rtvOpt: 0: 0);

if (%error());
  o_errId = 'USR0006'; // Unexpected error in QMHRTVM API. Check job log.
  o_errData = '*N';
else;
  if (errCode.bytAvl > *zero);
    qMsgF.name = 'QCPFMSG';
    qMsgF.lib = '*LIBL';
    QMHRTVM(rtvm0400: %size(rtvm0400): 'RTVM0400'
            : errCode.excID: qMsgF
            : errCode.excDta: %len(%trimr(errCode.excDta))
            : '*YES': '*NO': errCode);
    o_errId = 'USR0007'; // QMHRTVM API ended with error: &1
    o_errData = %subst(rtvm0400: rtvm0400.ofsMsg+1: rtvm0400.lenMsgR);
  else;
    o_rtnMsgId = rtvm0400.msgId;
  endif;
endif;

return;

