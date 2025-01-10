// <<<<<<< POPULATE OPTIONS w THREAD - DISAPPEARING OPTIONS.
// Credit to averyhiebert.github.io/ via Inkle Discord
// Adapted by Keevy

LIST BedroomObjects = (Bed), (Drawer), (Window)
LIST BedroomTalkers = (Dog), (Cat), (Parrot)

VAR Interactables = (Bed, Dog, Cat, Parrot)

-> InteractWhat


== InteractWhat
{not Interactables:You've interacted with everything.->Womble_Womble}
Interact?
<- PopulateOptions(-> Interact, Interactables)
//<- PopulateOptions(-> Examine, BedroomExaminables)
->DONE


== PopulateOptions(->optionDivert, options_to_show)
{not options_to_show:->DONE}
~temp show_option = LIST_MIN(options_to_show)
<- PopulateOptions(optionDivert, options_to_show - show_option)
+ [{show_option}]
    -> optionDivert(show_option)
- -> DONE

== Interact(x)
{x ? exit: You leave the interaction. ->DONE}
You interact with {x}.
~ Interactables -= x
-> InteractWhat
