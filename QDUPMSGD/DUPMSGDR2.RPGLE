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
     H debug decedit('0,') datedit(*dmy.)
      /copy qdupmsgd,copyright
       // =================================================================== *

      /copy qdupmsgd,qmhrtvm
      /copy qdupmsgd,fderrcode

     D rtvm0300        DS                  likeds(rtvm0300_t) inz

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

       Callp(e) QMHRTVM(rtvm0300: %size(rtvm0300): 'RTVM0300': i_msgId
                        : qMsgF: '': 0: '*NO': '*NO': errCode
                        : i_rtvOpt: 0: 0);

       if (%error());
          o_errId = 'CPF9897';
          o_errData = 'QMHRTVM returned an error';
       else;
          if (errCode.bytAvl > 0);
             o_errId = errCode.excId;
             o_errData = errCode.excDta;
          else;
             o_rtnMsgId = rtvm0300.msgId;
          endif;
       endif;

       return;

      /end-free
