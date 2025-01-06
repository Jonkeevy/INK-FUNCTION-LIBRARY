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

=== function has(var, trait)
    {trait ^ var:
    ~ return true
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

== function returnX(x)
    ~ return x