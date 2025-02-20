// Resource drops
// [ ] - resources
// [ ] - containers
// [ ] - tiers

VAR box = (item_name.exit)
VAR box_stuffer = (sardine, sword, trout)

=== resourceGather
Gather Resources

+ Gather
    
+ Open and Take
    ~ fill_box(box,box_stuffer)
    <-scavengeWhat
-->DONE


== scavengeWhat
    {not box:Nothing left to take. ->resourceGather}
    Scavenge?
    <- PopulateOptions(-> scavenge, box)
    //<- PopulateOptions(-> Examine, BedroomExaminables)
    ->DONE

== scavenge(x)
    {x ? item_name.exit: You close the box. ->DONE}
    You take {x}.
    ~ box -= x
    ~ inventory += x
    -> scavengeWhat
    --> DONE
    
=== function fill_box(ref container, source)
    ~ box = ()
    ~ box +=  source
    ~ box += item_name.exit
