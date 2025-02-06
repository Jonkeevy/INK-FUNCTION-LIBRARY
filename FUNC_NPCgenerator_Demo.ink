// >>>>>>>>>>>>>>>>> Random Name Generator for Ink <<<<<<<<<<<<<<<<<
//
// VERSION 00.1
// (mostly) CREATED by JON KEEVY.... free to use, no credit required (tipping appreciated & collaborations encouraged)
// freelancer@jonkeevy.com
//
// Built for display in:
// Atrament Web UI
// Copyright (c) 2023 Serhii "techniX" Mozhaiskyi. (distributed under MIT license) - find it on github.com/technix/atrament-web-ui

-> StartDemo
===StartDemo
[banner style=accent]CHARACTER GENERATOR![/banner]
<mark><center>+++ PART ONE: NAMES +++</center></mark>

 -> demo_NPCgenerator
//+ [ATRAMENT] ->AtramentUI->
-->StartDemo

=== demo_NPCgenerator
+ [HOW TO USE THE NAME GENERATOR] #CLEAR
    -> HowToUseIt.Intro
+ [HOW THE NAME GENERATOR WAS BUILT] #CLEAR
    -> HowItWorks.Intro


=== HowItWorks
=Intro
This is Part One of a series leading up to a singular goal: to have an endless variety of characters in my game story.
Now, I <i>could</i> write each one, and that's a totally beautiful way to do it if that's what <i>you</i> want to do.
But <i>I</i> am lazy.
So instead of handcrafted characters I'm going to put together sets of key traits, write some functions to mix em up... 

<center><big>et voila!</></>
[banner][img]IMAGES/EMOJI JAK.png[/img] [img]IMAGES/EMOJI GLENDA.png[/img] [img]IMAGES/EMOJI LEGACY.png[/img] [img]IMAGES/EMOJI MAKHANDA.png[/img][/banner]
<center>A nearly infinite cast of characters.</>
+ [INFINITE SEEMS LIKE A LOT] #CLEAR
-
A few traits creates a LOT of combinations. It's an exponential thing. 

Now there are ways to do this without <i>looking back</i> - meaning that the player will never encounter the unique snowflakes ever again. Very simple ways like shuffle blocks and so on.
But though I am lazy, I am also thorough. I want players to be able to revisit their new buddies and form relationships with them. Maybe recruit them to their band or ship. Maybe romance them.
So let here's what I'm making: a system that selects and assembles features into a character, saves them, and inserts them into the game world.

Part One: Names. Let's make an endless supply of them.

If you're familiar with Ink you can probably grok what I was up to without this explainer. Skip my rambling explanation and go straight to How To Use The Name Generator.

+ EXPLAIN HOW IT WAS MADE.  #CLEAR
+ I CAN GROK HOW YOU MADE IT. TAKE ME TO HOW TO USE IT.  #CLEAR
    ->HowToUseIt.Intro
+ I CAN GROK HOW YOU MADE IT BUT YOU CAN EXPLAIN ANYWAY, YOU WORKED HARD ON THIS.
    Thanks, I did.
    ++ LET'S GET ON WITH IT.   #CLEAR
+ I ACTUALLY WANT TO LEAVE.    #CLEAR
    -> EndDemo
-

+ [START AT THE BEGINNING] #CLEAR
    -> Storage
+ [CHOOSE A TOPIC] #CLEAR

-(Menu)
+ [INTRODUCTION] #CLEAR
    -> Intro
+ [SAVING YOUR NPCs] #CLEAR
    -> Storage
+ [NAMES]#CLEAR
    -> Names
//+ [APPEARANCE] #CLEAR
//+ [GENDER] #CLEAR
//+ [DICTION] #CLEAR
//+ [ATTITUDES] #CLEAR

=Storage
[banner]STORAGE[/banner]
    "Let me introduce myself. The name is..."
    The adventurer blinks at you, suddenly beset by an existential crisis.
    "npc01, I think. Is that possible?"
    
    It is both possible and necessary, npc01. I need a place to store the information about you. So before you get a real name you get defined as a variable.
    [info]VAR npc01 = ()[/info]
    The empty brackets mean that this variable can take values from lists. 
