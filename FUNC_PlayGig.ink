// [ ] Venue name
// [ ] Venue Size
// [ ] Venue Flavor
// [ ] Performance Quality
// [ ] Income
// [ ] Gear Deteriote
// [ ] Apply HEAT
// [ ] Random Events


=== function earnHEAT()
    ~ return LIST_VALUE(bandsound) * LIST_VALUE(fanbase_state)


=== PlaytheGig
- (Venue)
#CLEAR
There's a venue called {venues(PlaytheGig)} you can play. You'll get a round of beers and the door money.
    + [Let's rock.]
    + {bandhas(negotiator)}[Negotiate THEN rock.]
        {whosskill(negotiator)} talks the manager of {venues(PlaytheGig)} round to throwing in an extra {negotiate()} and another round of beers.

{earnHEAT()}

- (Performance)
{
- LIST_VALUE(bandsound) > 4:
    -> SoundsGood
- LIST_VALUE(bandsound) > 2: 
    -> SoundsMeh 
- LIST_VALUE(bandsound) == 2:
   -> SoundsBad
- else:
    -> SoundsAwful
}

- (SoundsGood)
    The gig rocks. You blow the roof off. The beers are cold. Life is sweet. ->GetPaid
- (SoundsMeh)
    You do OK. ->GetPaid
- (SoundsBad)
     That was embarrassing. You should rehearse. ->GetPaid
- (SoundsAwful)
     Consider another career. ->GetPaid
- (GetPaid)
    The venue manager hands you {GigIncome()}. {gig_income > 500:Not bad.|Which makes sense since there were only five dudes playing pool in there.}{promo_boost>0:Handing out flyers must have helped.}
    ~ improveLIST(band_spirits)
    ~ promo_boost = 0
--> Sleep

=== GigMiniGame
-(SetTheScene)
// [ ] 
// [ ] 
// [ ] 
-(SoundCheck)
// [ ] engineer
// [ ] gearhead

-(OpeningNumber)
// [ ] songwriter
// [ ] fronter


-(RockOut)
// [ ] 
// [ ] Heckler vs brawler

-(Solo)
// [ ] virtuoso
// [ ] 

-(BigFinish)
// [ ] firefly
// [ ] songwriter

-(Encore)
// [ ] convert fans to die-hards
// [ ] 

-(GetHeat)
// [ ] quality of performance x fans


-(GetPaid)
// [ ] number of fans x door - mishaps
// [ ] merchmaker
// [ ] negotiator

-->YesItWorks