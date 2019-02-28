log using 1, text replace
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机3&4"  /*for windows*/
*cd "/Volumes/HAS/大三上/中级计量经济学/老师发的/Lab/上机3&4"
*HW2_1_JEC
use JEC
*a.
gen lnp = ln(price)
gen lnq = ln(quantity)
reg lnq lnp ice seas1-seas12, r
/* the elasticity is -.6388847, the standard error is 0.0732804*/
*b.
/*Because supply can influence the demand and the demand can also influence the
supply, it's the simultaneous causality.*/
*c
/*1) Relevence: of course ln(p) is correlated with cartel
  2) Exogeneity: cartel is unlikely to change the daily used grain people 
  always need, so cartel is uncorrelated with the error term.
  So cartel plausibly satisfies the two comditions for a valid IV.*/
*d
reg lnp cartel, r
/* F= 158.36 > 10, so it's a strong instrument.*/
*e
ivreg lnq ice seas1-seas12 (lnp = cartel), r
/* elasticity is -.8665865  standard error is 0.1338322 */
*f
/*
the elasticity is  -0.8665865
if the price elasticity is less than 1, the monopoly can charge the price to maximaze
its profit. So the cartel was charging the profit-maximizing monopoly price.
*/

log close
