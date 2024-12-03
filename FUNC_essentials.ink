// ............ ESSENTIAL FUNCTIONS .........

=== function came_from(-> x)
    ~ return TURNS_SINCE(x) == 0

=== function alter(ref x, k) ===
    ~ x = x + k

=== function filter(var, type)
    ~ return var ^ LIST_ALL(type)

=== function improve(ref list)
    {
    -list != LIST_MAX(LIST_ALL(list)):
        ~ list ++
        ~ return list
    - else:
        ~ return list
    }

=== function degrade(ref list)
    {
    -list != LIST_MIN(LIST_ALL(list)):
        ~ list --
        ~ return list
    - else:
        ~ return list
    }

=== function pop(ref list)
   ~ temp x = LIST_MIN(list) 
   ~ list -= x 
   ~ return x
