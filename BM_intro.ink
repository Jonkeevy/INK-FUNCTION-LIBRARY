
// BAND MANAGER GAME
// VERSION 00.1
// CREATED by JON KEEVY.... free to use, no credit required
// SET UP FOR Atrament Preact UI (distributed under MIT license. Copyright (c) 2023 Serhii "techniX" Mozhaiskyi.

/*

    This template is themed around a band going on tour. The player is the band manager and a performer. They must recruit bandmates and crew, invest in equipment, drive to the next stop on the tour - all while making enough money to keep going.
    
    Fail states: No money for fuel, no band, van breaks down.
    
    This template is a for an narrative game with mostly static NPCS. It assumes the player is going between different characters and locations. The missions can be trades, messages, investigations, etc.
    
    NPCs can be moved to new locations, or gathered for special scenes.
    Most conversations assume the Player is speaking with one NPC, but adding a companion won't take too much tweaking.
    

*/



// >>>>>>>>>>>>>>>>>>>>>>>>>>> GAME STARTS HERE!!!!!!
=== Introduction
#CLEAR
<br>

Music isn't a job - it's a life. And <b>you</b> live it. When it gets hard on the road, you get <b>harder</b>.
You'll sleep on floors, you'll survive on beers, you'll steal petrol to keep going.
That's music.
Sometimes you have to start over, build everything again. You know what I mean.
That's music too.

You've got drive, you've got talent and you've got a goal!

+ [I do?]
-
->countDown->


-
The craziest damn festival in the country. No one knows who organises it. No one controls the line up. If you're HOT you're ON - and you'd better ROCK.
To make it you're going to need a band. Something more than a family. Unless maybe one of those of old Greek families. The ones were everybody's fucking and fighting all the time. And smiting mortals. Doing crazy shit. You know.
Right. I've gone off. Back to ShitFire Fest.
<br>
<center><b>Are you going for it?</>
->cont_Button->
- (DayOne)
#CLEAR
~ showToolbar = true
You're in your home town, {current_town}. Where you've been crashing on your dad's fold-out while you save enough money to buy a van. Why do you need a van? To get out of {current_town}, obviously.
But specifically you need a van so you can tour your band. 
-> NameYourBand->
If you build up enough <mark>HEAT</mark> you'll earn a spot on the line up at ShitFire Festival. Before you hit the road {band_name} needs another person. Otherwise you'll be a solo act and this game is called BAND manager. Not <mark>lonely sad boy guitar stimulator</mark>.
Let's say you've already put up flyers for auditions.
->cont_Button->
-->Auditions->
#CLEAR
Get a good night's sleep. Tomorrow you leave {current_town} and head toward glory. Or failure. Whatever. Wherever. The important thing is that you rock all the way there.
+ [🤘 END THE DAY 🤘]
-
~ anotherDay()
#CLEAR
Rise and rock.
-> HittheRoad

// >>>>>>>>>>>>>>>>>>>>>>>>>>> ONE TIME EVENTS

=== NameYourBand
By the way, what's your band called?

    + [Honey Badger]
        ~ band_name = "Honey Badger"
    + [Pure Filth Machine]
        ~ band_name = "Pure Filth Machine"
    + [Seagull Belly Rubs]
        ~ band_name = "Seagull Belly Rubs"
    + I don't like any of these.
        --(input_name)
        Think you can do better?
        [input var=band_name type=text]
        ++ [FOR SURE I CAN]
        
-
{band_name}... sounds cool.
    + [YEAH IT DOES]
    + [BETTER IDEA] ->input_name
-
->->


// >>>>>>>>>>>>>>>>>>>>>>>>>>> CORE LOOP EVENTS
=== NewDay
#CLEAR
Rise and ROCK.
~ anotherDay()
-> check_Broke ->
->countDown->
A new day in {current_town}.
{NewDay<2:
[info side=highlight]A new day refreshes your <mark>Action Point</mark> and offers you the opportunity to <mark>Do Stuff</mark> - like earn money, relax, and importantly <mark>Play Gigs</mark>. The other way to send the day is to <mark>Hit the Road</> and go to a new town, and one step closer to <mark>ShitFire Fest</mark>[/info]
}
You spent {LivingCosts()} on living costs yesterday, which leaves {printTourFund()}.
{NewDay<2:
[info side=highlight]The more people in the band, the higher your living costs.[/info]
}
+ [Do Stuff!] -> SpendTime
+ [Hit the Road] -> HittheRoad

=== SpendTime
#CLEAR
How do you want to spend your time?
{show_SpendTime:
[info side=highlight]Every activity costs an <mark>Action Point</mark>, except <mark>Play Gig</mark> which is free, but <mark>ends the day</mark>.[/info]
~ show_SpendTime = false
}
//+ {action_points >= 1}[Band Meeting]
    //~ action_points --
    //No Content here.
+ {action_points >= 1}[Audition]
    ~ action_points --
    -> Auditions ->
+ {action_points >= 1}[Rehearse]
    ~ action_points --
    -> Rehearse ->
+ {action_points >= 1}[Relax]
    ~ action_points --
    You relax and your spirits are now {improveLIST(band_spirits)}. Which is better than they were before.
+ {action_points >= 1}[Promote]
    ~ action_points --
    ~ alter(promo_boost,1)
    You hand out some flyers. Feels like littering. Whatever. Maybe it'll bring more people to the show.
+ {action_points >= 1}[Odd Job]
    ~ action_points --
    ~ reduce(band_spirits)
    You pick up a little work and make R {OddJob()}. But you've lost some of your drive.
+ [Play Gig]
    ~ action_points = 0
    -> PlaytheGig
+ {action_points <= 0}[Sleep]
    -> Sleep
--> SpendTime


=== Rehearse
#CLEAR
{band_name} get together and jam for a couple of hours. By the end you sound {improveLIST(bandsound)}. 
->->



=== Sleep
#CLEAR
That's the end of the day. Where will you sleep?
+ The van[, free.] isn't comfortable but it's free.
    //~ reduce(band_spirits)
+ A fan['s place, free.] offers to put you up on their floor. You'll fight over who gets the couch but hey - it's free. 
+ {afford_payEach(100)}A hostel[, {currency}100 each.] is affordable and you share a dorm room with some randos.
    ~ payEach(100)
+ {afford_payEach(500)}A hotel[, {currency}500 each.] is expensive. But you deserve a good night sleep. 
    ~ payEach(500)
    ~ improveLIST(band_spirits)
-
-> NewDay





// >>>>>>>>>>>>>>>>>>>>>>>>>>> DESPERATE EVENTS

=== GetCreative
Out of money. Do a crime, sell gear, etc. This bit's not finished so uh - if you want to keep going 'succeed' will add {currency}1000 to the tour fund.
+ [Succeed]
    ~ alter(tour_fund, 1000)
    -> NewDay
+ [Fail]
    You don't have enough money to keep going.-> GameOver

// >>>>>>>>>>>>>>>>>>>>>>>>>>> RANDOM EVENTS


// >>>>>>>>>>>>>>>>>>>>>>>>>>> END STATE EVENTS



=== ShitFire_Fest
#CLEAR
Holy ShitFire! You made it to the fest!
{bandsound > 4: {band_name} plays a killer set. You win over the cynical crowd and become GODS! -> Winner|But since {band_name} sounds {bandsound} it was a waste of time and money. ->GameOver}
-> Winner

=== Winner
That's the end of the game... YOU WON!
Hope you had fun. This game is under development.

Rock on.
-> DONE

=== GameOver
Game Over, you lose.
--> DONE

=== YesItWorks
Yes, it works.
-> DONE
