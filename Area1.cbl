       >>SOURCE FORMAT FREE 
identification division.
program-id. Area1.
environment division.
input-output section.
file-control.
       select Book1 assign to "Book1.txt"
       organization is line sequential
       access is sequential.

data division.
file section.
fd Book1.

 01 Paragraph1 PIC X(99).
 01 Paragraph2 PIC X(99).
 01 Paragraph3 PIC X(99).
working-storage section.
01 choice pic x(99).
01 NumberChoice pic 9(2).
01 InCombat pic 9(1) value 1.
01 Indx pic 9(2) value 0.

01 Attack pic 9(3) value 0.

01 ListLength pic 9(2) value 0.

01 StringLength pic 9(2) value 0.

01  ModifiedString     PIC X(50).

01 PuzzleInputT pic 9(9).
01 PuzzleInputDir pic x(10).

01 Solved pic 9(1) value 0. 

 01 wsParagraphs.
           02 wsParagraph1 pic x(99).
           02 wsParagraph2 pic x(99). 


01 Player.
       02 CurrentRoom pic x(99) value "Room1".
       02 PreviousRoom pic x(99).

       02 Health pic s9(3) value 20.
       02 AttackPoints pic 9(3) value 10.
       02 DefensePoints pic 9(3) value 0.
       02 Weapon pic x(99) value "Fists".
       02 Armor pic x(99) value "Clothes".
         
01 Enemy.
       02 EnemyName pic x(99).
       02 EnemyHealth pic s9(3).
       02 EnemyAttackPoints pic 9(3).
       02 EnemyDefensePoints pic 9(3).
       02 EnemyWeapon pic x(99).
       02 EnemyArmor pic x(99).
       02 EnemyIsStunned pic 9(1) value 0.
       02 HasWeapon pic 9(1) value 0.     
       
01 PlayerInventory.
       02 Inventory occurs 15 times.
       03 InventoryItemIndex pic 9(2) .
       03 InventoryItem pic x(25) .   
       03 InventoryItemType pic x(25). 
       03 InventoryItemDef pic s9(3) value 0.
       03 InventoryItemAttack pic s9(3) value 0. 
       03 InventoryItemHealPoints pic s9(3) value 0.
      
01 EquipChoice pic 9(2).

01 UseItemChoice pic 9(2).


01 Room1.
       02 Intro1 pic x(99) value "You have entered the castle. You are in a dimly lit,".
       02 Intro2 pic x(99) value "expansive room with priceless antiques and artworks in a state of abandoned.".
       02 Intro3 pic x(99) value "In front of you is a large staircase leading to a hallway, and to your left is a door.".
       02 Intro4 pic x(99) value "Choose between Front or Left : ".


01 LeftRoom.
       02 LeftIntro1 pic x(99) value "Door is locked a key is needed.".
       02 LeftIntro2 pic x(99) value "You Slowly open the door and see a person with his back towards gazing at nothing".
       02 LeftIntro3 pic x(99) value "He hasn't notice you.".
       02 LeftIntro4 pic x(99) value "Choose between (1) sneaking around (2) attack: ".
       02 LeftRes1 pic x(99) value "You have Unlocked the door".
       02 LeftRes2 pic x(99) value "You do not have the key".
       02 LeftIntro5 pic x(99) value "At the end of the room you see some medicinal balms".
       02 LeftIntro6 pic x(99) value "Choose between Take the balms(Y/N): ".

       02 IsLocked pic 9(1) value 1.

01 Hallway.
       02 HIntro1 pic x(99) value "You have entered the hallway.".
       02 HIntro2 pic x(99) value "It is lined with portraits of royalty raging from centuries old to decades.".
       02 HIntro3 pic x(99) value "At each end of the hallway are doors. You can go to the door on the left or the door on the right.".
       02 HIntro4 pic x(99) value "One of the paintings appears to be slightly crooked.".
       02 HIntro5 pic x(99) value "Investigate the painting? (Y/N)".
       02 paintingSearch pic 9(1) value 0.

01 LeftHallRoom.
       02 LHIntro1 pic x(99) value "You have entered the room on the left.".
       02 LHIntro2 pic x(99) value "It appears to be a study, there are multiple tools trown about. On one corner there is an old chest".
       02 LHIntro3 pic x(99) value "On the other corner there is a collection of ancient books  on top of it.".
       02 LHIntro4 pic x(99) value "Choose between (a) Open the chest (b) Read the books: ".

01 RigthHallRoom.
       02 RHIntro1 pic x(99) value "You try opening the door.".
       02 RHIntro2 pic x(99) value "It has a bizarre handle that can be completely turn to the right or left".
       02 RHIntro3 pic x(99) value "Choose how many times your going to turn the handle and to what direction: ".
       02 RHIntro4 pic x(99) value "example. 3(times) R(right)".
       02 RHIntro5 pic x(99) value "Write x/X to exit puzzle".
       02 RHIntro6 pic x(99) value "You have entered the room on the right.".

       02 RHIntro7 pic x(99) value " There is a group of viciuos giant bats in the room.".

