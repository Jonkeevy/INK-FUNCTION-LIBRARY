
// BAND MANAGER VARIABLES
// VERSION 00.1
// CREATED by JON KEEVY.... free to use, no credit required
// SET UP FOR Atrament Preact UI (distributed under MIT license. Copyright (c) 2023 Serhii "techniX" Mozhaiskyi.

// ............ LISTS .......................
// Ink Lists are funky, it took me a bit to figure out how NOT to use them. They don't work exactly like things called lists in any other language. The documentation attempts to explain Lists in digestible mouthfuls, but only gives the clear summary at the end of the chapter. So if you want to get you head around Lists, start at the end and then go to the beginning.

//LIST mission_States = unknown, active, completed, declined

//LIST gig_states = performed, booked, cancelled

LIST towns = Nerensfontein, (Dopville), (Reksburg), (Qumbula), (Elizabethkop), (Hogsback), (Pielberg), (eBabalas)

LIST venues = Pit, Crowbar, Fumbles, Blackety, Highballer, Spitoon, Skelms, Grinder, Anus, Arena, Coxwain, Trauma, Leftfield, Killager, BoneGarden // Better as an Alternative? 
//LIST locations = van, garage, bar, loft, warehouse, hotel // Better as an Alternative?

LIST fanbase_state = (crickets), couple, dozen, cult, hundreds, thousands 
// a couple of fans, dozens, hundreds, thousands

=== function printFanbase()
    Your audience is 
    {LIST_VALUE(fanbase_state):
        - 1:
            <> {~a few alcoholic crickets|one old lady chainsmoking marlies and jerking off the one-armed-bandit}.
        - 2:
            <> a few teenage dirtbags
        - 3:
            dozen
        - 4:
            cult
        - 5:
            hundreds
        - 6:
            thousands
    }


LIST band_spirits = defeated, despairing, disappointed, down, fine, (optimistic), energised, psyched, godlike
LIST bandsound = (bad), meh, OK, alright, tight, hardcore

LIST names = nobody, (Alyx), (Baracuda), (Cassandra), (Damocles), (Eks), (Fred), (Gymmie), (Harricot), (Indica), (Jojo), (L), (Khanya), (Mandisi)

LIST instruments = none, (lead_guitar), (drumkit), (bass), (synth), (saw), (keyboard), (violin), (bassoon), (ax), (rhythm_guitar)

LIST conditions = busted, (fragile), (OK), (robust), (hardcore)

LIST skills = (merchmaker), (gearhead), (mechanic), (negotiator), (songwriter), (fronter), (hustler), (looker), (grip), (engineer), (firefly), (brawler), (photographer), (activist), (virtuoso)

LIST vices = (sloppy), (aggro), (horny), (greedy), (unreliable), (apathetic), (sleepy), (clumsy), (dishonest), (impulsive), (selfish), (sus) 


VAR band = ()
VAR npc01 = ()
VAR npc02 = ()
VAR npc03 = ()
VAR npc04 = ()
VAR npc05 = ()

VAR auditioner = ()

VAR recruited = 0

// ............ CONSTANTS ..................
CONST living_costs = 55  //multiplier to adjust
CONST odd_job_income = 125 //multiplier to adjust
CONST max_action_points = 5
CONST day_limit = 20 


// ............ VARIABLES ..................
// VAR mission_one_status = unknown
// VAR mission_two_status = unknown
// VAR next_gig = booked

VAR current_town = Nerensfontein
VAR band_name = "Nameless"

//VAR fan_base = (fanbase_state.none)
VAR heat = 1.0
VAR tour_fund = 1500
VAR gig_income = 0

VAR currency = "R" // localise for your setting

VAR action_points = max_action_points
VAR days_sofar = 0
VAR days_remaining = day_limit

VAR promo_boost = 0

VAR printAlts = true

VAR show_SpendTime = true
