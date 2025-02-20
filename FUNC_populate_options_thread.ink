// <<<<<<< POPULATE OPTIONS w THREAD 

// Credit to averyhiebert.github.io/ via Inkle Discord
// Adapted by Keevy

LIST BedroomObjects = (Bed), (Drawer), (Window)
LIST BedroomTalkers = (Dog), (Cat), (Parrot)

VAR Interactables = (Bed, Dog, Cat, Parrot)

// >>>>>>>>>>>>>>>> CORE FUNCTION <<<<<<<<<<<<<<<<<<
== PopulateOptions(->optionDivert, options_to_show)
    {not options_to_show:->DONE}
    ~ temp show_option = LIST_MIN(options_to_show)
    <- PopulateOptions(optionDivert, options_to_show - show_option)
    + [{show_option}]
        -> optionDivert(show_option)
    - -> DONE


// >>>>>>>>>>>>>>>> INTERACT & REMOVE <<<<<<<<<<<<<<<<<<

== InteractWhat
    {not Interactables:You've interacted with everything. ->LibraryStart}
    Interact?
    <- PopulateOptions(-> Interact, Interactables)
    //<- PopulateOptions(-> Examine, BedroomExaminables)
    ->DONE

== Interact(x)
    {x ? item_name.exit: You leave the interaction. ->DONE}
    You interact with {x}.
    ~ Interactables -= x
    -> InteractWhat
    --> DONE

// >>>>>>>>>>>>>>>> INTERACT & PERSIST <<<<<<<<<<<<<<<<<<

== ExamineWhat
    Examine?
    <- PopulateOptions(-> ExamineItem, inventory)
    ->DONE

== ExamineItem(x)
    {x ? item_name.exit: You leave the inventory. ->LibraryStart}
    You look at {x}.
    -> ExamineWhat
    --> DONE
    
// >>>>>>>>>>>>>>>> TEST INCLUSION CONDITIONS <<<<<<<<<<<<<<
//
// These tests require a SORTER - a switch statement mapped to the named VARs. 
// Therefor these functions HAVE TO be particular to a project.
// Replace _OPTSDEMO with the project name