01 Body.
       02 Head pic x(99) value "Head".
       02 Torso pic x(99) value "Torso".
       02 Arms pic x(99) value "Arms".
       02 Legs pic x(99) value "Legs".

01 BodyPick pic 9(1).
01 YourTurn pic 9(1) value 1.
01 InitRandom pic s9v9(10).
01 RandomNumber pic s9v9(10).

01 ws-current-date-data.
       02 ws-current-date.
             
           03 ws-current-year pic 9(2).
           03 ws-current-month pic 9(2).
           03 ws-current-day pic 9(2).
       02 ws-current-time.
           03 ws-current-hours pic 9(2).
           03 ws-current-minute pic 9(2).
           03 ws-current-second pic 9(2).
           03 ws-current-millisecond pic 9(3).
       02 ws-diff-from-gmt pic s9(4).   

procedure division.

perform until choice="Quit" or "quit"    
       
       *>Room1
       if CurrentRoom="Room1" then        
       display Intro1
       display Intro2
       display Intro3
       display Intro4
       move "Room1" to CurrentRoom
       accept choice
           if choice="Front" or "front" then
           move "Hallway" to CurrentRoom
           move "Room1" to PreviousRoom
           end-if

           if choice="Left" or "left" then
           if IsLocked=1 then
               display LeftIntro1
               display "Search inventory for a key? (Y/N)"
                accept choice
                if choice="Y" or "y" then
           
           perform Inventorylength

           if ListLength =0 then
              display "You have no items"
           end-if

           if ListLength not =0 then
           perform CheckInventory
           accept UseItemChoice
           perform varying Indx from 1 by 1 until Indx>15
           
                if InventoryItemIndex(Indx) = UseItemChoice then
                    if InventoryItem(Indx) = "Hallway Key" then                      
                          move 0 to IsLocked
                        exit perform
                    end-if
                    if InventoryItem(Indx) not = "Hallway Key"  then
                    display "Wrong Item"
                       exit perform
                   end-if
                            
                end-if
              end-perform
           
           end-if
                    move 0 to Indx 
           end-if
           end-if

          if IsLocked=0 then
               move "LeftRoom" to CurrentRoom
               move "Room1" to PreviousRoom
           end-if
           end-if
       end-if

       *>LeftRoom
       if CurrentRoom="LeftRoom" then
           display LeftIntro2
           display LeftIntro3
           display LeftIntro4
          
                move "Minion" to EnemyName
                move 20 to EnemyHealth
                move 15 to EnemyAttackPoints
                move 0 to EnemyDefensePoints
                move "Wooden Cudgel" to EnemyWeapon
                move "Clothes" to EnemyArmor
                move 1 to HasWeapon
               
           accept NumberChoice
              if NumberChoice=1 then
                display "You have been spotted"

                 call "Combat" using Player,Enemy,ws-current-date-data,RandomNumber,InitRandom,Body,BodyPick,InCombat,YourTurn
              end-if
              if NumberChoice=2 then
                display "You have attacked the person you did some damage but he is still conscious"
                compute EnemyHealth = EnemyHealth - AttackPoints
                 call "Combat" using Player,Enemy,ws-current-date-data,RandomNumber,InitRandom,Body,BodyPick,InCombat,YourTurn
              end-if
           display LeftIntro5
           display LeftIntro6
           accept choice

           if choice="Y" or "y" then
              perform varying Indx from 1 by 1 until Indx>15
                      if InventoryItem(Indx) = spaces then
                          move Indx to InventoryItemIndex(Indx)
                          move  "Medicinal Balms" to InventoryItem(Indx)
                          move "Healing" to InventoryItemType(Indx)
                          move 0 to InventoryItemDef(Indx)
                          move 0 to InventoryItemAttack(Indx)
                          move 10 to InventoryItemHealPoints(Indx)
                          accept choice
                          exit perform     
                     end-if
                     end-perform
              end-if

           if choice="Back" or "back" then
               move "Room1" to CurrentRoom
               move "LeftRoom" to PreviousRoom
           end-if
       end-if

       
       *>Hallway
       if CurrentRoom="Hallway" then
           display HIntro1
           display HIntro2
           display HIntro3
           display HIntro4
           if paintingSearch=0 then
               display HIntro5
               accept choice
           end-if
           if choice="Y" or "y" then
           move 1 to paintingSearch
           display "You have found a key behind the painting."
            perform varying Indx from 1 by 1 until Indx>15
                    if InventoryItem(Indx) = spaces then
                       move Indx to InventoryItemIndex(Indx)
                       move  "Hallway Key" to InventoryItem(Indx)
                       move "Key" to InventoryItemType(Indx)                      
                       exit perform     
                   end-if
                   end-perform  
           
                                     
           end-if
           accept choice
           
           if choice="Left" or "left" then
               move "LeftHallRoom" to CurrentRoom
               move "Hallway" to PreviousRoom
           end-if

           if choice="Right" or "right" then
               move "RightHallRoom" to CurrentRoom
               move "Hallway" to PreviousRoom
           end-if

             if choice="back" or "Back" then
           move "Room1" to CurrentRoom
           move "Hallway" to PreviousRoom
       end-if
      
       end-if

       *>LeftHallWayRoom
         if CurrentRoom="LeftHallRoom" then
              display LHIntro1
              display LHIntro2
              display LHIntro3
              display LHIntro4
              accept choice

                if choice="a" or "A" then
                    display "You have found Heavy Clothes"              
                    perform varying Indx from 1 by 1 until Indx>15
                    if InventoryItem(Indx) = spaces then
                       move Indx to InventoryItemIndex(Indx)
                       move  "Heavy Clothes" to InventoryItem(Indx)
                       move "Armor" to InventoryItemType(Indx)
                       move 5 to InventoryItemDef(Indx)
                       accept choice
                       exit perform     
                   end-if
                   end-perform

                end-if	
                if choice = "b" or "B" then
                   perform FillFile 
                   display "You have found a book"
                   end-if
    if choice="back" or "Back" then
           move "Hallway" to CurrentRoom
           move "LeftHallRoom" to PreviousRoom
       end-if
         end-if


       *>RightHallWayRoom
       if CurrentRoom = "RightHallRoom"
       display RHIntro1
       display RHIntro2
       display RHIntro3
       display RHIntro4
       display RHIntro5

         if Solved=0 then
      perform until Solved=1

       display " Write how many times you are going to turn the handle: "
           accept PuzzleInputT
       display " Write the direction of the handle: "	
           accept PuzzleInputDir          

       if PuzzleInputT = 2 and PuzzleInputDir = "r" then
       display "You have unlocked the door"
       move 1 to Solved
     
       else
         display "You have failed to unlock the door"
         exit perform
         
      end-perform
       end-if

         if Solved=1 then
         display RHIntro6
         display RHIntro7

                move "Giant Bat" to EnemyName
                move 30 to EnemyHealth
                move 15 to EnemyAttackPoints
                move 0 to EnemyDefensePoints
                move "Claws" to EnemyWeapon
                move "Skin" to EnemyArmor
                move 0 to HasWeapon

         call "Combat" using Player,Enemy,ws-current-date-data,RandomNumber,InitRandom,Body,BodyPick,InCombat,YourTurn
         end-if
       accept choice

       end-if

       *>Inventory
       if choice = "I" OR  "i" then
       
          perform CheckInventory
           
           move 0 to Indx
           accept choice
       end-if

       *>Equip Item
       if choice="Equip" or "equip" then
           perform Equip
       end-if

       *>See your Stats
       if choice="Stats" or "stats" then
           perform Stats
       end-if

