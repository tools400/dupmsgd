     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Only *FROMID allowed if a range is specified.               */
     /* ----------------------------------------------------------- */

             PGM        PARM(&LI)

             DCL        VAR(&LI) TYPE(*CHAR) LEN(10)

             RMVMSGD MSGID(USR0001) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Only *FROMID allowed if a range is specified.'                       +
                ) +
                SEV(00) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
     /* *FROMID/*FROMMSGF can not be specified at the same time.    */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0002) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'*FROMID/*FROMMSGF can not be specified at the same time.'            +
                ) +
                SEV(00) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
     /* Message description &3 in file &2/&1 already exists.        */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0003) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Message description &3 in file &2/&1 already exists.'                +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  10) +
                    (*CHAR  10) +
                    (*CHAR   7) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Message description &3 in file &2/&1 created.               */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0004) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Message description &3 in file &2/&1 created.'                       +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  10) +
                    (*CHAR  10) +
                    (*CHAR   7) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
     /* Data type not supported: &1                                 */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0005) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0005) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Data type not supported: &1'                                         +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  10) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0006                    */
     /* Unexpected error in QMHRTVM API. Check job log.             */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0006) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0006) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Unexpected error in QMHRTVM API. Check job log.'                     +
                ) +
                SEV(00) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0007                    */
     /* QMHRTVM API ended with error: &1                            */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0007) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0007) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'QMHRTVM API ended with error: &1'                                    +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  200) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0008                    */
     /* Buffer overflow for field: &1                               */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0008) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0008) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Buffer overflow for field: &1'                                       +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  32) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

             ENDPGM
