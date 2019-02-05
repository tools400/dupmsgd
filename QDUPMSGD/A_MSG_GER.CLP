     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Bei Angabe eines Bereichs ist nur *FROMID zulässig.         */
     /* ----------------------------------------------------------- */

             PGM        PARM(&LI)

             DCL        VAR(&LI) TYPE(*CHAR) LEN(10)

             RMVMSGD MSGID(USR0001) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Bei Angabe eines Bereichs ist nur *FROMID zulässig.'                 +
                ) +
                SEV(00) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
     /* Kombination *FROMID/*FROMMSGF nicht zulässig.               */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0002) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Kombination *FROMID/*FROMMSGF nicht zulässig.'                       +
                ) +
                SEV(00) +
     /*   Keine Ersatzvariablen definiert!                          */ +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
     /* Nachrichtenbeschreibung &3 in Datei &2/&1 ist bereits vorha */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0003) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Nachrichtenbeschreibung &3 in Datei &2/&1 ist bereits vorhanden.'    +
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
     /* Nachrichtenbeschreibung &3 in Datei &2/&1 erstellt.         */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0004) MSGF(&LI/DUPMSGD )
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LI/DUPMSGD ) +
                MSG(+
'Nachrichtenbeschreibung &3 in Datei &2/&1 erstellt.'                 +
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

             ENDPGM
