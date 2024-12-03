LIST BedroomObjects = (Bed), (Drawer), (Window)
LIST BedroomTalkers = (Dog), (Cat), (Parrot)

VAR BedroomExaminables = (Bed, Dog, Cat, Parrot)
VAR OptionHolder = ()


-> ExamineLogic(->Examine, BedroomExaminables)
    
== ExamineLogic(->examineDivert, examineList)
Examine?
~ OptionHolder = examineList
-(top)
<- PopulateOptions(examineDivert, OptionHolder)
{LIST_COUNT(OptionHolder): ->top}
->DONE


== PopulateOptions(->optionDivert, ref optionList)
    ~ temp name = pop(optionList)
    + [{name}]
        ->optionDivert(name)

=== function pop(ref list)
   ~ temp x = LIST_MIN(list) 
   ~ list -= x 
   ~ return x

== Examine(x)
You look at {x}.
-> DONE