
// BAND MANAGER FUNCTIONS
// VERSION 00.1
// CREATED by JON KEEVY.... free to use, no credit required
// SET UP FOR Atrament Preact UI (distributed under MIT license. Copyright (c) 2023 Serhii "techniX" Mozhaiskyi.
// https://github.com/technix/atrament-preact-ui


// ............... SKILLS AND INSTRUMENTS

=== function bandhas(x)
    ~ return x ^ band
    // VERY useful for checking if the band has eg a Negotiator.

=== function whoPlays(x)
    {
    - x == instrument(npc01):
        ~ return name(npc01)
    - x == instrument(npc02):
        ~ return name(npc02)
    - x == instrument(npc03):
        ~ return name(npc03)
    - x == instrument(npc04):
        ~ return name(npc04)
    - x == instrument(npc05):
        ~ return name(npc05)
    - else:
        no one
    }

=== function playsWhat(x)
    {
    - x == name(npc01):
        ~ return instrument(npc01)
    - x == name(npc02):
        ~ return instrument(npc02)
    - x == name(npc03):
        ~ return instrument(npc03)
    - else:
        nothing
    }

=== function whatsbusted()
    {
    - busted == condition(npc01):
        ~ return instrument(npc01)
    - busted == condition(npc02):
        ~ return instrument(npc02)
    - busted == condition(npc03):
        ~ return instrument(npc03)
    - else:
        nothing
    }

=== function whosbusted()
    {
    - busted == condition(npc01):
        ~ return name(npc01)
    - busted == condition(npc02):
        ~ return name(npc02)
    - busted == condition(npc03):
        ~ return name(npc03)
    - else:
        no one
    }

=== function whosskill(x)
    {
    - x == skill(npc01):
        ~ return name(npc01)
    - x == skill(npc02):
        ~ return name(npc02)
    - x == skill(npc03):
        ~ return name(npc03)
    - x == skill(npc04):
        ~ return name(npc04)
    - x == skill(npc05):
        ~ return name(npc05)
    - else:
        no one
    }