end-perform

perform ClearFile

stop run.


*>Paragraphs Section
CheckInventory section.

 display "Inventory:"
           perform varying Indx from 1 by 1 until Indx>15
               if InventoryItem(Indx) not = spaces then
                   display InventoryItemIndex(Indx)") " InventoryItem(Indx) "Type: " InventoryItemType(Indx) 
                   " Def: " InventoryItemDef(Indx) " Atk: " InventoryItemAttack(Indx)    

               end-if
           end-perform

           exit section.

Equip section.

              perform CheckInventory
              display "Choose an item to equip"
              accept EquipChoice
              perform varying Indx from 1 by 1 until Indx>15
                if InventoryItemIndex(Indx) = EquipChoice then
                    if InventoryItemType(Indx) = "Weapon" then
                        move InventoryItem(Indx) to Weapon
                        move InventoryItemAttack(Indx) to AttackPoints
                        display "You have equipped " InventoryItem(Indx)
                        exit perform
                    end-if
                    if InventoryItemType(Indx) = "Armor" then
                        move InventoryItem(Indx) to Armor
                        move InventoryItemDef(Indx) to DefensePoints
                        display "You have equipped " InventoryItem(Indx)
                        exit perform
                    end-if
                    if InventoryItemType(Indx) = "Healing" then  

                        add 10 to Health
                        display "You have healed yourself"
                        exit perform
                    end-if
                    if InventoryItemType(Indx) not = "Weapon" or "Armor" then
                        display "You cannot equip this item"
                        exit perform
                    end-if
                   exit perform
                end-if
              end-perform
              move 0 to Indx
              exit section.

Inventorylength section.

           perform varying Indx from 1 by 1 until Indx>15
               if InventoryItem(Indx) not = spaces then
                   add 1 to ListLength
               end-if
           end-perform
           move 0 to Indx
           exit section.



Stats section.
 display "Health: " Health
 display "Attack: " AttackPoints
 display "Defense: " DefensePoints
 display "Weapon: " Weapon
 display "Armor: " Armor
 exit section.


FillFile section.

       open extend Book1.
         move "Date: 1 of august 1895" to Paragraph1
           write Paragraph1
         move "He does not let me go. I have been tring to find means of escape for lord knows how many days."  to Paragraph2          
           write Paragraph2
         move "I have found a door that unlocks after turning the handle 2 times to the right" to Paragraph3
           write Paragraph3
        end-write.
            	
close Book1.

ClearFile section.

         open output Book1.
            move spaces to Paragraph1
              write Paragraph1
            move spaces to Paragraph2          
              write Paragraph2
                
          end-write.

close Book1.



