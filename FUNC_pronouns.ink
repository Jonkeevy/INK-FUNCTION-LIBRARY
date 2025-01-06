// <<<<<<<<<<<<<<<<<<<< GRAMMAR FUNCTIONS GENDER >>>>>>>>>>>
VAR npcA = ()

LIST gender = male, female, nonbinary, it_gender
LIST otherList = other
LIST people = Bob, Dave, Sean, Ida
LIST things = (hammer), block, nail, rat, pencil



//VAR quantCoins = 0

VAR coins = 0
VAR testThing = (iron, dagger, I)

//->grammar_test_menu

== grammar_test_menu
~ npcA = ()
~ npcA += other // modelling having multiple values.

Test:
+ Male
    ~ npcA += male
+ Female
    ~ npcA += female
+ Non-binary
    ~ npcA += nonbinary
+ Object / it
    ~ npcA += it_gender
+ People (Lists)
    -> People
+ Things (Lists)
    -> Things
+ Inventory Items (Lists)
    -> Items
+ Currencies (Integers)
    -> Currencies

-
-> sample_text(npcA)

== sample_text(x)
+ Present Tense
{LIST_COUNT(npcA)}

You may not like {them(x)} at first, but {theyve(x)} got guts. {Theyve(x)} got a few scars and some fresh injuries. But that only adds to {their(x)} appeal. Why does being injured make {them(x)} seem invulnerable? Because it shows {they(x)} {havehas(x)} no fear.
{They(x)} {isare(x)} available to recruit.
That room is {theirs(x)}.

+ Past Tense
{They(x)} {waswere(x)} the one who caused the accident.

You may not like {them(x)} at first, but {theyve(x)} got guts. {Theyve(x)} got a few scars and some fresh injuries. But that only adds to {their(x)} appeal. Why does being injured make {them(x)} seem invulnerable? Because it shows {they(x)} {havehas(x)} no fear.
{They(x)} {isare(x)} available to recruit.
That room is {theirs(x)}.

-->grammar_test_menu

== People
+ Sinlge
    ~ people = Bob
+ Plural
    ~ people += Ida
    ~ people += Dave
+ Empty
    ~ people = ()

    
--> Single_Plural(people)

== Single_Plural(x)
{narr_Properlist(x,"No one")} {waswere(x)} here.

{narr_Properlist(x,"No one")} run{verbS(x)} this place.

{narr_Properlist(x,"No one")} {isare(x)} in charge.

"You know {narr_Properlist(x,"No one")}? Yeah, {they(x)} {isare(x)} in charge.

-->grammar_test_menu

== Things
+ Sinlge
    ~ things = hammer

+ Plural
    ~ things += nail
    ~ things += pencil
+ Empty
    ~ things = ()

-->Single_Plural_Things(things)

== Single_Plural_Things(x)

I've got {narr_thinglist(x,"nothing")}.

You can use {narr_thinglist(x,"your imagination")} to escape. If you can't use {thatthose(x,"anything")} then try talking.

You can use {narr_thingpossibles(x,"anything you find")} as a weapon.

If you have {narr_thingpossibles(x,"your imagination")} then use {thatthose(x,"trickery")}. 

-->grammar_test_menu

== Items
+ Daggers
    ~ testThing = item_dagger
    -> Single_Plural_Items(testThing)

== Single_Plural_Items(item)

You have {narr_quant(item)} {filter(item, material)} {filter(item, item_name)}{plurInt(quantity(item))}.
-->grammar_test_menu

== Currencies

+ One
    ~ coins = 1
+ Five
    ~ coins = 5
+ Zero
    ~ coins = 0
-->Currency_Trackers(coins)


== Currency_Trackers(currency)

You have {print_num(currency)} coin{plurInt(currency)}.

-->grammar_test_menu


// <<<<<<<<<<<<<<<<<<<<< PRONOUN >>>>>>>>>>>>>>>>>>>>>>

== function They(x)
    {
    - x ^ male:
        ~ return "He"
    - x ^ female:
        ~ return "She"
    - x ^ nonbinary:
        ~ return "They"
    - x ^ it_gender:
        ~ return "It"
    - else:
        ~return "They"
    }

