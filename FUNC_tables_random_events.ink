// RANDOM ENCOUNTER TABLE
// avery.h + keevy

//-> start
=== start ===
Do some stuff in one location.
+ [Go to next location.]
-
// use a tunnel to insert a random encounter
-> random_encounter -> 
You arrive at the next location.
-> DONE

=== random_encounter ===
~ temp x = RANDOM(1, 10)
{ x:
- x <= 5:
    ->->
- 6:
    -> bandits
- 7:
    -> avalanche
- 8:
    -> trader
- 9:
    -> bigstorm
- 10:
    -> dragon
}
->->

= avalanche
Oh no! You got caught in an avalanche.
+ [Ok.]
 ->->

= bandits
Oh no! You have been confronted by bandits!
+ [Fight them.]
  You lose, ouch.
+ [Give them your money.]
  You're poor now.
- ->->

= trader
Care to trade?
+ [Ok.]
 ->->
 
 = bigstorm
Oh no! You got caught in a storm.
+ [Ok.]
 ->->
 
= dragon
Oh no! you got eaten by a dragon.
+ [Ok.]
 ->->