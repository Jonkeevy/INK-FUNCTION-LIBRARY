LIST quantity = J, A, B, C, D, E, F, G, H, I, AJ, AA, AB //etc where the letters replace the digits to get around that lists can't hold integers.

LIST colour = blue, red, silver

LIST sale_price = cheap, affordable, expensive

VAR trout = (J, blue, affordable)
VAR carp = (J, red, cheap)
VAR sardine = (J, silver, expensive)

//-> catchFish

=== catchFish
You have:
{countFish(trout)} {colourFish(trout)} trout.
{countFish(carp)} carp.
{countFish(sardine)} sardine.

+ Go fish?
~ alter(trout, 2)
You caught <>
{countFish(trout)} {colourFish(trout)} trout.
-
+ Go fish?
~ alter(trout, 5)
You caught <>
{countFish(trout)} {colourFish(trout)} trout.

-> DONE

 === function alterQUANT(ref var, delta)
   ~ temp x = returnQuant(var)
   ~ var -= quantity
   ~ var += quantity(LIST_VALUE(x) + delta)
   ~ return

=== function returnQuant(x)
    ~ return x ^ LIST_ALL(quantity)    
    
=== function countFish(x)
~ return LIST_VALUE(returnQuant(x)) - 1

=== function colourFish(x)
    ~ return x ^ LIST_ALL(colour)
