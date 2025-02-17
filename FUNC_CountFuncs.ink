// >>>>>>>>>>>>>>> COUNTING USING LISTS <<<<<<<<<<<<<

LIST colour = blue, red, silver

LIST sale_price = cheap, affordable, expensive

LIST material = iron, silver, steel, gold, wood

LIST item_quantity1 = one, two, three, four, five, six, seven, eight, nine
LIST item_quantity10 = ten =10, twenty =20, thirty = 30, forty = 40, fifty =50, sixty = 60, seventy = 70, eighty = 80, ninety =90
LIST item_quantity100 = one_hundred = 100, two_hundred = 200, three_hundred = 300, four_hundred = 400, five_hundred = 500, six_hundred =600, seven_hundred = 700, eight_hundred = 800, nine_hundred =900

LIST item_name = exit, sword, spear, axe, club, dagger, trout, carp, sardine, toe
LIST item_name_proper = Exit, Sword, Spear, Axe, Club, Dagger, Trout, Carp, Sardine
LIST item_type = weapon, fish, resource

VAR inventory = (sardine, spear, dagger, item_name.exit)

VAR item_trout = (two, twenty, fish, blue, affordable)
VAR item_carp = (carp, fish, red, cheap)
VAR item_sardine = (sardine, eight, fish, colour.silver, expensive)
VAR item_dagger = (dagger, one, weapon, steel, cheap)

VAR item_sword = (sword, material.silver, affordable)
VAR item_spear = (two, spear, gold, affordable)
VAR item_axe = (axe, iron, affordable)
VAR item_club = (club, wood, affordable)

//-> catchFish

=== catchFish
You have: {getQuantity(item_trout)} trout. Or {narr_quant(item_trout)} trout.
+ Add 3 trout.
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
    ~ return LIST_VALUE(filter(x, item_quantity1))+LIST_VALUE(filter(x, item_quantity10))+LIST_VALUE(filter(x, item_quantity100))

=== function quantify(ref var, x)
{
- x >= 100:
        ~ var += item_quantity100((x / 100)*100)
        ~ quantify(var, x mod 100)
- x >= 10:
        ~ var += item_quantity10((x / 10)*10)
        ~ quantify(var, x mod 10)
- x > 0:
        ~ var += item_quantity1(x)
- else:
        ~ return
}

// >>>>>>>>>>>>>>>>>>> DIP SWITCH COUNTING <<<<<<<<<<<<<<<
// orignal by Keevy, vastly improved by avery.h

LIST DIPswitch = (dip1 = 1), (dip2 = 2), (dip4 = 4), (dip8 = 8), (dip16 = 16), (dip32 = 32), (dip64 = 64), (dip128 = 128), (dip256 = 256), (dip512 = 512), (dip1024 = 1024), (dip2048 = 2048), (dip4096 = 4096), (dip8192 = 8192), (dip16384 = 16384)

VAR dipToes = (toe, dip1, dip64, dip4)

=== count_your_toes
You have {countDIP(dipToes)} toes.
+ Add 300
    Now you have 300 more...
    ~ alterDIP(dipToes,300)
+ Minus 13
    ~ alterDIP(dipToes,-13)
-
So you have {countDIP(dipToes)} toes.
-> count_your_toes

=== function countDIP(var)
    ~var = var ^ DIPswitch
    {var == (): 
        ~return 0
    }
    ~return INT(LIST_VALUE(var)) + countDIP(var - LIST_MAX(var))

=== function alterDIP(ref var, delta) ===
    ~var = var - DIPswitch + progDIP(countDIP(var) + INT(delta), DIPswitch)

=== function progDIP(total,switches) ===
    ~temp switch = LIST_MAX(switches)
    {
    - switches == ():
        ~return ()
    - total >= LIST_VALUE(switch):
        ~return switch + progDIP(total-LIST_VALUE(switch), switches-switch)
    - else:
        ~return progDIP(total, switches-switch)
    }

