       >>SOURCE FORMAT FREE
identification division.
program-id. Combat.
author. Marcos Santiago.
date-written. Noviembre 15 2023
environment division.
configuration section.
special-names.
data division.
file section.
       linkage section.
       01 Player.
           02 CurrentRoom pic x(99) .
           02 PreviousRoom pic x(99).
           02 Health pic s9(3).
           02 AttackPoints pic 9(3).
           02 DefensePoints pic 9(3).
           02 Weapon pic x(99).
           02 Armor pic x(99).

       01 Minion.
           02 MinHealth pic s9(3).
           02 MinAttackPoints pic 9(3).
           02 MinDefensePoints pic 9(3).
           02 MinWeapon pic x(99).
           02 MinArmor pic x(99).
           02 MinIsStunned pic 9(1) value 0.
         
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


       01 Body.
           02 Head pic x(99) value "Head".
           02 Torso pic x(99) value "Torso".
           02 Arms pic x(99) value "Arms".
           02 Legs pic x(99) value "Legs".

       01 BodyPick pic 9(1).

       01 InCombat pic 9(1) value 1.

       01 YourTurn pic 9(1) value 1.          
     
procedure division using Player,Minion,ws-current-date-data,RandomNumber,InitRandom,Body,BodyPick,InCombat,YourTurn.


    
       move function current-date to ws-current-date-data
       compute InitRandom = function random (ws-current-millisecond)

        display "You have entered combat"
       perform until InCombat equals 0

       
      if YourTurn equals 1

       if Health <= 0
           display "You have died"
           move 0 to InCombat
           exit perform 
       end-if
       display "Your Health is " Health
          display "Pick a body part to attack"
            display "1. Head"
            display "2. Torso"
            display "3. Arms"
            display "4. Legs"

            accept BodyPick

            if BodyPick equals 1
               display "You have attacked the head"
              compute RandomNumber = function random ()
           if RandomNumber > 0.50
            display "Critical Hit!"
            compute MinHealth = MinHealth - (AttackPoints * 2)
            display "Enemy's Health is " MinHealth
            move 0 to YourTurn
           else
            display "You have missed"
            move 0 to YourTurn
           end-if
           end-if
       
         if BodyPick equals 2
                display "You have attacked the torso"
                compute MinHealth = MinHealth - AttackPoints 
                display "Enemy's Health is " MinHealth
                move 0 to YourTurn
         end-if
       
         if BodyPick equals 3

                display "You have attacked the arms"
                compute RandomNumber = function random ()
               if RandomNumber > 0.35
               display "Enemy has lost his weapon"
               move "Fists" to MinWeapon
               move 10 to  MinAttackPoints                
                compute MinHealth = MinHealth - (AttackPoints * 0.35) 
                display "Enemy's Health is " MinHealth
                move 0 to YourTurn
              else
                display "You have missed"
                move 0 to YourTurn
              end-if
         end-if
       
         if BodyPick equals 4
                display "You have attacked the legs"
                compute RandomNumber = function random ()
               if RandomNumber > 0.10
                  display "Enemy is Stunned"            
                compute MinHealth = MinHealth - (AttackPoints * 0.20)
                display "Enemy's Health is " MinHealth
                move 1 to MinIsStunned
                move 0 to YourTurn 
              else
                display "You have missed"
                move 0 to YourTurn
              end-if

         end-if
       
       if YourTurn equals 0
           if MinHealth <= 0
                display "You have won"
                move 0 to InCombat
                exit perform
            end-if
            if MinIsStunned equals 1
               display "Enemy is stunned"
               move 0 to MinIsStunned
               move 1 to YourTurn
            else
               display "Enemy's Turn"
               compute Health = Health - MinAttackPoints
               display "Enenmy has attacked you, He did " MinAttackPoints " damage"
               move 1 to YourTurn 
            end-if
         end-if

         end-if
       
       end-perform
      
exit program.

