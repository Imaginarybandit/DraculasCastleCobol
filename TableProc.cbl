       >>SOURCE FORMAT FREE
identification division.
program-id. TableProc.
environment division.
configuration section.
data division.
    linkage section.

       01 InventoryTable.
           
           02 ItemName occurs 10 times pic x(20) value spaces.
          
      01 Indx pic 9(2) value 1.
      01 AName pic x(3).
procedure division using InventoryTable,Indx,AName.

          perform varying Indx from 1 by 1 until Indx>2
               if ItemName(Indx) not = spaces then
                   display ItemName(Indx)
               end-if
           end-perform
           display AName
   
    exit program.