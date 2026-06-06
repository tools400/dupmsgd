/* -------------------------------------------------------------------------- */
/* DUPMSGD    - SCRIPT MEMBER                                                 */
/* Use commands  xmlgenINC (generate text for install pgm)                    */
/*               xmlgenMBR (to define source members                          */
/*               xmlgenCMD (execute qcmdexc at run time                       */
/* Put &TOLIB where you want user selected lib at run time.                   */
   DCL &TOLIB *CHAR 10
/* -------------------------------------------------------------------------- */
/* >>PRE-COMPILER<<                                                           */
/*   >>CRTCMD<<  XMLGEN  XMLSCRIPT(&SM) SCRIPTSRCF(&SL/&SF);                  */
/*   >>IMPORTANT<<                                                            */
/*     >>PARM<<  SRCTOFILE(&LI/QXML);                                         */
/*     >>PARM<<  XMLMBR(*SCRIPT);                                             */
/*     >>PARM<<  ENCODING('ISO-8859-1');                                      */
/*     >>PARM<<  AUTHOR('Thomas Raddatz');                                    */
/*   >>END-IMPORTANT<<                                                        */
/*   >>EXECUTE<<                                                              */
/* >>END-PRE-COMPILER<<                                                       */
/* -------------------------------------------------------------------------- */
             XMLGENINC  XINCLUDE(*YES)

             XMLGENVRS XSRCFILE(QDUPMSGD) XSRCLIB(DUPMSGDD) XSRCMBR(COPYRIGHT)

             XMLGENCND  XMSG('Select language (GER, ENG)') +
                          XVALUES(GER ENG) XVAR(&LANG)

             XMLGENSET  XVAR(&SRCFILE) XVALUE(QDUPMSGD)

/* ---------------------------------- */
/*  Deploy source member              */
/* ---------------------------------- */
             XMLGENMBR  XMBR(A_INSTALL ) XMBRATR(CLLE ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PGM   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_MSG_ENG ) XMBRATR(CLP   ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*FILE  ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_MSG_GER ) XMBRATR(CLP   ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*FILE  ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_README  ) XMBRATR(TXT) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PGM   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(COPYRIGHT ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGD   ) XMBRATR(MAKPGM) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDC  ) XMBRATR(CLLE  ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PGM   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDE  ) XMBRATR(CMD   ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*CMD   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDG  ) XMBRATR(CMD   ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*CMD   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDPE ) XMBRATR(PNLGRP) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PNLGRP) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDPG ) XMBRATR(PNLGRP) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDR1 ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PGM   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DUPMSGDR2 ) XMBRATR(RPGLE ) +
                          XFROMSRCF(QDUPMSGD  ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD  ) XOBJTYPE(*PGM   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDERRCODE ) XMBRATR(RPGLE) +
                          XFROMSRCF(QDUPMSGD ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(QMHRTVM   ) XMBRATR(RPGLE) +
                          XFROMSRCF(QDUPMSGD ) XFROMSRCL(DUPMSGDD) +
                          XTOSRCF(QDUPMSGD ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

/* ---------------------------------- */
/*  Create objects                    */
/* ---------------------------------- */
             XMLGENCMD  XCMD(CRTBNDCL PGM(&TOLIB/A_INSTALL) +
                          SRCFILE(&TOLIB/QDUPMSGD) SRCMBR(*PGM) +
                          DFTACTGRP(*NO) ACTGRP(*NEW) +
                          DBGVIEW(*LIST)) XDLTSPLF(A_INSTALL)

             XMLGENCMD  XCMD(CALL PGM(&TOLIB/A_INSTALL) +
                             PARM('&TGTRLS' '&SRCFILE' '&TOLIB' '&LANG'))
             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/A_INSTALL))

