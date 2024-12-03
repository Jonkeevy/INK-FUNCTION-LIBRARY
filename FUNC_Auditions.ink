// ................. AUDITIONS

=== function name(x)
    ~ return x ^ LIST_ALL(names)

=== function skill(x)
    ~ return x ^ LIST_ALL(skills)

=== function vice(x)
    ~ return x ^ LIST_ALL(vices)



=== function instrument(x)
    ~ temp instrumentTEMP = x ^ LIST_ALL(instruments)
        // lists don't support spaces so needs to swap out.
    {instrumentTEMP:
        - lead_guitar:
            ~ return "lead guitar"
        - rhythm_guitar:
            ~ return "rhythm guitar"
        - else:
            ~ return instrumentTEMP
    }

=== function condition(x)
    //condition of the instruments/equipment
    ~ return x ^ LIST_ALL(conditions)

=== function generateNPC(ref x)
    ~ temp random_name = LIST_RANDOM(names)
    ~ names -= random_name
    ~ x += random_name
    ~ temp random_skill = LIST_RANDOM(skills)
    ~ skills -= random_skill
    ~ x += random_skill
    ~ temp random_vice = LIST_RANDOM(vices)
    ~ vices -= random_vice
    ~ x += random_vice
    ~ temp random_instrument = LIST_RANDOM(instruments)
    ~ instruments -= random_instrument
    ~ x += random_instrument
    ~ temp random_condition = LIST_RANDOM(conditions)
    ~ x += random_condition

=== function recruitNPC(x)
    {
    -npc01 == ():
         ~ npc01 = x
    -npc02 == ():
         ~ npc02 = x
    -npc03 == ():
         ~ npc03 = x
    -npc04 == ():
         ~ npc04 = x
    -npc05 == ():
         ~ npc05 = x
     - else:
         ~ return false
    }
    
    ~ band += x
    ~ reduce(bandsound)
    ~ auditioner = ()
    ~ return true

=== function whoIS(x)
    {x == ():
    ~ return 
    -else:
    <mark>{name(x)}</mark> plays a <mark>{condition(x)} {instrument(x)}</mark>. They're a <mark>{skill(x)}</mark> but also <mark>{vice(x)}</mark>.
    }

=== function swapBandMember(ref xOUT, ref yIN)
    {name(xOUT)} is out. {name(yIN)} is in.
    ~ band -= xOUT
    ~ band += yIN
    ~ xOUT = yIN
    ~ reduce(bandsound)

=== function fireBandMember(ref xOUT)
    {name(xOUT)} is out. Bummer for them.
    ~ band -= xOUT
    ~ xOUT = ()

=== check_Band_State
{band_name} is you and {listWithCommas(name(band), "no one else. Not really a band then")}.
You sound {bandsound}.
Your drive is {band_spirits}.

{whoIS(npc01)}
{whoIS(npc02)}
{whoIS(npc03)}
{whoIS(npc04)}
{whoIS(npc05)}

->->


=== Auditions
#CLEAR
~ generateNPC(auditioner) // create an NPC with random traits pulled from a list.
One person has shown up to audition for {band_name}.
~ sfx_instrument_riff(auditioner)
Their name is <mark>{name(auditioner)}</mark> and they play a <mark>{instrument(auditioner)}</mark> that looks <mark>{condition(auditioner)}</mark>. As a bonus they're a <mark>{skill(auditioner)}</mark> but they seem <mark>{vice(auditioner)}</mark>.

<br>
{Auditions<=1: // Only show block on first visit to the knot.
<br>
[info side=highlight] Auditioners are randomly created with a <mark>name</mark>, an <mark>instrument</mark> which has a <mark>condition</mark>. They'll have a positive <mark>skill</mark> which provide an active of passive bonus. But they will also have a <mark>vice</mark> which increases the chance of certain random events. These events may have negative outcomes, but may also present opportunities.[/info]
<br>
}
-> Recruit

=== Recruit
Do you want them to join {band_name}?
+ [Yeh, alright.]
    {not recruitNPC(auditioner):
    -> kickBandMember
    }

+ {Auditions>1} [No, vibes off.]
    Right on. Bye {name(auditioner)}.
    ~ auditioner = ()
-
->check_Band_State->
->cont_Button->
->->

=== kickBandMember
#CLEAR
You don't have space to recruit {name(auditioner)}.
<i>unless</i>...
You kick someone out.
+ [CUT THE DEAD WEIGHT] ->chooseReplaceBandMember
+ [{band_name} is good as it is.]
    Right on. Bye {name(auditioner)}.
    ~ auditioner = ()
-
-> YesItWorks

=== chooseReplaceBandMember
#CLEAR
->check_Band_State->
Who do you want to replace with {name(auditioner)}?
+ [{name(npc01)}?]
    ~ swapBandMember(npc01,auditioner)
+ [{name(npc02)}?]
    ~ swapBandMember(npc02,auditioner)
+ [{name(npc03)}?]
    ~ swapBandMember(npc03,auditioner)
+ [{name(npc04)}?]
    ~ swapBandMember(npc04,auditioner)
+ [{name(npc05)}?]
    ~ swapBandMember(npc05,auditioner)
+ [NEVERMIND!]
    Bye {name(auditioner)}.
    ~ auditioner = ()
-
->check_Band_State->
-> SpendTime