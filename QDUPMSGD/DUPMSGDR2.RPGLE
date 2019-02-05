      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : DUPMSGD                                            *
      *  Objekt  . . . : DUPMSGDR2                                          *
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
      *  16.01.2002  Th.Raddatz    Changed output parameter name 'xmsg'     *
      *                            to 'xmsgId'.                             *
      *                            Removed *INZSR.                          *
      *  10.01.2003  Th.Raddatz    Removed special character § from source. *
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
     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
      /copy qdupmsgd,copyright
      * =================================================================== *
      *
      /copy qdupmsgd,qmhrtvm
      /copy qdupmsgd,fderrcode
      *
     D rtvm0300        DS                  LIKEDS(rtvm0300_t) inz
      *
     D qMsgF           DS                  QUALIFIED
     D  name                   1     10A   INZ
     D  lib                   11     20A   INZ
      *
     D errCode         DS                  likeds(errCode_t) inz
      *
     D DUPMSGDR2...
     D                 PR                  extpgm('DUPMSGDR2')
     D  i_lib                        10A   const
     D  i_msgF                       10A   const
     D  i_msgId                       7A   const
     D  i_rtvOpt                      7A   const
     D  o_rtnMsgId                    7A
     D  o_errId                       7A
     D  o_errData                    80A
      *
     D DUPMSGDR2...
     D                 PI
     D  i_lib                        10A   const
     D  i_msgF                       10A   const
     D  i_msgId                       7A   const
     D  i_rtvOpt                      7A   const
     D  o_rtnMsgId                    7A
     D  o_errId                       7A
     D  o_errData                    80A
      *
     C                   Eval      o_rtnMsgId = ''
     C                   Eval      o_errId = ''
     C                   Eval      o_errData = ''
      *
     C                   Eval      qMsgF.name = i_msgF
     C                   Eval      qMsgF.lib = i_lib
      *
     C                   Clear                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   Callp(e)  QMHRTVM(rtvm0300
     C                                     : %size(rtvm0300)
     C                                     : 'RTVM0300'
     C                                     : i_msgId
     C                                     : qMsgF
     C                                     : ''
     C                                     : 0
     C                                     : '*NO'
     C                                     : '*NO'
     C                                     : errCode
     C                                     : i_rtvOpt
     C                                     : 0
     C                                     : 0)
      *
     C                   If        (%error())
     C                   Eval      o_errId = 'CPF9897'
     C                   Eval      o_errData = 'QMHRTVM returned an error'
     C                   Else
     C                   If        (errCode.bytAvl > 0)
     C                   Eval      o_errId = errCode.excId
     C                   Eval      o_errData = errCode.excDta
     C                   Else
     C                   Eval      o_rtnMsgId = rtvm0300.msgId
     C                   Endif
     C                   Endif
      *
     C                   Return
      *