+ [EXPLAIN LISTS] #CLEAR
-> Lists
= Lists
[banner]LISTS[/banner]
Lists are where possible traits are stored. 
Lists get declared with LIST. Thing to note: list values can be printed as strings but they are NOT strings, so no spaces and no numbers on their own.
Tip: set up a regex to swap all underscores with spaces in whatever engine you use. It makes lists as strings more useful and flexible.

Here's a list of possible names for npc01.
    [info]LIST npc_name = nobody, (Alfred), (Bertie), (Caryn), (Debora)[/info]
The brackets mark the names as being available.
Now I need a function that picks a value from a list and assigns it to a variable.
This is a bit like drawing a card from a deck, so guess what I call it?

+ [DRAW?] #CLEAR
->Draw_Function
= Draw_Function
[banner]DRAW[/banner]

The <mark>draw</mark> function picks a value from a list and assigns it to a variable.

[info]=== function draw(ref var, ref list)<br>~ var += LIST_RANDOM(list)[/info]

Since the point is to create variety it would not be great to have a bartender with the same name as the dude in the last town.

+ [TRUE] #CLEAR
-> Deal_Function
= Deal_Function
[banner]DEAL[/banner]

To avoid duplicates I'm going to define a function does 3 things:
1. Picks an available value from the list and assigns it a temp variable.
2. Marks that value as being unavailble for future calls.
3. Adds it to a target variable.

Since it's like dealing a card from a deck I call this a <mark>deal</mark> function. It's similar to the <mark>pop</mark>' function found in the Ink documentation.
 
[info]=== function deal(ref var, ref list)<br>~ temp dealt_value = LIST_RANDOM(list)<br>~ list -= dealt_value<br>~ var += dealt_value[/info]

+ SO IT'S DRAW OR DEAL  #CLEAR
-
Use draw or deal as appropriate for the kind of traits on your lists and your game story.
If a player could exhaust the content in a list because of how your game story is set up, then you should use the <mark>draw</mark> function.

+ [RIGHT. NOW GIVE NPC01 A NAME ALREADY!]
#CLEAR
-> Names
= Names
[banner]NAMES[/banner]
First give npc01 a name with by <mark>dealing</mark> one from the npc_name list.
[info] ~ deal(npc01, npc_name)[/info]
~ deal(npc01,npc_name)
Next step, retrieving the name.
To print the name assigned we use a function to return the value in npc01 that comes from a specific list. This is important as we will store more information in npc01.

[info]=== function filter(x, list)<br>~ return x ^ LIST_ALL(list)[/info]

I'm going to streamline it a little. Here's a function that uses filter but is specific for a name.

[info]=== function name(x)<br>~ return filter(x, npc_name)[/info]

This only works because I've specified the name of the list. If you change the name of the list, you'll need to update this function.

