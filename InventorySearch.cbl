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
           03 InventoryItemIndex pic 9(2) .
           03 InventoryItem pic x(25) .   
           03 InventoryItemType pic x(25). 
           03 InventoryItemDef pic s9(3) value 0.
           03 InventoryItemAttack pic s9(3) value 0.  
       
       01 Indx pic 99.
       01 IsLocked pic 99.

       01 Item pic x(99) value spaces.

       01 WS-Count PIC 9.

       01 UseItemChoice pic 9(2).

      01 StringLength pic 9(2) value 0.

      01  ModifiedString  PIC X(50).

procedure division using PlayerInventory,IsLocked,Indx,Item,WS-Count,UseItemChoice,StringLength,ModifiedString.
       
       
       perform varying Indx from 1 by 1 until Indx> 15
         if InventoryItemIndex(Indx) = UseItemChoice
        
           
  move function length(ModifiedString) to StringLength
       display Item
       inspect Item tallying WS-Count for all InventoryItem(Indx) characters
       display "WS-Count: " WS-Count
       if WS-Count >0 then
           move 0 to IsLocked
           display "You use the " InventoryItem(Indx)
           exit perform
       else                                           

       display "You don't have that item."
       exit perform

       end-if
       end-perform
       
       exit program.
