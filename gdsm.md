## D ^%G

adopted long time ago and improved to support many tricks on the global structure inquiry 



nn>ERR(YMD,,"SP",      -- save ERR(YMD,,"SP", as shortcut number nn
nn<tab>                  -- retrive the global shortcut nn -> ERR(YMD,,"SP",

??                       -- help + list shortcuts
!     (first char)       -- recall last global from the list displayed
global(a,b,!             -- recall last index in global (the last global displayed)
                         ex:                           V
                         -- ^ERR(20130508,'17:25','SP',1) =
global(a,b,!3            -- recall 3'rd index in global from the end of the string (the last global displayed)
                         ex:               VVVVV
                         -- ^ERR(20130508,'17:25','SP',1) =
global(a,b,!!            -- recall last value of the last global displayed
                         ex:                                VVVVVV
                         -- ^ERR(20130508,'17:25','SP',1) = 100200
global(a,b,!!3           -- recall piece 3 of the last value displayed
                         ex:                                     vvvvvv
                         -- ^ERR(20130508,'17:25','SP',1) = 0_HO_123500_RQ_OK
global(a,b,!!_$E(%D,1,3) -- recall any mumps expresion of the last values %D data %G global name
                         ex:                                vvv
                         -- ^ERR(20130508,'17:25','SP',1) = 0_HO_123500_RQ_OK
EXAMPLE:
 33>W(JB,AP,SC,LN        -- store new shorcut
 33<tab>                 -- use shortcut

global(a,b,<tab>         -- return first $ORDER item
global(a,b,-1<tab>       -- return last $ORDER(,-1) item

global(a,b,::%D["XYZ"    -- full dsm style conditinal display, any mumps condition after  :: , %D-data ,%G full global, %S single index


List of shortcuts:
Global ^

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQ2NTUxMzQ4NSw3MzA5OTgxMTZdfQ==
-->