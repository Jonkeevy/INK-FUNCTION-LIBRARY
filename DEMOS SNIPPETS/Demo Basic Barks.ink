VAR stealth = false
VAR armed = false
VAR stealth_skill = 5

-> Quest_Hub

== Quest_Hub
Before you leave, will you take your sword?
+ Yes
    ~ armed = true
+ No
-
-> Location

== Location
You see a guard.
+ {stealth_skill} Sneak past the guard
+ Approach the guard
-
-> NPC01_Barks

== NPC01_Barks
{
- stealth:-> Stealth
- armed: -> Armed
- else:->Challenge
}
= Stealth
It sure is quiet.  #game_event: patrol
->DONE

= Armed
Attack! #game_event: attack
->DONE

= Challenge
Who goes there?
-> Dialogue

== Dialogue
Hi buddy!
->DONE