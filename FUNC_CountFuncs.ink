//LIST quantity = J, A, B, C, D, E, F, G, H, I, AJ, AA, AB //etc where the letters replace the digits to get around that lists can't hold integers.


LIST colour = blue, red, silver

LIST sale_price = cheap, affordable, expensive

LIST material = iron, silver, steel, gold, wood
//LIST weapons = sword, spear, axe, club, dagger
LIST item_quantity = J, A, B, C, D, E, F, G, H, I, AJ, AA, AB, AC, AD, AE, AF, AG, AH, AI, BJ // ect.

LIST item_name = exit, sword, spear, axe, club, dagger, trout, carp, sardine
LIST item_name_proper = Exit, Sword, Spear, Axe, Club, Dagger, Trout, Carp, Sardine
LIST item_type = weapon, fish, resource

//LIST list_exit = exit

VAR inventory = (sardine, spear, dagger, exit)

VAR item_trout = (J, fish, blue, affordable)
VAR item_carp = (carp, J, fish, red, cheap)
VAR item_sardine = (sardine, J, fish, colour.silver, expensive)
VAR item_dagger = (dagger, A, weapon, steel, cheap)

VAR item_sword = (J, sword, material.silver, affordable)
VAR item_spear = (B, spear, gold, affordable)
VAR item_axe = (J, axe, iron, affordable)
VAR item_club = (J, club, wood, affordable)

//-> catchFish

=== catchFish
You have:
{countFish(item_trout)} trout.
{countFish(item_carp)} carp.
{countFish(item_sardine)} sardine.

+ Go fish?
    ~ alterQUANT(item_trout, 2)
    You have <>
    {countFish(item_trout)} {colourFish(item_trout)} trout.
-
+ Go fish?
    ~ alterQUANT(item_trout, 5)
    You have <>
    {countFish(item_trout)} {colourFish(item_trout)} trout.
-
-> DONE


== function quantity(item)
~ return LIST_VALUE(filter(item, item_quantity))

== function narr_quant(item)
{print_num(LIST_VALUE(filter(item, item_quantity)))}

 === function alterQUANT(ref var, delta)
   ~ temp x = LIST_VALUE(returnQuant(var))
   ~ var -= returnQuant(var)
   ~ var += item_quantity(x + delta)
   ~ return

=== function returnQuant(x)
    ~ return filter(x, item_quantity)    
    
=== function countFish(x)
~ return LIST_VALUE(returnQuant(x)) - 1

=== function colourFish(x)
    ~ return filter(x, colour)
