// <<<<<<< POPULATE OPTIONS w THREAD - USED AS INVENTORY MANAGEMENT
// Credit to averyhiebert.github.io/ via Inkle Discord
// Adapted by Keevy

// REDUNDANT FUNCTIONS

 /*  
== ExamineWhat
Examine?
<- PopulateInventory(-> ExamineItem, inventory)
->DONE

== ExamineItem(x)
{x ? exit: You leave the inventory. ->LibraryStart}
You look at {x}.
-> ExamineWhat

== PopulateInventory(->itemDivert, items_to_show)
{not items_to_show:->DONE}
~temp show_option = LIST_MIN(items_to_show)
<- PopulateInventory(itemDivert, items_to_show - show_option)
+ [{show_option}]
    -> itemDivert(show_option)
//
--> DONE

*/ 
