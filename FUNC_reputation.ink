LIST npcLIKE = sincere, ruthless, charm
LIST npcDISLIKE = sincere, ruthless, charm
LIST npcRAPPORT = hate, contempt, dislike, neutral, like, admire, love

VAR playerSINCERE = 1
VAR playerRUTHLESS = 1
VAR playerCHARM = 1

VAR npc01 = (npcLIKE.sincere, npcDISLIKE.ruthless, hate)
VAR npc02 = (npcLIKE.charm, npcDISLIKE.sincere, neutral)
-> Start

== Start
You are Sincere, Ruthless, Charming - in different amounts.
Do something...
    -> Action


== Action

+ Sincere
    ~ playerSINCERE +=5
+ Ruthless
    ~ playerRUTHLESS +=1
+ Charming
    ~ playerCHARM +=1
+ Nothing
-
->Outcome

== Outcome
You are {checkREP()}.
-> NPCmeet

== YesThisWorks
Yes this works.
->DONE

== function checkREP()
//== function max(a,b) ===
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

== function reactREP(x)
    {"{checkREP()}" == "{filter(x,npcLIKE)}":
        ~ return true
    }
    
== function likedTHAT(npc, input)
    {"{input}" == "{filter(input,npcLIKE)}":
        ~ return true
    }

== function dislikedTHAT(npc, input)
    {"{input}" == "{filter(input,npcDISLIKE)}":
        ~ return true
    }

=== function filter(var, type)
    ~ return var ^ LIST_ALL(type)

== NPCmeet
NPCname: I hear you're {checkREP()}. I {reactREP(npc01): like that|don't like that}.
{npc01} 0
{improveRAPPORT(npc01)}_ {npc01}
{npc02} npc02
{improveRAPPORT(npc01)}_ {npc01}
{npc02} npc02

->YesThisWorks

== NPCreact(x)
I {likedTHAT(npc01,x): like that|{dislikedTHAT(npc01,x):really don't like that|don't care about it}}.

-> YesThisWorks

== function improveRAPPORT(ref npc)
    ~ temp rapport = filter(npc,npcRAPPORT)
    ~ npc -= rapport
    ~ npc += improve(rapport)
    

=== function improve(ref list)
    {
    -list != LIST_MAX(LIST_ALL(list)):
        ~ list ++
        ~ return list
    - else:
        ~ return list
    }




