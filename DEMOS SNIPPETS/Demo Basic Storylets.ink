VAR cash = 1000
-> Rent_Due

== Rent_Due
Your landlord asks for the rent.
{cash < 1000: ->storylet_sorter->}
+ Pay the money.
  ~ cash -= 1000
  -> Story_Continues

== storylet_sorter
You don't have enough money.
{ shuffle once:
-     
    -> Storylet1->
-     
    -> Storylet2->
}
{cash < 1000: ->Eviction}
->->

== Story_Continues
You go about your day.
-> Rent_Due

== Storylet1
Hey buddy, wanna do crime?
+ Do crime
    ~ cash += 1000
+ Do not crime
-
->->

== Storylet2
Hey buddy, wanna sell a kidney.
+ Sell a kidney
    ~ cash += 1000
+ Do not sell a kidney
-
->->

== Eviction
You get evicted.
-> END