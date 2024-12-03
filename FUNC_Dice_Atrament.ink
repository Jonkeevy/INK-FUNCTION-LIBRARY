// >>>>>>>>>>>>>>>>> DICE FUNCTIONS for INK <<<<<<<<<<<<<<<<<
// by Jon Keevy - open license, no attribution required. Tips appreciated. 
// Here are a set of functions for DICE ROLLING in INK.
// The Test Roller Knot demostrates the systems in narrateable dialogue.
// The functions build up from basic building blocks to more complicated and specific systems.
// We'll build single dice, dice pools, and multiple dice with modifiers.

// In addition this set up uses Atrament Preact UI to narrate dice faces. You'll need Atrament to use those functions ('atrament' is in the knot/function title.)

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
// NARRATE presents other functions (like ROLL/TALLY/TOTAL) into sentences.

// ATRMNT_IMG displays INLINE IMAGES of the rolled dice.
// <<<<<<<<<<<<<< D6 POOL IMAGE ROLLER >>>>>>>>>>>>>>


=== function ATRMNT_IMGshow_Xd3(x)
    { x > 0:
        ~ temp roll1 = 1dY(3)
        ~ ATRMNT_IMGshow_d3( roll1 )
        ~ ATRMNT_IMGshow_Xd3(x-1)
    -else:
        ~return
    }

=== function ATRMNT_IMGtally_Xd3(x)
    {x:
        -0:
            ~ return 0
        -1:
            ~ temp roll1 = 1dY(3)
            ~ temp roll2 = ATRMNT_IMGtally_Xd3(x-1)
            ~ ATRMNT_IMGshow_d3(roll1)
            ~ return roll1 + roll2
        -else:
            ~ temp roll3 = 1dY(3)
            ~ temp roll4 = ATRMNT_IMGtally_Xd3(x-1)
           <> {ATRMNT_IMGshow_d3(roll3)}
            ~ return roll4 + roll3 
    }

=== function ATRMNT_IMGshow_d3(roll)
{ roll:
- 1:     [img]IMAGES/D3_1ONE.png[/img] <>
- 2:     [img]IMAGES/D3_2TWO.png[/img] <>
- 3:     [img]IMAGES/D3_3THREE.png[/img] <>
- else:  not a d3.
}

=== function ATRMNT_IMGshow_Xd6(x)
    { x > 0:
        ~ temp roll1 = 1dY(6)
        ~ ATRMNT_IMGshow_d6( roll1 )
        ~ ATRMNT_IMGshow_Xd6(x-1)
    -else:
        ~return
    }

=== function ATRMNT_IMGtally_Xd6(x)
    {x:
        -0:
            ~ return 0
        -1:
            ~ temp roll1 = 1dY(6)
            ~ temp roll2 = ATRMNT_IMGtally_Xd6(x-1)
            ~ ATRMNT_IMGshow_d6(roll1)
            ~ return roll1 + roll2
        -else:
            ~ temp roll3 = 1dY(6)
            ~ temp roll4 = ATRMNT_IMGtally_Xd6(x-1)
           <> {ATRMNT_IMGshow_d6(roll3)}
            ~ return roll4 + roll3 
    }

=== function ATRMNT_IMGshow_d6(roll)
{ roll:
- 1:     [img]IMAGES/D6_1ONE.png[/img] <>
- 2:     [img]IMAGES/D6_2TWO.png[/img] <>
- 3:     [img]IMAGES/D6_3THREE.png[/img] <>
- 4:     [img]IMAGES/D6_4FOUR.png[/img] <>
- 5:     [img]IMAGES/D6_5FIVE.png[/img] <>
- 6:     [img]IMAGES/D6_6SIX.png[/img] <>
- else:  not a d6.
}

=== function ATRMNT_IMGshow_Xd20(x)
    { x > 0:
        ~ temp roll1 = 1dY(6)
        ~ ATRMNT_IMGshow_d20( roll1 )
        ~ ATRMNT_IMGshow_Xd20(x-1)
    -else:
        
        ~return
    }

=== function ATRMNT_IMGtally_Xd20(x)
    {x:
        -0:
            ~ return 0
        -1:
            ~ temp roll1 = 1dY(20)
            ~ temp roll2 = ATRMNT_IMGtally_Xd20(x-1)
            ~ ATRMNT_IMGshow_d20(roll1)
            ~ return roll1 + roll2
        -else:
            ~ temp roll3 = 1dY(20)
            ~ temp roll4 = ATRMNT_IMGtally_Xd20(x-1)
           <> {ATRMNT_IMGshow_d20(roll3)}
            ~ return roll4 + roll3 
    }

=== function ATRMNT_IMGshow_d20(roll)
{ roll:
- 1:     [img]IMAGES/D20_1ONE.png[/img] <>
- 2:     [img]IMAGES/D20_2TWO.png[/img] <>
- 3:     [img]IMAGES/D20_3THREE.png[/img] <>
- 4:     [img]IMAGES/D20_4FOUR.png[/img] <>
- 5:     [img]IMAGES/D20_5FIVE.png[/img] <>
- 6:     [img]IMAGES/D20_6SIX.png[/img] <>
- 7:     [img]IMAGES/D20_7SEVEN.png[/img] <>
- 8:     [img]IMAGES/D20_8EIGHT.png[/img] <>
- 9:     [img]IMAGES/D20_9NINE.png[/img] <>
- 10:     [img]IMAGES/D20_10TEN.png[/img] <>
- 11:     [img]IMAGES/D20_11ELEVEN.png[/img] <>
- 12:     [img]IMAGES/D20_12TWELVE.png[/img] <>
- 13:     [img]IMAGES/D20_13THIRTEEN.png[/img] <>
- 14:     [img]IMAGES/D20_14FOURTEEN.png[/img] <>
- 15:     [img]IMAGES/D20_15FIFTEEN.png[/img] <>
- 16:     [img]IMAGES/D20_16SIXTEEN.png[/img] <>
- 17:     [img]IMAGES/D20_17SEVENTEEN.png[/img] <>
- 18:     [img]IMAGES/D20_18EIGHTEEN.png[/img] <>
- 19:     [img]IMAGES/D20_19NINETEEN.png[/img] <>
- 20:     [img]IMAGES/D20_20TWENTY.png[/img] <>
- else:  not a D20.
}
