INCLUDE FUNC_Dice.ink
INCLUDE FUNC_CountFuncs.ink
INCLUDE FUNC_essentials.ink
INCLUDE FUNC_pronouns.ink
INCLUDE FUNC_Encyclopedia.ink
INCLUDE FUNC_Variables.ink
INCLUDE FUNC_reputation.ink
INCLUDE FUNC_populate_inventory.ink
INCLUDE FUNC_populate_options_thread.ink
INCLUDE FUNC_thread_in_tunnel.ink
INCLUDE FUNC_tables_random_events.ink

-> LibraryStart

== LibraryStart
What do you want to do?
+ Look at Inventory
    <- ExamineWhat

+ Something else.
    ->YesThisWorks
+ Count Fish
    ->catchFish
-
->DONE