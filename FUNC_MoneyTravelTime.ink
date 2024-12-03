// .............. TIME

=== function anotherDay()
    ~ days_sofar ++
    ~ days_remaining --
    ~ action_points = max_action_points
    
    
// .............. MONEY

=== function printTourFund()
    {currency} {tour_fund}
    

=== function checkSufficientFunds(x)
    ~ return x <= tour_fund


=== function GigIncome()
    ~ gig_income = RANDOM(200,1300) + promo_boost*200
    ~ tour_fund += gig_income
     {currency} {gig_income}
    
=== function LivingCosts()
    ~ temp costs = living_costs * (LIST_COUNT(band ^ LIST_ALL(names)) + 1) + RANDOM(1,99)
    {
    -checkSufficientFunds(costs):
        ~ tour_fund -= costs
        {currency} {costs}
    -else:
        ~ tour_fund = RANDOM(1,19)
        ~ band_spirits --
        almost all of your tour fund on food
    }

=== function payEach(x)
    ~ temp costs = x * LIST_COUNT(band ^ LIST_ALL(names))
    {
    -checkSufficientFunds(costs):
        ~ tour_fund -= costs
        {currency} {costs}
    -else:
        ~ return false
    }
 
=== function afford_payEach(x)
    ~ temp costs = x * LIST_COUNT(band ^ LIST_ALL(names))
    {
    -checkSufficientFunds(costs):
        ~ return true
    -else:
        ~return false
    }  

// .............. TRAVEL

=== function travel_cost(x)
    {LIST_VALUE(x) > LIST_VALUE(current_town):
    ~ return 1000*(LIST_VALUE(x) - LIST_VALUE(current_town))
    -else:
    ~ return -1000*(LIST_VALUE(x) - LIST_VALUE(current_town))
    }
    
=== function travelTo(x)
    ~ towns -= x
    ~ alter(tour_fund,-travel_cost(x))
    ~ current_town = x

=== function nextTown1()
    ~ temp next_town1 = towns(LIST_VALUE(current_town) + 1)
    ~ return next_town1

=== function nextTown2()
    ~ temp next_town2 = towns(LIST_VALUE(current_town) + 2)
    ~ return next_town2
    
=== function nextTown3()
    ~ temp next_town3 = towns(LIST_VALUE(current_town) + 3)
    ~ return next_town3
  
// >>>>>>>>>>>>>>>>>>>>>>>>>>> TRAVEL LOOP

=== HittheRoad
#CLEAR
Time to get out of {current_town} and hit the road.
-> check_Finished_Tour->
There {isAre(towns)} {article(towns)}venue{plural(towns)} you can crash in {listWithCommas(towns,"along the way")}.
// Easier way to handle concord?
--> Town_Directory

=== Town_Directory
//->check_Available_locations->
{LIST_COUNT(towns)==0:
    -> ShitFire_Fest
    }
You have {printTourFund()} right now.
Which town do you want to visit:
+ {checkSufficientFunds(travel_cost(nextTown1()))} [{nextTown1()} {currency} {travel_cost(nextTown1())}]
    ~ travelTo(nextTown1())
+ {LIST_COUNT(towns)>1 && checkSufficientFunds(travel_cost(nextTown2()))} [{nextTown2()} {currency}{travel_cost(nextTown2())}]
    ~ travelTo(nextTown2())
+ {LIST_COUNT(towns)>2 && checkSufficientFunds(travel_cost(nextTown3()))} [{nextTown3()} {currency}{travel_cost(nextTown3())}]
    ~ travelTo(nextTown3())

+ -> GetCreative
--> OntheRoad

=== OntheRoad
You drive all day and you arrive in {current_town} exhausted. You sleep in the van.
#CLEAR
-> NewDay


// >>>>>>>>>>>>>>>>>>>>>>>> 


=== function OddJob()
    ~ temp income = (odd_job_income * (LIST_COUNT(band ^ LIST_ALL(names)) + 1) + RANDOM(1,99))
    ~ tour_fund += income
    {currency} {income}

=== function negotiate()
    ~ temp income = (odd_job_income * (LIST_COUNT(band ^ LIST_ALL(names)) + 1))
    ~ tour_fund += income
    {currency} {income}

=== function PettyCrime()
    ~ temp income = (odd_job_income * (LIST_COUNT(band ^ LIST_ALL(names)) + 1) + RANDOM(100,500))
    ~ tour_fund += income
    {currency} {income}

=== function printNegotiateIncome(x)
    {currency} {negotiate()}

 
    
=== check_Finished_Tour
    {
        //-LIST_COUNT(towns) == 0:
        - not towns:
        Winner
        ->Winner
    }
->->

=== check_Broke 
{
- tour_fund < 20:
    ->GetCreative
}
->->
