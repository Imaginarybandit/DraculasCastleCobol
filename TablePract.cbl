       >>SOURCE FORMAT FREE
identification division.
program-id. InventorySearch.
environment division.
configuration section.
special-names.

data division.
working-storage section.

*> Create a table
01 InventoryTable.
      
       02 ItemName occurs 10 times pic x(20) value spaces.
      
01 Choice pic x(99).

01 Indx pic 9(2) value 1.
procedure division.

*> Populate the table

move "Hammer" to ItemName(1)



move "Saw" to ItemName(2)


perform until Choice="Quit" or "quit" 


call 'TableProc' using InventoryTable,Indx,"KEY"
accept Choice
display Choice


end-perform.

stop run.