== function they(x)
    {
    - x ^ male:
        ~ return "he"
    - x ^ female:
        ~ return "she"
    - x ^ it_gender:
        ~ return "it"
    - else:
        ~return "they"
    }

== function Theyve(x)
    {
    - x ^ male:
        ~ return "He's"
    - x ^ female:
        ~ return "She's"
    - x ^ it_gender:
        ~ return "It's"
    - else:
        ~ return "They've"
    }

== function theyve(x)
    {
    - x ^ male:
        ~ return "he's"
    - x ^ female:
        ~ return "she's"
    - x ^ it_gender:
        ~ return "it's"
    - else:
        ~return "they've"
    }

== function Them(x)
    {
    - x ^ male:
        ~ return "Him"
    - x ^ female:
        ~ return "Her"
    - x ^ it_gender:
        ~ return "It"
    - else:
        ~ return "Them"
    }

== function them(x)
    {
    - x ^ male:
        ~ return "him"
    - x ^ female:
        ~ return "her"
    - x ^ it_gender:
        ~ return "it"
    - else:
        ~ return "them"
    }

== function Their(x)
    {
    - x ^ male:
        ~ return "His"
    - x ^ female:
        ~ return "Hers"
    - x ^ it_gender:
        ~ return "Its"
    - else:
        ~ return "Their"
    }
    
== function their(x)
    {
    - x ^ male:
        ~ return "his"
    - x ^ female:
        ~ return "her"
    - x ^ it_gender:
        ~ return "its"
    - else:
        ~ return "their"
    }

== function Theirs(x)
    {
    - x ^ male:
        ~ return "His"
    - x ^ female:
        ~ return "Hers"
    - x ^ it_gender:
        ~ return "Its"
    - else:
        ~ return "Theirs"
    }
    
== function theirs(x)
    {
    - x ^ male:
        ~ return "his"
    - x ^ female:
        ~ return "hers"
    - x ^ it_gender:
        ~ return "its"
    - else:
        ~ return "theirs"
    }

// <<<<<<<<<<<<<<<<<<<<< CONCORD >>>>>>>>>>>>>>>>>>>>>>
// Concord needs to check for lists too.

// <<<<<<< AUXILLARY VERBS >>>>>>>>>>>>>>

=== function IsAre(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "Is"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "Is"
    - else:
        ~ return "Are"
    }

=== function isare(x)
    {
    - LIST_COUNT(x) < 2:
        ~ return "is"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "is"
    - else:
        ~ return "are"
    }
        
 === function WasWere(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "Was"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "Was"
    - else:
        ~ return "Were"
    }

=== function waswere(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "was"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "was"
    - else:
        ~ return "were"
    }

== function HaveHas(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "Has"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "Has"
    - else:
        ~ return "Have"
    }
    
== function havehas(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "has"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "has"
    - else:
        ~ return "have"
    }


=== function DoDoes(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "Does"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "Does"
    - else:
        ~ return "Do"
    }

=== function dodoes(x)
    {
    - LIST_COUNT(x)  < 2:
        ~ return "does"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "does"
    - else:
        ~ return "do"
    }

== function HadHas(x)
    // For those who are uncertain about English grammar, "Had" is always "Had"
    ~ return "Had"

== function hadhas(x)
    // For those who are uncertain about English grammar, "had" is always "had"
    ~ return "had"

// <<<<<< REGULAR VERBS >>>>>> 

=== function verbS(x)
    // eg He play{conc(x)}
    {
    - LIST_COUNT(x) < 2:
        ~ return "s"
    - x ^ male || x ^ female || x ^ it_gender:
        ~ return "s"
    - else:
        ~ return
    }


// <<<<< DETERMINERS >>>>>>>>>>>

=== function ThatThose(x, if_empty)
    {
    - LIST_COUNT(x) == 0:
        ~ return if_empty
    - LIST_COUNT(x) == 1:
        ~ return "That"
    - else:
        ~ return "Those"
    }

=== function thatthose(x, if_empty)
    {
    - LIST_COUNT(x) == 0:
        ~ return if_empty
    - LIST_COUNT(x) == 1:
        ~ return "that"
    - else:
        ~ return "those"
    }

