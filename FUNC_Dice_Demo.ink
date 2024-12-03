// >>>>>>>>>>>>>>>>> DICE FUNCTIONS for INK <<<<<<<<<<<<<<<<<
// by Jon Keevy - open license, no attribution required. Tips appreciated. 
// Here are a set of functions for DICE ROLLING in INK.
// The Test Roller Knot demostrates the systems in narrate_able dialogue.
// The functions build up from basic building blocks to more complicated and specific systems.
// We'll build single dice, dice pools, and multiple dice with modifiers.

// In addition this set up uses Atrament Preact UI to narrate_ dice faces. You'll need Atrament to use those functions ('atrament' is in the knot/function title.)

// Atrament Web UI is Copyright (c) 2023 Serhii "techniX" Mozhaiskyi. (distributed under MIT license) - find it on github.com/technix/atrament-web-ui


// >>>>>>>>> GLOSSARY <<<<<<<<<<<<<

// X is QUANTITY of dice rolled - referred to as the POOL
// Y is number of SIDES the dice have
// Z is SUCCESS THRESHOLD / DIFFICULTY RATING - the number that the dice must equal or exceed either SOLO or as a TOTAL
// ST is SUCCESS TARGET - the number of SOLO dice that must equal or exceed Z in a POOL for a GREATER SUCCESS
// M is MODIFIER - the bonus or penalty applied to the roll either SOLO or TOTAL

// POOL the dice rolled collectively.
// SOLO is the individual dice in a POOL
// TOTAL is a single combined INT value of a POOL
// SHOW_ROLLS is a STRING showing the SOLO results of the individual dice in a POOL
// TALLY is a prints SHOW_ROLLS and returns a TOTAL
// narrate_ presents other functions (like ROLL/TALLY/TOTAL) into sentences.

// ATRMNT_IMG displays INLINE IMAGES of the rolled dice.

# title: Dice Functions for Ink
# author: Jon Keevy
# theme: light
# font: System              
# scenes_align: center          
# toolbar: game_toolbar
# cover: IMAGES/D6 cute.png

// INCLUDE

// >>>>>>>>> INCLUDES <<<<<<<<<<<<
INCLUDE FUNC_Dice.ink
//INCLUDE FUNC_Dice_Demo.ink
INCLUDE FUNC_Dice_Atrament.ink

-> StartDiceDemo
===StartDiceDemo
[banner style=accent]WELCOME TO THE ROLLER INK[/banner]

[banner][img]IMAGES/D3_1ONE.png[/img] [img]IMAGES/D3_3THREE.png[/img] [img]IMAGES/D3_1ONE.png[/img] [img]IMAGES/D3_2TWO.png[/img][/banner]

