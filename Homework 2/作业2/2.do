log using 2, text replace
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机3&4"  /*for windows*/
*cd "/Volumes/HAS/大三上/中级计量经济学/老师发的/Lab/上机3&4"

*HW2_2_Seatbelts
clear all
use SeatBelts
encode state, gen(state1)
*destring state, replace
*a
gen lnin = ln(income)
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnin age, r
/* the coefficient is 0.0040684, pretty samll, but the t=3.30 >0 . This regression does not suggest
seat belt use reduces fatalities. */
*b
xtset state1 year
xtreg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnin age, fe vce(cluster state1)
/* Yes, because every state has its own culture,roads,weather and state's law, there are 
some things that won't change across time in a state */
*c
xtset state1 year
xtreg fatalityrate i.year sb_useage speed65 speed70 ba08 drinkage21 lnin age, fe vce(cluster state1)
/* Yes, the results have changed. */
*d
/* the regression of (c) is most reliable, F=52.30,it's significant at 1%, 
we can use time fixed and state fixed effect to regress, it's better*/
*e
sum vmt
/* It's not large. 
the avearge of vmt is 41447.73 
(0.90-0.52)*0.37186 =0.14
0.14*41447.73 =58 people */
*f
xtset state1 year
xtreg sb_useage i.year primary secondary speed65 speed70 ba08 drinkage21 lnin age, fe vce(cluster state1)
/* primary and secondary both lead to more seat belt use. */
*g
/*
0.2055968-0.1085184 =0.0970784
0.37186*0.0970784 =0.0360996
63308*0.0360996 =23
NJ's population of 1997 is 63308
*/

log close