So now I can use \{name(npc01)\} and save a little typing. (I told you I'm lazy.)

+ [SAY HI TO NPC01] #CLEAR
-
<center><big>"Hello! My name is {name(npc01)}"</></>
+ [NICE, BUT BASIC]
-> Change_Name
= Change_Name
Let's change npc01's name to something else.
How about...
[info]\~ deal(npc01,npc_name)[/info]
~ deal(npc01,npc_name)
<center><big>"My name is {name(npc01)}"</></>
That's not right. Now they have two names...

I merely added more name bits to npc01. To change their name I need to get rid of the old one. Before I add a new one.
+ [YOU'RE GOING TO MAKE A NEW FUNCTION, AREN'T YOU?]
#CLEAR
-> Discard
= Discard
[banner]DISCARD[/banner]
Here's the discard function... throw that value in the trash!!!

1. Filters the value to be removed from the variable by list type.
2. Removes it from the variable.

[info]=== function discard(ref var, ref list)<br>~ var -= var ^ LIST_ALL(list)[/info]

{discard_name(npc01)}
<center><big>"My name is now... {name(npc01)}"</></>
(Nothing there, right? Because it was discarded...

This is for when you never want to see that value again.

But if you <i>do want to use it again...</i>

+ [LIKE, RECYCLE IT?]
#CLEAR
->Recycle
= Recycle
[banner]RECYCLE[/banner]
Recycling! Here's a function to put the value BACK in the list for reuse later! It's deal in reverse!

1. Filters the value to be removed by list type.
2. Gives it a temp variable to hold it.
3. Removes it from the target variable.
3. Marks it available in the original list.

[info]=== function recycle(ref var, ref list)<br>~ temp recycle_value = var ^ LIST_ALL(list)<br>~ list += recycle_value<br>~ var -= recycle_value [/info]

I'm not going to demonstrate this. Just trust me it works.
-
So to changer npc01's name we need to do some combination of discard/recycle and deal/draw. Whichever is right for your game.
[info]~recycle(npc01,npc_name)<br>~ deal(npc01,npc_name)[/info]
NOTE: It's possible with using recycle to get the SAME name. Just something to bear in mind.
    ~ recycle(npc01,npc_name)
    ~ deal(npc01,npc_name)
+ [SAY HI TO NPC01 (AGAIN)] #CLEAR
-
<center><big>"Hello! My name is {name(npc01)}"</></>
+ [ALL DONE WITH NAMES?]
-
Nope.
+ [FINE, CARRY ON.] #CLEAR
-
-> Multiple_Name_Lists

= Multiple_Name_Lists
As I've said several times now. I'm lazy. And I have a bad memory. I think I said that.
Anyway.

I can give an NPC a name off npc_names or Name_genericMale or I might add a totally new list. But if name(npc01) only checks ONE of those lists then I have a problem.

The only way around it is to include all the name lists to check in the function.

So name() really looks like this:
[info]=== function name(x)<br>\{<br>-filter(x, npc_name):<br>~ return filter(x, npc_name)<br>-filter(x, Name_genericMale):<br> ~ return filter(x, Name_genericMale)<br>\}[/info]

The same is true for all the name functions 

+ [LET'S GET BIGGER.] #CLEAR
-
-> Name_Chunks
= Name_Chunks
[banner]ONSET & CODA[/banner]
This is where we get fun. 
<center><big>WORD NERD FUN!</></>
I want to have a lot of variation. It's more efficient to create variation by combining elements of sets than by adding more elements to a single set.
The sets I'm going to use are chunks of words.
Words can be split into parts in many ways, like by syllables, sounds, onsets, Codas, etc.
Which way we do it will depend on what we want to achieve.
But for simplicity I'm going to use the terms 'Onset' for the first part and 'Coda' for the end. (To the true word-nerds, I'm sorry.)
+ [GET ON WITH IT] #CLEAR
-
[banner]COMPOUND NAMES[/banner]
I want pirates. Pirates have cool names like Blackbeard and Long John Silver.

So, here's a list of piratey words that would be good onsets:
[info]LIST Onset_Pirate = (Blue), (Red), (Crimson), (Golden), (Grey)[/info]

And a list of good codas:
[info]LIST Coda_Pirate = (bringer), (flag), (wave), (blade), (beard)[/info]

Set up versions of the deal, draw, discard and recycle functions for the onset and coda elements:
[info]\{draw_OnsetCoda(npc01, Onset_Pirate, Coda_Pirate)\}[/info]

Then I want to be able to pull the compound name with the same ease as name()... so I set up  longname() 
[info]My name is \{name(npc01)\} \{longname(npc01)\}[/info]

Here we go...
{draw_OnsetCoda(npc01, Onset_Pirate, Coda_Pirate)}
"My name is {name(npc01)} {longname(npc01)}!"

+ [EXPLAIN IN MORE DETAIL]#CLEAR 
    ->Compound_Details
+ [I GET IT, NO NEED TO EXPLAIN]
    Sure, gotcha.
    ++ [FINISH UP PLS]#CLEAR
    ->EndDemo

= Compound_Details
Right, lemme show you how the sausage is made. Metaphorically, obviously. We all know how realy sausage is made.
Here's longname()...
[info]=== function longname(x)<br>~ temp onset_var = filter_onset(x)<br>~ temp midsyll_var = filter_midsyll(x)<br>~ temp Coda_var = filter_coda(x)<br>~ return "\{onset_var\}\{midsyll_var\}\{Coda_var\}"[/info]

The different between it and name() is that name() returns a single value which I'm using as a string.
Longname() checks the variable for an onset AND a coda, then sticks them together like a string.

+ [HOLD UP. WHAT'S "MIDSYLL"?]
Oh, yes. That's because I might want to have a really long name. Or weird name. So midsyll_var is in there.
It won't cause problems if there's nothing for it to find.
-
+ [GIVE ME AN EXAMPLE OF A WEIRD NAME]#CLEAR
-
I'm so glad you asked!

You know how demons always have those names like someone gargling teeth?

~ discard_longname(npc01)
~ draw_OnsetMidsyllCoda(npc01, Onset_Demonic, Midsyll_Demonic, Coda_Demonic)

Hi, my name is {name(npc01)} {longname(npc01)}.

Cool, right?


-
->EndDemo

=== HowToUseIt
= Intro
+ [SET UP] #CLEAR
    -> Setup
+ [CALLING FUNCTIONS] #CLEAR
    -> CallFunc
- (Setup)
Download the following files put them in the same folder as your main .ink file and use the include statement to include them in you project.
    [info]INCLUDE FUNC_NameGenerator.ink<br>INCLUDE LIST FUNC_NPCgenerator<br>INCLUDE FUNC_EssentialFunctions.ink[/info]

You'll need to define NPC variables in the following format:
    [info]VAR npc01 = ()[/info]
    Already set up are 5 NPC variables.
    
And lists of names, onsets and Codas as needed for your game's world.
(Onsets are starts of words, Codas are endings.)
    [info]LIST Name_genericMale = (Allen), (Bob), (Chris), (Dean), (Evan)[/info]
Lists that are already set up are:
Standard first names
Normie onsets and codas
Fantasy names
Pirate onsets and codas
Halfling onsets and codas
    -> SubMenu

-> CallFunc
= CallFunc
This is how you use the functions in your game.
    -> SubMenu
    
= SubMenu
+ [BACK TO THE MENU] #CLEAR
    -> Intro
+ [ALL DONE] #CLEAR
-->EndDemo


=== EndDemo
That's it for Part One. Part Two will be about DICTION.

I'll be adding more Ink resources and tutorials in the future. You can request features or topics in the comments or me with @jonkeevy most places. Like Discord or Instagram.
<br>
If you found this useful, please send me a dollar via PayPal or donate on Itch. I'm in South Africa so a little goes a long way.
<br>
[info]www.paypal.com/paypalme/jonkeevy[/info]

You can find Atrament UI at 
[info]github.com/technix/atrament-web-ui[/info]
+ [ATRAMENT] #CLEAR
    ->AtramentUI->
+ [BACK TO THE START] #CLEAR
-> demo_NPCgenerator
+ [GOOD BYE]
--> END

=== AtramentUI
[banner]ATRAMENT WEB UI[/banner]
Atrament Web UI is a web wrapper for Ink made by Serhii "techniX" Mozhaiskyi - big thanks to him. This demo is made with Atrament and uses its built-in features like banners, toolbars, call-out boxes, and inline images.
[info side=highlight] github.com/technix/atrament-web-ui [/info]
<br>

-(Leave)
Alright. Back to where you came from.
+ [BACK] #CLEAR
->->


=== function game_toolbar()
  [button=GLOSSARY]GLOSSARY[/button]

=== function GLOSSARY()
  [title]GLOSSARY[/title]

SHOW_ is a STRING showing the SOLO results of the individual dice in a POOL
TALLY_ is prints SHOW and returns a TOTAL
NARRATE_ presents other functions (like SHOW/TALLY/TOTAL) into sentences.

ATRMNT_IMG displays INLINE IMAGES of the rolled dice with Atrament markup.