+ [WHAT'S ALL THIS THEN?] -> demoROLLER
+ [ATRAMENT] ->AtramentUI->
-->StartDiceDemo

=== demoROLLER
This here is a Dice Roller.
Well, No. Actually that's a lie. This is an explainer on adding dice rolling to your Ink projects using the functions I've made.
It includes some dice rolling, but mostly it unpacks how the different functions work behind the scenes. And why I made some decisions.
If you're familiar with Ink you can probably grok what I was up to without all this. Just download the files you want.

+ [START AT THE BEGINNING] #CLEAR
    ->Intro
+ CHOOSE A TOPIC #CLEAR

-(Menu)
+ [INTRODUCTION] #CLEAR
    -> Intro
+ [ROLLING ONE DICE]  #CLEAR
    -> OneDice
+ [VARYING THE NUMBER OF SIDES] #CLEAR
    -> ManySides
+ [ROLLING MULTIPLE DICE ] #CLEAR
    -> DicePool
+ [SUM TOTALS] #CLEAR
    -> Total
+ [SHOWING EACH ROLL] #CLEAR
    -> Show
+ [SHOW AND TOTALS] #CLEAR
    ->Tally
+ [NARRATING ROLLS] #CLEAR
    ->narrate_
+ [SUCCESS] #CLEAR
    ->Success
+ [SUM TOTAL CHECK] #CLEAR
    ->SumTotalSuccess
+ [INDIVIDUAL ROLL SUCCESS] #CLEAR
    -> IndividualRollSuccess
+ [SUCCESS COUNTS] #CLEAR
    -> SuccessCounts
+ [MODIFIERS] #CLEAR
    -> Modifiers
    
-(Intro)

[banner]ONLY ONE DICE[/banner]
Here, take this ordinary 6-sided die. You know what to do!

+ [ROLL IT]

- (OneDice)
You rolled the d6. It came up {1d6()}. (Trust me.)
The basis of dice rolling is Ink's RANDOM function. It takes 2 parameters that set the range of the integer it'll return.
For a six-sided die the parameters are set to ( 1 , 6 ).
[info side=highlight]Function: 1d6() is RANDOM(1, 6)[/info]
    + [EASY, NEXT] #CLEAR
-(ManySides)
[banner]ONE DICE, MANY SIDES[/banner]
Next step we'll make the dice versatile. We want to be able to roll a dice of any shape, with any number of sides. We start with a function to return one roll of a dice with Y number of sides.
[info side=accent]Term: Y means number of sides of the dice in the pool. [/info]
How many sides do you want?

    + [One 6-sided die]
        You rolled the d6. It came up {1dY(6)}.
    + [One 10-sided die]
        You rolled the d10. It came up {1dY(10)}.
    + [One 20-sided die]
        You rolled the d20. It came up {1dY(20)}.
-
This is the foundation of all the following functions: '1dY' where Y is the upper bound of the RANDOM function.
[info side=highlight]Function: 1dY(y) = RANDOM(1, y)[/info]
    + [ONWARD] #CLEAR
- (DicePool)
[banner]DICE POOL[/banner]
Next up let's roll multiple dice - a Dice Pool. All the functions use X for the number of dice to roll and Y for the number of sides. So it's called 'XdY'
[info side=accent]Term: X means number of dice in the pool. [/info]
Rolling X number of times uses a recursive instruction to repeat the roll. 
[info side=highlight]Function: XdY(x, y)[/info]
Here, roll this dice pool of 5 seven-sided dice.
    + ROLL THEM

- (Total)
You rolled 5 seven-sided dice and...
Um...
How should the results be shown?
    + [ADD THEM UP] #CLEAR
-

[banner]SUM TOTAL[/banner]
The Sum Total of the dice pool is {total_XdY(5, 7)}. This is a 'total_' function. It calls 1dY called X times and each result is added to the ongoing total.
[info side=accent]Term: total_ means the sum of the dice pool. [/info]
[info side=highlight]Function: total_XdY(x, y)[/info]
+ BORING

- (Show)
I agree.
Sum totals are useful but dull. It's exciting to see the individual rolls of the dice pool. So let's do that again but use the 'show_' function.
    + [SHOW ME THE SHOW] #CLEAR
-
[banner]SHOW THE ROLL[/banner]
Here - 5 six-sided dice.
    + ROLL THEM
-
You rolled 5 six-sided dice and got: {show_XdY(5, 6)}. Look at all those numbers. Nice.
[info side=highlight]Function: show_XdY(x, y)[/info]
You can edit the function to have different dividers between the results. Spaces, commas, pipes, etc.
The function also needs '\<\>' - Ink's 'glue' used to close line-breaks.
If you want to show images of the roll you can do that in your game engine.
[info side=highlight]{ATRMNT_IMGshow_Xd6(5)}[/info]

For this demo I used Atrament Web UI and some basic images I made. Want to see? Or want to carry on with standard Ink first?
+ [CARRY ON WITH INK] #CLEAR
+ [SHOW ME ATRAMENT DICE] #CLEAR
->AtramentUI->
- (Tally)

[banner]TALLY HO! SHOW & TOTAL[/banner]
What we really want is to combine the total and show functions - so I use 'tally_' to show both.
Roll these 4 four-sided dice.
    + ROLL THEM
-
[info]{narrate_XdY(4, 4)}[/info]
Now we're cooking!
Understanding the tally_ function took me a while even though I made it up. (Thanks for the patient explanation from IFcoltransG on the Inkle Discord).
Tally_ function prints the individual rolls while also returning a total of the rolls. It does  two things!
This means it that when wrapped in \{...\} it prints the show_ immediately followed by the total_ in a single string. Like so: [info side=highlight]Function: tally_XdY(x, y) prints {tally_XdY(4, 4)} [/info]
Which doesn't read very well. At all.
But if the function is run with \~ and given a temp variable to hold the total, then the string of results and the total can be printed nicely.
    + [PRINT?] #CLEAR

- (narrate_)

[banner]NARRATE THE ROLL![/banner]
I'm abusing the term 'print' which actually means 'to put on the screen'. You'll notice in the Ink syntax that the full sentence presenting the tally comes from a function. Instead of calling this 'print' let's use 'narrate_'.
The purpose of narrate_ functions are to wrap up the results of other functions into a tidy NARRATIVE package. narrate_ functions are the end of the line - next stop: the player's brain. Or another narrate_ function. Speaking of which...
    + [GO ON] #CLEAR

- (Success)

[banner]SUCCESS & FAILURE[/banner]
Onward! Did your roll succeed?
    + YUP
    + NOPE
-
How do you know?
A successful roll depends on the game rules, but usually you'll need to roll equal to or above a Target Number. This can be called the Difficulty or Challenge Rating, and I used Z to represent it in the functions.
[info side=accent]Term: Z represents Target Number. [/info]
A dice pool must either beat Z with the total_ of the pool, or with solo results.
Since total_ functions are simpler let's start there. 
    + [DO I HAVE A CHOICE?] #CLEAR

- (SumTotalSuccess)

[banner]CHECKING SUCCESS[/banner]
I said this was simple and it is. Checking success is asking if the total of X dY dice is equal to or greater than Z and returning 'true' or 'false' 
I call functions that only return 'true' or 'false' 'check_' functions.
[info side=highlight]Function: check_success(roll, z) [/info]

Plus we'll include all the nice things we've already built too.
Roll 5 three-sided dice. To succeed you'll need to be equal to or greater than 10.
    + ROLL THEM
-(CheckSuccess)
[info]{narrate_XdYtotalZ(5, 3, 10)}[/info]
What this function is doing is running a tally_ to show_ the rolls and the total_ then check_success if the total_ is greater than Z. It uses that check_success to narrate_ either 'failed' or 'succeeded'.
[info side=highlight]Function: narrate_XdYtotalZ(x, y, z) [/info]
-
    + THAT WAS EASY #CLEAR
-
[banner]CHECKING POSSIBLE[/banner]
Let's add another check_. We want to make sure that success is possible.

So at the top of the narrate_ functions there's a check_ whether x multiplied by y (best_possible) is less than z.
[info side=accent]Function: check_possible(best_possible, z) [/info]
Here, roll these 3 two-sided dice. Try to beat 7.
    + IF I MUST
-
[info]{narrate_XdYtotalZ(3, 2, 7)}[/info]
It's a handy check to include in all the narate functions - but make sure it's adjusted to the right formula for best possible, you don't want to be checking total_ instead of solo results.
It's also useful to block content or choices that are impossible to succeed.
[info] + \{check_possible(best_possible, z)\} Attack the Knight[/info]
-
    + ONWARD #CLEAR
-(IndividualRollSuccess)

[banner]INDIVIDUAL SUCCESS[/banner]
Right. How about testing individual rolls in a dice pool. Do any of the rolls meet or exceed z? How many?
    + YOU TELL ME
-
Alright, I will.
[info] {narrate__solosuccessXdYonZ(10, 6, 6)}[/info] 
This is great for things such as successful number of attacks.
[info side=highlight]Function: narrate__solosuccessXdYonZ(x, y, z) [/info]
If you only need 1 roll to succeed in a pool then the total number of rolls that exceed it don't matter. The narrate_ part of the function gets a little tweak.

[info] {narrate__1successXdYonZ(10, 6, 6)}[/info] 
[info side=highlight]Function: narrate__1successXdYonZ(x, y, z) [/info]
-
    + I WANT COUNTS TO COUNT #CLEAR
- (SuccessCounts)    

[banner]SUCCESSES & MORE SUCCESSES[/banner]
A second threshold for success?! So the dice need to beat Z and there needs to be enough of them.
But I reached Z. There are no more letters to use as stand-ins!
Fine. Let's use ST for 'Success Targets' - the number of successes needed to be successful.
[info side=accent]Term: ST the total_ of solo successes needed. [/info]
Bah. You're ruining this.
    + I AM YOU
-
What a terrible thought.
Anyway. This narrate_ function is only a slight variation of the others.
[info] {narrate__solosuccessXdYonZwST(3,6,6,2)}[/info] 
[info side=highlight]Function: narrate__solosuccessXdYonZwST(x, y, z, st) [/info]
-
    + IS THAT EVERYTHING? #CLEAR
-(Modifiers)

[banner]MODIFIERS[/banner]
We need to incorporate modifiers. Bonuses or penalties to the rolls. It's a pretty common feature.
    + YOU'RE PRETTY COMMON
Rude. But true.
-
I use M to represent Modifiers. The value can be positive or negative.
[info side=accent]Term: M a value added to the total_ or solo roll. [/info]
Applying M is easy as long as the modifers are applied to the pool total, or to every roll in the pool equally.
The complicated version is applying different modifiers to individual rolls. I'm not going to make the complicated version.
    + COWARD
-
You're right - I'm afraid. Afraid of being psycho-analysed by anyone reading this.
Back on topic...
    + [PLEASE] #CLEAR
-(ModIndividual)
[banner]MODIFY EACH ROLL[/banner]
First let's apply M to each roll for individual successes.
Modifiers are narratively applied to the rolls, but mathematically there isn't a difference between adding M to each roll, or lowering the Z by M.
What this means is that M can be incorporated without changing the building block functions.
So here are 3 six-sided dice that need to beat 6, and each dice gets a +2 bonus.
+ ROLL EM!
-
[info]{narrate_XdYonZwMe(3, 6, 6, 2)}[/info]
[info side=highlight]Function: narrate_XdYonZwMe(x, y, z, m) [/info]
First let's apply M to each roll for individual successes.
Modifiers are narratively applied to the rolls, but mathematically there isn't a diffence between adding M to each roll, or lowering the Z by M.
What this means is that M can be incorporated without changing the building block functions.
So here are 3 six-sided dice that need to beat 6, and each dice gets a +2 bonus.
[info]{narrate_XdYonZwMe(3, 6, 6, 2)}[/info]
-
    + [NEXT LESSON!] #CLEAR
-(ModTotal)

[banner]MODIFY THE SUM TOTAL[/banner]
And a bonus that's only applied to the Sum Total of a pool... Easy!
Roll 2 six-sided dice to beat 12. You have a +4 bonus.

[info]{narrate_XdYonZwMt(2, 6, 12, 4)}[/info]

[info side=highlight]Function: narrate_XdYonZwMe(x, y, z, m) [/info]
-
+ IS THAT IT?
-(EndDemo)
That's it! For now.
I'll be adding more Ink resources and tutorials in the future. You can request features or topics in the comments.
I'm working on more TTRPG simulations right now, including Skill Checks and Dice Reserves.
<br>
If you found this useful, please send me a dollar via PayPal or donate on Itch. I'm in South Africa so a little goes a long way.
<br>
[info]www.paypal.com/paypalme/jonkeevy[/info]

You can find me with @jonkeevy most places. Except that one.

You can find Atrament UI at 
[info]github.com/technix/atrament-web-ui[/info]
+ [ATRAMENT] #CLEAR
    ->AtramentUI->
+ [GO TO CONTENTS] #CLEAR
-> Menu
+ [GOOD BYE]
--> END

=== AtramentUI
CLEAR #CLEAR
[banner]ATRAMENT WEB UI[/banner]
Atrament Web UI is a web wrapper for Ink made by Serhii "techniX" Mozhaiskyi - big thanks to him. I'll try not to oversell Atrament and instead show you how I use it for dice rolling. (But also this whole demo is made with Atrament and uses its built-in features like banners, toolbars, call-out boxes, and - whoops I'm going into raving about Atrament again.
[info side=highlight] github.com/technix/atrament-web-ui [/info]
<br>
You'll need Atrament and also images of each dice face. I've included small, simple sets of three-sided, six-sided, and twenty-sided dice. You can make or find your own. You could even use gifs for a bit of animation.
[info][img]IMAGES/D3_3THREE.png[/img] ... [img]IMAGES/D6_6SIX.png[/img] ... [img]IMAGES/D20_20TWENTY.png[/img][/info]
    + LET'S ROLL THEM #CLEAR
-
[banner]SHOW INLINE IMAGES[/banner]
It's pretty simple. I've used the rolling functions but added in a Switch Block.
    + WHAT'S A SWITCH BLOCK?
        It's function that substitutes ('switches') one value for another. A bit like regex.
    + I KNOW SWITCH BLOCKS
-
In this case it's switching the dice values for Atrament's inline image syntax. Which switch block we use depends on the number of sides the dice have. Unlike the text-only system you can't use XdY... you need to specify the Y to point at an image set you have. Since I included d3, d6 and d20 images we'll use those.

Here's the 'ATRMNT_IMGshow_' function:

[info side=highlight]2 three-sided dice ATRMNT_IMGshow_Xd3(5): {ATRMNT_IMGshow_Xd3(2)}[/info]
-
    + [GOTCHA, DONE HERE] #CLEAR
-
Oh come on... roll the others!
    + [ROLL 4 d6s]
    [info side=highlight]{ATRMNT_IMGshow_Xd6(4)}[/info]
    + [ROLL 5 d20s]
    [info side=highlight]{ATRMNT_IMGshow_Xd20(5)}[/info]
    + [ROLL 9 d3s]
    [info side=highlight]{ATRMNT_IMGshow_Xd3(9)}[/info]
    + [NO]
-(Leave)
Alright. Back to where you came from.
+ [BACK] #CLEAR
->->


=== function game_toolbar()
  [button=GLOSSARY]GLOSSARY[/button]

=== function GLOSSARY()
  [title]GLOSSARY[/title]

X is QUANTITY of dice rolled - also referred to as the POOL
Y is number of SIDES the dice have
Z is TARGET NUMBER - the number that the dice must equal or exceed either SOLO or as a TOTAL
ST is SUCCESS TARGET - the number of SOLO dice that must equal or exceed Z in a POOL for a GREATER SUCCESS
M is MODIFIER - the bonus or penalty applied to the roll either SOLO or TOTAL

POOL refers to the dice rolled collectively.
SOLO refers to individual dice in a POOL
TOTAL_ is a single combined INT value of a POOL
SHOW_ is a STRING showing the SOLO results of the individual dice in a POOL
TALLY_ is prints SHOW and returns a TOTAL
NARRATE_ presents other functions (like SHOW/TALLY/TOTAL) into sentences.

ATRMNT_IMG displays INLINE IMAGES of the rolled dice with Atrament markup.