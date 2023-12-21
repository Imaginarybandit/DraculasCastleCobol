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

       01 Enemy.
           02 EnemyName pic x(99).
           02 EnemyHealth pic s9(3).
           02 EnemyAttackPoints pic 9(3).
           02 EnemyDefensePoints pic 9(3).
           02 EnemyWeapon pic x(99).
           02 EnemyArmor pic x(99).
           02 EnemyIsStunned pic 9(1) value 0. 
           02 HasWeapon pic 9(1). 
           02 StunResist pic 9(1).  
         
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

       01 InCombat pic 9(1).

       01 YourTurn pic 9(1) value 1.  
      
     
procedure division using Player,Enemy,ws-current-date-data,RandomNumber,InitRandom,Body,BodyPick,InCombat,YourTurn.


    
       move function current-date to ws-current-date-data
       compute InitRandom = function random (ws-current-millisecond)

        display "You have entered combat against " EnemyName
   
       perform until InCombat equals 0
       
      if YourTurn equals 1

       if Health <= 0
           display "You have died"
           move 0 to InCombat
           stop run
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
            compute EnemyHealth = EnemyHealth - (AttackPoints * 2)
            display "Enemy's Health is " EnemyHealth
            move 0 to YourTurn
           else
            display "You have missed"
            move 0 to YourTurn
           end-if
           end-if
       
         if BodyPick equals 2
                display "You have attacked the torso"
                compute EnemyHealth = EnemyHealth - AttackPoints 
                display "Enemy's Health is " EnemyHealth
                move 0 to YourTurn
         end-if
       
         if BodyPick equals 3

                display "You have attacked the arms"
                compute RandomNumber = function random ()
               if RandomNumber > 0.35 and HasWeapon equals 1
               display "Enemy has lost his weapon"
               move "Fists" to EnemyWeapon
               move 10 to  EnemyAttackPoints                
                compute EnemyHealth = EnemyHealth - (AttackPoints * 0.35) 
                display "Enemy's Health is " EnemyHealth
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
                compute EnemyHealth = EnemyHealth - (AttackPoints * 0.20)
                display "Enemy's Health is " EnemyHealth
                if StunResist equals 1
                  display "Enemy has resisted the stun"
                  move 0 to EnemyIsStunned
                  move 0 to StunResist
                else
                  display "Enemy has been stunned"
                  move 1 to EnemyIsStunned
                end-if               
                move 0 to YourTurn 
              else
                display "You have missed"
                move 0 to YourTurn
              end-if

         end-if
       
       if YourTurn equals 0
           if EnemyHealth <= 0
                display "You have won"
                move 0 to InCombat
                exit perform
            end-if
            if EnemyIsStunned equals 1
               move 0 to EnemyIsStunned
               move 1 to YourTurn
            else
               display "Enemy's Turn"
               compute Health = (Health + DefensePoints) - EnemyAttackPoints
               display "Enenmy has attacked you, He did " EnemyAttackPoints " damage"
               move 1 to YourTurn 
            end-if
         end-if

         end-if
       
       end-perform
         
       move 1 to YourTurn
       move 0 to InCombat
exit program.

