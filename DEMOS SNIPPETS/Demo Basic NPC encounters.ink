LIST weapon_states = Unarmed, (Melee), (Ranged)
LIST awareness_states = (Unaware), (Suspicious), (Aware), Hostile

VAR guard_1 = ()

VAR stealth = false
VAR armed = false
VAR stealth_skill = 5

-> Quest_Hub

== Quest_Hub
Before you leave, will you take your sword?
+ Yes.
    ~ armed = true
+ No.
-
Go to the:
+ Bridge
    -> Location("bridge")
+ Gate
    -> Location("gate")

== What_do_you_do

+ {stealth_skill} Sneak past the guard
    ~ stealth = true
+ Approach the guard
-
-> Guard

== Guard
{
- guard_1?Aware:->Challenge
- stealth:-> Stealth
- armed: -> Weapon_Drawn
- else:->Challenge
}
= Stealth
GUARD: It sure is quiet.  #game_event: patrol
->DONE

= Weapon_Drawn
GUARD: Attack! #game_event: attack
->DONE

= Challenge
GUARD: Who goes there?
-> Dialogue

== Dialogue
What do you answer?
+ Hi buddy!
+ Die pig!
    ~ guard_1 -= LIST_ALL(awareness_states)
    ~ guard_1 += Hostile
    You fight.
-
->DONE

== function generateGuard()
    ~ guard_1 = ()
    ~ draw(guard_1, weapon_states)
    ~ draw(guard_1, awareness_states)


== Location(x)
There's a guard at the {x}.
~ generateGuard()
{
-guard_1?Melee:
    <> He has a sword
-guard_1?Ranged:
    <> He has a crossbow
}
<>{guard_1?Suspicious: and looks suspicious.|.}
{guard_1?Aware:<> He knows you're there.}

->What_do_you_do

=== function draw(ref var, list)
    ~ var += LIST_RANDOM(list)

=== function filter(var, type)
    // from inky documentation
    ~ return var ^ LIST_ALL(type)

=== function pop(ref list)
    // from inky documentation
   ~ temp x = LIST_MIN(list) 
   ~ list -= x 
   ~ return x


=== function deal(ref var, ref list)
    ~ temp dealt_value = LIST_RANDOM(list)
    ~ list -= dealt_value
    ~ var += dealt_value

=== function discard(ref var, ref list)
    ~ var -= var ^ LIST_ALL(list)


=== function recycle(ref var, ref list)
    ~ temp recycle_value = var ^ LIST_ALL(list)
    ~ list += recycle_value
    ~ var -= recycle_value

=== function improve(ref list)
    {
    -list != LIST_MAX(LIST_ALL(list)):
        ~ list ++
        ~ return list
    - else:
        ~ return list
    }

=== function degrade(ref list)
    {
    -list != LIST_MIN(LIST_ALL(list)):
        ~ list --
        ~ return list
    - else:
        ~ return list
    }
