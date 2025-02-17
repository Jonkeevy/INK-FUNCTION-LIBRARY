// <<<<<<<<<<<<< REPUTATION & REACTIONS >>>>>>>>>>>
// A cast of NPCs need ways to react to player actions and reputation. This system uses 3 core traits: Sincerity, Ruthlessness, and Charm. But you could use others like Manners, Intimidation, Insight. Whatever is right for your story game.
// You could also use this for Buffs / Debuffs to track immunity, resistance, etc. Consider a VAR sword = (trait.poison, immunity.poison, vulnerable.fire)


// CREATED by JON KEEVY.... free to use, no credit required. If you find it useful please send me a dollar freelancer@jonkeevy.com


LIST traitPERSONALITY = sincere, ruthless, charm
LIST traitPOS = sincere, ruthless, charm // Respond positively to / is buffed by
LIST traitNEG = sincere, ruthless, charm // Respond negatively to / is debuffed by
LIST npcRAPPORT = hate, contempt, dislike, neutral, like, admire, love
LIST progBASE_5 = prog1, prog2, prog3, prog4, prog5

VAR playerSINCERE = 1
VAR playerRUTHLESS = 1
VAR playerCHARM = 1

VAR npc01rep = (traitPOS.sincere, traitPOS.charm, traitNEG.ruthless, hate)
VAR npc02rep = (traitPOS.charm, traitNEG.sincere, neutral)


//INCLUDE FUNC_essentials.ink

//-> Start

== Start
{check_overlap(npc01rep,traitPOS.sincere)}

You could be sincere, ruthless, charming. Big events build your reputation, while direct interactions build your rapport.
Big event. Respond with:
    -> Action

== Action
+ Sincerity
    ~ playerSINCERE +=1
+ Ruthlessness
    ~ playerRUTHLESS +=1
+ Charm
    ~ playerCHARM +=1
+ Nothing
-
->Outcome

== Outcome
You are {checkREP()}.
-> NPCmeet

== NPCmeet
NPCname: I hear you're {checkREP()}.
I {reactPOS(npc01rep, checkREP()): like that|don't like that}.
-> ConversationAction

== ConversationAction
~ temp response = "none"
You're in a conversation with npc01rep. Say something:
    + Sincere
        ~ response = "sincere"
    + Ruthless
        ~ response = "ruthless"
    + Charming
        ~ response = "charming"
    + Nothing
-
->NPCreact(npc01rep, response)

== NPCreact(npc, x)
{
- reactPOS(npc,x):
    I REALLY like that.
    ~ improve_trait(npc, npcRAPPORT)
- reactNEG(npc,x):
    I REALLY don't like that.
    ~ degrade_trait(npc, npcRAPPORT)
-else:
    I don't care.
}
//{checkXhasY(npc01rep,traitPOS.sincere,traitPOS)}

-> Action

== YesThisWorks
Yes this works.
->DONE

== function checkREP()
    {
    - playerSINCERE > playerRUTHLESS + playerCHARM:
        ~ return "sincere" 
    - playerRUTHLESS > playerSINCERE + playerCHARM:
        ~ return "ruthless"
    - playerCHARM > playerSINCERE + playerRUTHLESS:
        ~ return "charming"
    - else:
        ~ return "unpredictable"
    }

== function reactREP(var)
    {"{filter(var,traitPOS)}" ? "{checkREP()}":
        ~ return true
    }
    
== function reactPOS(var, input)
    {"{filter(var,traitPOS)}" ? "{input}" :
        ~ return true
    }

== function reactNEG(var, input)
    {"{filter(var,traitNEG)}" ? "{input}":
        ~ return true
    }

== function reactINT(var, input)
    {
    - reactPOS(var, input):
        ~ return 1
    - reactNEG(var, input):
        ~ return -1
    - else:
        ~ return 0
    }
 
== function reactRELATE(ref var, input)
    {reactINT(var, input):
    - 1:
        ~ improve_trait(var, progBASE_5)
    - 0:
    - -1:
    }



 