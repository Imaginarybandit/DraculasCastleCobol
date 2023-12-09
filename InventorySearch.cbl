       >>SOURCE FORMAT FREE
identification division.
program-id. InventorySearch.
environment division.
configuration section.
special-names.

data division.
    linkage section.
      01 PlayerInventory.
       02 Inventory occurs 15 times.
           03 InventoryItem pic x(99) value spaces. 

       01 res1 pic x(99).
       01 res2 pic x(99).   
       
       01 Indx pic 99.
       01 IsLocked pic 99.

       01 Item pic x(99) value spaces.

         01 WS-Count pic 99.
procedure division using PlayerInventory,res1,res2,IsLocked,Indx,Item,WS-Count.

    display "Inventory:"
    perform varying Indx from 1 by 1 until Indx> 15
     inspect Item tallying WS-Count for all InventoryItem(Indx) characters
       if WS-Count > 0 then
             if InventoryItem(Indx)="Hallway Key" then
                            move 0 to IsLocked
                            display res1
                            exit perform
                        else
                            display res2
                            exit perform
                        end-if
        end-if               
        end-perform
   
   

    exit program.
