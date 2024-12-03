// >>>>>>>>>>>>>>>>> DICE FUNCTIONS for INK <<<<<<<<<<<<<<<<<
// by Jon Keevy - open license, no attribution required. Tips appreciated. 
// Here are a set of functions for DICE ROLLING in INK.
// FUNC_Dice_Demo.ink file demostrates the systems in narrate_able dialogue.
// The functions build up from basic building blocks to more complicated and specific systems.
// The functions cover single dice, dice pools, and multiple dice with modifiers.
// FUNC_Dice_Demo.ink uses Atrament Web UI to show images of dice faces. You'll need Atrament to use those functions 'ATRMNT_IMG' is in the function title.

// Atrament Web UI is Copyright (c) 2023 Serhii "techniX" Mozhaiskyi. (distributed under MIT license) - find it on github.com/technix/atrament-web-ui


// >>>>>>>>> GLOSSARY <<<<<<<<<<<<<

// X is QUANTITY of dice rolled - referred to as the POOL
// Y is number of SIDES the dice have
// Z is SUCCESS THRESHOLD / DIFFICULTY RATING - the number that the dice must equal or exceed either SOLO or as a total
// ST is SUCCESS TARGET - the number of SOLO dice that must equal or exceed Z in a POOL for a GREATER SUCCESS
// M is MODIFIER - the bonus or penalty applied to the roll either SOLO or total

// POOL is the dice rolled collectively.
// SOLO is the individual dice in a POOL
// total is a single combined INT value of a POOL
// SHOW_ROLLS is a STRING showing the SOLO results of the individual dice in a POOL
// TALLY is a prints SHOW_ROLLS and returns a total
// narrate_ presents other functions (like ROLL/TALLY/total) into sentences.

// ATRMNT_IMG displays INLINE IMAGES of the rolled dice.


// <<<<<<<<<<<<<< BASIC DICE FUNCTIONS >>>>>>>>>>>>>>

=== function 1dY(y)
    ~ return RANDOM(1, y)

=== function 1d6()
    ~ return 1dY(6)
    
=== function total_XdY(x, y)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = 1dY(y)
    ~ temp roll2 = total_XdY(x-1,y)
    ~ return roll1 + roll2

=== function show_XdY(x, y)
    { x > 0:
        ~ temp roll1 = 1dY(y)
        {roll1} <>
        ~ show_XdY(x-1,y)
    }

=== function tally_XdY(x, y)
    {x:
        -0:
            ~ return 0
        -1:
            ~ temp roll1 = 1dY(y)
            ~ temp roll2 = tally_XdY(x-1,y)
            {roll1}
            ~ return roll1 + roll2
        -else:
            ~ temp roll3 = 1dY(y)
            ~ temp roll4 = tally_XdY(x-1,y)
           <>, {roll3}
            ~ return roll4 + roll3 
    }


// <<<<<<<<<<<<<< BASIC CHECKS >>>>>>>>>>>>>

=== function check_success(rolltotal, z)
    {
    -rolltotal >= z:
        ~ return 1
    -else:
        ~return 0
    }

=== function check_possible(best_possible, z)
    {best_possible < z:
        ~ return false
    - else:
        ~ return true
    }

// <<<<<<<<<<<<<< NARRATE >>>>>>>>>>>>>>


=== function narrate_XdY(x, y)
    You roll <>
    ~ temp total = tally_XdY(x, y) 
    <> and the total is {total}.

=== function narrate_XdYtotalZ(x, y, z)
    {check_possible(x*y, z):
    You rolled <>
    ~ temp total = tally_XdY(x, y) 
    <> and the total is {total} - 
    <> {check_success(total,z): you succeeded!|you failed.}
    
    -else:
        This roll is impossible. 
        ~ return
    }


=== function tally_solosuccessXdYonZ(x, y, z)
    {x:
        -0:
            ~ return 0
        -1:
            ~ temp roll1 = 1dY(y)
            ~ temp wins2 = tally_solosuccessXdYonZ(x-1,y,z)
            {roll1}
            ~ temp wins1 = check_success(roll1,z)
            ~ return wins1 + wins2

        -else:
            ~ temp roll3 = 1dY(y)
            ~ temp wins4 = tally_solosuccessXdYonZ(x-1,y,z)
           <>, {roll3}
            ~ temp wins3 = check_success(roll3,z)
            ~ return wins4 + wins3
    }

=== function narrate__solosuccessXdYonZ(x, y, z)
    {check_possible(y, z):
    You rolled <>
    ~ temp total = tally_solosuccessXdYonZ(x, y, z) 
    <> ...{total>0:That's {total} success{total>1:es}.|No successful rolls. You failed.}
    -else:
    This roll is impossible. 
        ~ return
    }
    
=== function narrate_XdYonZwMe(x,y, z, m)
    {y + m < z:
    
        This roll is impossible. 
        ~ return
    }
    You rolled <>
    ~ temp total = tally_solosuccessXdYonZ(x, y, z - m) 
    <> ...{total>0:That's {total} success{total>1:es}.|No successful rolls. You failed.}


=== function narrate__1successXdYonZ(x, y, z)
    {y < z:
    
        This roll is impossible. 
        ~ return
    }
    You rolled <>
    ~ temp total = tally_solosuccessXdYonZ(x, y, z) 
    <> ...{total>0:That's a success!|No successful rolls. You failed.}

=== function narrate__solosuccessXdYonZwST(x, y, z, st)
    {y < z or x < st:
        This roll is impossible. 
        ~ return
    }
    You rolled <>
    ~ temp total = tally_solosuccessXdYonZ(x, y, z) 
    <>. You need {st} successes. You got {total} success{total>1:es}, which is{total>=st: enough! Congratulations!|n't enough to succeed. You failed.}

// <<<<<<<<<<<<<< MODIFIERS >>>>>>>>>>>>>>

=== function 1dYwMod(y, m)
    ~ temp roll = 1dY(y) + m
    ~ return roll

=== function show_XdYwMod(x, y, m)
    { x > 0:
        ~ temp roll1 = 1dY(y) + m
        {roll1} <>
        ~ show_XdYwMod(x-1,y,m)
    }

=== function total_XdYwMod(x, y, m)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = 1dY(y) + m
    ~ temp roll2 = total_XdYwMod(x-1, y, m)
    ~ return roll1 + roll2

=== function tally_XdYwMod(x, y, m)
    {x == 0: 
        ~ return 0
    }
        
    ~ temp roll1 = 1dY(y) + m
    ~ temp roll2 = tally_XdYwMod(x-1, y, m)
    <> {roll1} <U+0020> //unicode whitespace character
    ~ return roll1 + roll2  


=== function narrate_XdYonZwMt(x, y, z, m)
    {x*y+m < z:
    
        This roll is impossible. 
        ~ return
    }
    
    You rolled <>
    ~ temp total = tally_XdY(x, y) 
    <> and the total is {total} +{m} = {total+m}... 
    <> {check_success(total+m,z): you succeeded!|you failed.}
