// ............ ESSENTIAL FUNCTIONS .........
// Most from Inky Documentation
// Some from Keevy

=== function came_from(-> x)
    ~ return TURNS_SINCE(x) == 0

=== function alter(ref x, k) ===
    ~ x = x + k

=== function filter(var, type)
    ~ return var ^ LIST_ALL(type)

=== function whichTRAIT(var, list)
    ~ return var ^ LIST_ALL(list)

=== function check_overlap(var, trait)
    {trait ^ var:
        ~ return true
    -else:
        ~ return false
    }

=== function improve(ref list)
    {list != LIST_MAX(LIST_ALL(list)):
        ~ list ++
    }
        ~ return list 


== function improve_trait(ref var, trait_list)
    ~ temp trait = filter(var,trait_list)
    ~ var -= trait
    ~ var += improve(trait)
    
== function improve_progtrait(ref var, prime_trait, prog_trait)
    ~ temp trait = filter(var,prog_trait)
    ~ var -= trait
    
    {trait == LIST_MAX(LIST_ALL(prog_trait)):
        ~ var += LIST_MIN(LIST_ALL(prog_trait))
        ~ improve_trait(var, prime_trait)
    -else:
        ~ var += improve(trait)
    }

=== function degrade(ref list)
    {list != LIST_MIN(LIST_ALL(list)):
        ~ list --
    }
    ~ return list 

== function degrade_trait(ref var, trait_list)
    ~ temp trait = filter(var,trait_list)
    ~ var -= trait
    ~ var += degrade(trait)

=== function pop(ref list)
   ~ temp x = LIST_MIN(list) 
   ~ list -= x 
   ~ return x

=== function popMAX(ref list)
   ~ temp x = LIST_MAX(list) 
   ~ list -= x 
   ~ return x

== function returnX(x)
    ~ return x
    

// ............ ESSENTIAL LIST FUNCTIONS .........


=== function draw(ref var, list)
    // add a random available value from specific list to specific variable
    ~ var += LIST_RANDOM(list)

=== function deal(ref var, ref list)
    // add a random available value from specific list to specific variable and mark unavailable
    ~ temp dealt_value = LIST_RANDOM(list)
    ~ list -= dealt_value
    ~ var += dealt_value

=== function pick(value, ref var, ref list)
    // add a specific available value from specific list to specific variable and mark unavailable
    ~ list -= value
    ~ var += value
    
=== function copy(value, ref var)
    // add a specific available value from specific list to specific variable and mark unavailable
    ~ var += value

=== function discard(ref var, ref list)
    // remove all values of a specific list from a specific variable
    ~ var -= var ^ LIST_ALL(list)

=== function remove(value, ref list)
    // mark a specific value on a list unavailable.
    ~ list -= value

=== function recycle(ref var, ref list)
    // remove all values of a specific list from a specific variable and mark them available in the list
    ~ temp recycle_value = var ^ LIST_ALL(list)
    ~ list += recycle_value
    ~ var -= recycle_value


// ............ LIST PRINTING & GRAMMAR  .........
=== function isAre(list)
    {LIST_COUNT(list) == 1:is|are}
    
=== function plural(list)
    {LIST_COUNT(list) > 1:s}

=== function article(list)
    {LIST_COUNT(list) == 1:a }

=== function narrate_list(list, if_empty)
    // from inky documentation
    {LIST_COUNT(list):
    - 2:
            {LIST_MIN(list)} and {narrate_list(list - LIST_MIN(list), if_empty)}
    - 1:
            {list}
    - 0:
            {if_empty}
    - else:
            {LIST_MIN(list)}, {narrate_list(list - LIST_MIN(list), if_empty)}
    }

