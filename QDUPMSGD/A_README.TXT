DUPMSGD - A Tools/400 Utility
-----------------------------

DUPMSGD is a utility for duplicating message descriptions within a
message file or between two message files.

WARNING: Not all attributes of a message description are copied. Refer
to the help text of the DUPMSGD command to find the list of attributes
that are copied.

Dependencies: *NONE

Compile members with the following PDM option:

   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
     USER1(*LIST) USER2(*FULL)

Members of type MAKPGM or BND are used for linking programs (MAKPGM)
and service programs (BND).

2019, Thomas Raddatz