=== function ThisThese(x, if_empty)
    {    
    - LIST_COUNT(x) == 0:
        ~ return if_empty
    - LIST_COUNT(x) == 1:
        ~ return "This"
    - else:
        ~ return "These"
    }

=== function thisthese(x, if_empty)
    {
    - LIST_COUNT(x) == 0:
        ~ return if_empty
    - LIST_COUNT(x) == 1:
        ~ return "this"
    - else:
        ~ return "these"
    }

=== function plurInt(x)
    {x == 1: |s}

=== function plurList(list)
    {LIST_COUNT(list) == 1: |s}

=== function articleInd(list)
    {LIST_COUNT(list) == 1:a }
    
=== function ArticleInd(list)
    {LIST_COUNT(list) == 1:A }

=== function narr_Properlist(list, if_empty)
// From Inky documentation
    {LIST_COUNT(list):
    - 2:
            {LIST_MIN(list)} and {narr_Properlist(list - LIST_MIN(list), if_empty)}
    - 1:
            {list}
    - 0:
            {if_empty}
    - else:
            {LIST_MIN(list)}, {narr_Properlist(list - LIST_MIN(list), if_empty)}
    }

=== function narr_thinglist(list, if_empty)
// From Inky documentation
    {LIST_COUNT(list):a <>}
    {LIST_COUNT(list):
    - 2:
            {LIST_MIN(list)} and {narr_thinglist(list - LIST_MIN(list), if_empty)}
    - 1:
            {list}
    - 0:
            {if_empty}
    - else:
            {LIST_MIN(list)}, {narr_thinglist(list - LIST_MIN(list), if_empty)}
    }


=== function narr_thingpossibles(list, if_empty)
// From Inky documentation
    {LIST_COUNT(list):a <>}
    {LIST_COUNT(list):
    - 2:
            {LIST_MIN(list)} or {narr_thingpossibles(list - LIST_MIN(list), if_empty)}
    - 1:
            {list}
    - 0:
            {if_empty}
    - else:
            {LIST_MIN(list)}, {narr_thingpossibles(list - LIST_MIN(list), if_empty)}
    }

 
/*
<<<<<<<<<<<< Determiners Affected by Concord >>>>>>>>>>>>

    [X]... this → book (singular), these → books (plural)
    [X]... that → apple (singular), those → apples (plural)
    
<<<<<<<<<<<< Auxiliary Verbs Affected by Concord  >>>>>>>>>>>>

    [X]... is → he/she/it (singular), are → they (plural)
    [X]... was → he/she/it (singular), were → they (plural)
    [X]... has → he/she/it (singular), have → they (plural)
    [X]... does → he/she/it (singular), do → they (plural)
    [X]... had → remains the same regardless of subject (used for singular and plural).
    
    
*/

// <<<<<<<<<<<<<<<<<< NARRATE NUMBERS >>>>>>>>>>>>>>>>>>>

=== function print_num(x) ===
// From Inky Documentation
{
    - x >= 1000:
        {print_num(x / 1000)} thousand { x mod 1000 > 0:{print_num(x mod 1000)}}
    - x >= 100:
        {print_num(x / 100)} hundred { x mod 100 > 0:and {print_num(x mod 100)}}
    - x == 0:
        zero
    - else:
        { x >= 20:
            { x / 10:
                - 2: twenty
                - 3: thirty
                - 4: forty
                - 5: fifty
                - 6: sixty
                - 7: seventy
                - 8: eighty
                - 9: ninety
            }
            { x mod 10 > 0:<>-<>}
        }
        { x < 10 || x > 20:
            { x mod 10:
                - 1: one
                - 2: two
                - 3: three
                - 4: four
                - 5: five
                - 6: six
                - 7: seven
                - 8: eight
                - 9: nine
            }
        - else:
            { x:
                - 10: ten
                - 11: eleven
                - 12: twelve
                - 13: thirteen
                - 14: fourteen
                - 15: fifteen
                - 16: sixteen
                - 17: seventeen
                - 18: eighteen
                - 19: nineteen
            }
        }
}