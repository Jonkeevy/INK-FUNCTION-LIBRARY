// .................  RE

=== function skill(x)
    {
        - filter(x, skills_SR):
            ~ return filter(x, skills_SR)
        - filter(x, skills_BM):
            ~ return filter(x, skills_BM)
    }

=== function vice(x)
    {
        - filter(x, vices_SR):
            ~ return filter(x, vices_SR)
        - filter(x, vices_BM):
            ~ return filter(x, vices_BM)
    }
    
=== function instrument(x)
    ~ temp instrumentTEMP = x ^ LIST_ALL(instruments_BM)
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
    ~ return x ^ LIST_ALL(conditions_BM)


=== function generateNPC(ref x)
    ~ deal(x,npc_name)
    
    //~ draw(x,gender)
    
    //~ deal(x,skills)
    
    //~ deal(x,vices)
    
    //~ deal(x,instruments)

    //~ deal(x,conditions)


=== function generateNPC_SR(ref x)
    ~ deal(x,names_SR)
    
    ~ draw(x,gender)
    
    ~ deal(x,skills_SR)
    
    ~ deal(x,vices_SR)
    
    ~ deal(x,equipments)

    //~ deal(x,conditions)

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
    ~ auditioner_BM = ()
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

=== function fireBandMember(ref xOUT)
    {name(xOUT)} is out. Bummer for them.
    ~ band -= xOUT
    ~ xOUT = ()




=== Auditions
#CLEAR
~ generateNPC(auditioner_SR) // create an NPC with random traits pulled from a list.
One person has shown up to audition for us.
//~ sfx_instrument_riff(auditioner_SR)
Their name is <mark>{name(auditioner_SR)}</mark> and they play a <mark>{instrument(auditioner_SR)}</mark> that looks <mark>{condition(auditioner_SR)}</mark>. As a bonus they're a <mark>{skill(auditioner_SR)}</mark> but they seem <mark>{vice(auditioner_SR)}</mark>.

<br>
{Auditions<=1: // Only show block on first visit to the knot.
<br>
[info side=highlight] auditioner_SRs are randomly created with a <mark>name</mark>, an <mark>instrument</mark> which has a <mark>condition</mark>. They'll have a positive <mark>skill</mark> which provide an active of passive bonus. But they will also have a <mark>vice</mark> which increases the chance of certain random events. These events may have negative outcomes, but may also present opportunities.[/info]
<br>
}
-> Recruit

=== Recruit
Do you want them to join us?
+ [Yeh, alright.]
    {not recruitNPC(auditioner_SR):
    -> kickBandMember
    }

+ {Auditions>1} [No, vibes off.]
    Right on. Bye {name(auditioner_SR)}.
    ~ auditioner_SR = ()
-
//->check_Band_State->
//->cont_Button->
->->

=== kickBandMember
#CLEAR
You don't have space to recruit {name(auditioner_SR)}.
<i>unless</i>...
You kick someone out.
+ [CUT THE DEAD WEIGHT] ->chooseReplaceBandMember
+ [We're good as is.]
    Right on. Bye {name(auditioner_SR)}.
    ~ auditioner_SR = ()
-
-> DONE

=== chooseReplaceBandMember
#CLEAR
//->check_Band_State->
Who do you want to replace with {name(auditioner_SR)}?
+ [{name(npc01)}?]
    ~ swapBandMember(npc01,auditioner_SR)
+ [{name(npc02)}?]
    ~ swapBandMember(npc02,auditioner_SR)
+ [{name(npc03)}?]
    ~ swapBandMember(npc03,auditioner_SR)
+ [{name(npc04)}?]
    ~ swapBandMember(npc04,auditioner_SR)
+ [{name(npc05)}?]
    ~ swapBandMember(npc05,auditioner_SR)
+ [NEVERMIND!]
    Bye {name(auditioner_SR)}.
    ~ auditioner_SR = ()
-
//->check_Band_State->
-> DONE
