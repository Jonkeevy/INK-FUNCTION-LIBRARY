// <<<<<<< POPULATE OPTIONS w THREAD
// Credit to averyhiebert.github.io/ via Inkle Discord

LIST BedroomObjects = (Bed), (Drawer), (Window)
LIST BedroomTalkers = (Dog), (Cat), (Parrot)

VAR BedroomExaminables = (Bed, Dog, Cat, Parrot)


-> ExamineLogic
    
== ExamineLogic
{not BedroomExaminables:You've looked at everything.->DONE}
Examine?
<- PopulateOptions(-> Examine, BedroomExaminables)
->DONE


== PopulateOptions(->optionDivert, options_to_show)
{not options_to_show:->DONE}
~temp show_option = LIST_MIN(options_to_show)
<- PopulateOptions(optionDivert, options_to_show - show_option)
+ [{show_option}]
    -> optionDivert(show_option)
- -> DONE

== Examine(x)
You look at {x}.
~ BedroomExaminables -= x
-> ExamineLogic