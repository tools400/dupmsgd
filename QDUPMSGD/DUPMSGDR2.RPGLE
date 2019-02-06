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
       //  Datum       Name          Änderung                                 *
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
     H debug decedit('0,') datedit(*dmy.)
      /copy qdupmsgd,copyright
       // =================================================================== *

      /copy qdupmsgd,qmhrtvm
      /copy qdupmsgd,fderrcode

     D rtvm0400        DS                  likeds(rtvm0400_t) inz

     D qMsgF           DS                  qualified
     D name                          10a   inz
     D lib                           10a   inz

     D errCode         DS                  likeds(errCode_t) inz

     D DUPMSGDR2...
     D                 PR                  extpgm('DUPMSGDR2')
     D  i_lib                        10a   const
     D  i_msgF                       10a   const
     D  i_msgId                       7a   const
     D  i_rtvOpt                      7a   const
     D  o_rtnMsgId                    7a
     D  o_errId                       7a
     D  o_errData                    80a

     D DUPMSGDR2...
     D                 PI
     D  i_lib                        10a   const
     D  i_msgF                       10a   const
     D  i_msgId                       7a   const
     D  i_rtvOpt                      7a   const
     D  o_rtnMsgId                    7a
     D  o_errId                       7a
     D  o_errData                    80a
      /free

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

      /end-free
