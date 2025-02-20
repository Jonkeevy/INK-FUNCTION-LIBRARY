// ............ NAME FUNCTIONS .........
// VERSION 00.1
// CREATED by JON KEEVY.... free to use, no credit required (tipping appreciated & collaborations encouraged)
// freelancer@jonkeevy.com


// <<<<<<<<<<<<<<<<<<<<<< LISTS of NAMES, ONSETS, MIDSYLLS & CODAS >>>>>>>>>>>>>>>>>>>>

LIST Name_genericMale = (Allen), (Bob), (Chris), (Dean), (Evan)

LIST npc_name = nobody, (Alfred), (Bertie), (Caryn), (Debora)

LIST Onset_Normie = (Ag), (Al), (Brit), (Chad), (Chris), (Dor), (Ed), (Eli), (Fran), (Gar), (Har), (Jac), (Jen), (Jes), (Jon), (Jud), (Kath), (Kel), (Laur), (Meg), (Pat), (Rich), (Rob), (Rus), (Sam)

LIST Coda_Normie = (alie), (andy), (antha), (ard), (arella), (ary), (athan), (beth), (don), (ela), (ella), (emy), (ert), (eth), (icia), (ifer), (ily), (ina), (ison), (jamin), (las), (lyn), (ney), (old)

LIST Onset_Pirate = (Blue), (Red), (Crimson), (Golden), (Grey), (Mist), (Steel), (Dawn), (Gore), (Sharp), (Blood), (Quick), (Lost), (Dead), (Hanged), (Black), (Shark), (Grog), (Devil), (Bloody), (Silver), (Dread), (Dark), (Iron)

LIST Coda_Pirate = (bringer), (flag), (wave), (blade), (beard), (fire), (stone), (hand), (wind), (burn), (maiden), (water), (crest), (bait), (shore), (hook), (flayer), (eye), (storm), (finger), (cannon), (anchor), (sail), (chain), (keel)

LIST Onset_Hobbit = (Brandy), (Wheat), (Chumble), (Baggon), (Butter), (Broad), (Green), (Long), (Old), (Odd), (Hay), (Dandy), (Sweet), (Muck), (Barley), (Summer), (Elder)

LIST Coda_Hobbit = (foot), (shire), (soak), (shank), (loft), (den), (wine), (ford), (flower), (croft), (farm), (milk), (thorn), (river), (ridge), (water), (field), (acre), (tree), (winter), (mudder), (orchard), (hollow)

LIST Onset_Demonic = (Dem), (Or), (Kra), (Behe), (Ye), (Torm), (Rie), (Aze)

LIST Midsyll_Demonic = (ng), (ik), (yek), (roth), (och), (ra), (or), (gor)

LIST Coda_Demonic = (ul), (el), (eth), (oth), (iel), (iziel), (on), (or)

// <<<<<<<<<<<<<<<<<<<<<< FUNCTIONS FOR NAMES >>>>>>>>>>>>>>>>>>>>>

// These functions use the ESSENTIAL LIST FUNCTIONS 

=== function name(x)
    {
    -filter(x, names_SR):
        ~ return filter(x, names_SR)
    -filter(x, names_BM):
        ~ return filter(x, names_BM)
    -filter(x, npc_name):
        ~ return filter(x, npc_name)
    -filter(x, Name_genericMale):
        ~ return filter(x, Name_genericMale)
    - else:
        ~ return longname(x)
        // This uses long name as a fallback - so if a character doesn't have a "name" but does have a longname the function will return that.
    }

=== function longname(x)
    ~ temp onset_var = filter_onset(x)
    ~ temp midsyll_var = filter_midsyll(x)
    ~ temp coda_var = filter_coda(x)
    ~ return "{onset_var}{midsyll_var}{coda_var}"

=== function filter_onset(x)
    {
    -filter(x, Onset_Pirate):
        ~ return filter(x, Onset_Pirate)
        
    -filter(x, Onset_Normie):
        ~ return filter(x, Onset_Normie)

    -filter(x, Onset_Hobbit):
        ~ return filter(x, Onset_Normie)        

    -filter(x, Onset_Demonic):
        ~ return filter(x, Onset_Demonic)        
    }
    
=== function filter_midsyll(x)
    {
    -filter(x, Midsyll_Demonic):
        ~ return filter(x, Midsyll_Demonic)
    }

=== function filter_coda(x)
    {
    -filter(x, Coda_Pirate):
        ~ return filter(x, Coda_Pirate)
        
    -filter(x, Coda_Normie):
        ~ return filter(x, Coda_Normie)
        
    -filter(x, Coda_Normie):
        ~ return filter(x, Coda_Hobbit)
        
    -filter(x, Coda_Demonic):
        ~ return filter(x, Coda_Demonic)
    }

=== function draw_OnsetCoda(ref var, onset_list, coda_list)
    ~ draw(var, onset_list)
    ~ draw(var, coda_list)

=== function draw_OnsetMidsyllCoda(ref var, onset_list, midsyll_list, coda_list)
    ~ draw(var, onset_list)
    ~ draw(var, midsyll_list)
    ~ draw(var, coda_list)

=== function deal_OnsetCoda(ref var, onset_list, coda_list)
    ~ deal(var, onset_list)
    ~ deal(var, coda_list)
    
=== function deal_OnsetMidsyllCoda(ref var, onset_list, midsyll_list, coda_list)
    ~ deal(var, onset_list)
    ~ deal(var, midsyll_list)
    ~ deal(var, coda_list)

=== function recycle_OnsetCoda(ref var, onset_list, coda_list)
    ~ recycle(var, onset_list)
    ~ recycle(var, coda_list)

=== function discard_name(ref var)
    ~ discard(var, npc_name)
    ~ discard(var, Name_genericMale)

=== function discard_longname(ref var)
    ~ discard_onset(var)
    ~ discard_coda(var)
    ~ discard_midsyll(var)

=== function discard_onset(ref var)
    ~ discard(var, Onset_Pirate)
    ~ discard(var, Onset_Normie)
    ~ discard(var, Onset_Normie)
    
=== function discard_coda(ref var)
    ~ discard(var, Coda_Pirate)
    ~ discard(var, Coda_Normie)
    ~ discard(var, Coda_Normie)

=== function discard_midsyll(ref var)
    ~ discard(var, Midsyll_Demonic)
