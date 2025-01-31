//LIST quantity = J, A, B, C, D, E, F, G, H, I, AJ, AA, AB //etc where the letters replace the digits to get around that lists can't hold integers.

// Need to wrap numbers - do better on the quantity system.

LIST colour = blue, red, silver

LIST sale_price = cheap, affordable, expensive

LIST material = iron, silver, steel, gold, wood
//LIST weapons = sword, spear, axe, club, dagger
LIST item_quantity1 = A, B, C, D, E, F, G, H, I
LIST item_quantity10 = AJ, BJ, CJ, DJ, EJ, FJ, GJ, HJ, IJ
LIST item_quantity100 = AJJ, BJJ, CJJ, DJJ, EJJ, FJJ, GJJ, HJJ, IJJ

LIST item_name = exit, sword, spear, axe, club, dagger, trout, carp, sardine
LIST item_name_proper = Exit, Sword, Spear, Axe, Club, Dagger, Trout, Carp, Sardine
LIST item_type = weapon, fish, resource

//LIST list_exit = exit

VAR inventory = (sardine, spear, dagger, exit)

VAR item_trout = (B, BJ, fish, blue, affordable)
VAR item_carp = (carp, fish, red, cheap)
VAR item_sardine = (sardine, F, fish, colour.silver, expensive)
VAR item_dagger = (dagger, A, weapon, steel, cheap)

VAR item_sword = (sword, material.silver, affordable)
VAR item_spear = (B, spear, gold, affordable)
VAR item_axe = (axe, iron, affordable)
VAR item_club = (club, wood, affordable)

//-> catchFish

=== catchFish
You have: {getQuantity(item_trout)} trout. Or {narr_quant(item_trout)} trout.
+ Add 9 trout.
    ~ alterQUANT(item_trout, 3)
+ Add 12 trout.
    ~ alterQUANT(item_trout, 12)
+ Add 250 trout.
    ~ alterQUANT(item_trout, 250)
+ Minus 43 trout.
    ~ alterQUANT(item_trout, -43)
+ Lose all trout.
    ~ clearQuant(item_trout)
-
-> catchFish

== function narr_quant(item)
{print_num(getQuantity(item))}

 === function alterQUANT(ref var, delta)
   ~ temp x = getQuantity(var)
   {-x > delta:
        You don't have enough.
        ~ return 
   }
   ~ clearQuant(var)
   ~ quantify(var, x + delta)
   ~ return

=== function clearQuant(ref var)
    ~ var -= filter(var, item_quantity1)
    ~ var -= filter(var,item_quantity10) 
    ~ var -= filter(var,item_quantity100)

=== function colourFish(x)
    ~ return filter(x, colour)

=== function getQuantity(x)
    ~ return LIST_VALUE(filter(x, item_quantity1))+(LIST_VALUE(filter(x, item_quantity10))*10)+(LIST_VALUE(filter(x, item_quantity100))*100)

=== function quantify(ref var, x)
{
- x >= 100:
        ~ var += item_quantity100(x / 100)
        ~ quantify(var, x mod 100)
- x >= 10:
        ~ var += item_quantity10(x / 10)
        ~ quantify(var, x mod 10)
- x > 0:
        ~ var += item_quantity1(x)
- else:
        ~ return
}

