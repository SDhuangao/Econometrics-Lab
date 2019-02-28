log using 3, text replace
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机3&4"  /*for windows*/
*cd "/Volumes/HAS/大三上/中级计量经济学/老师发的/Lab/上机3&4"

*HW2_3_Fertility
clear all
use fertility
*a
reg weeksm1 morekids, r
/* Yes, 5.386996 weeks less  */
*b
/* There are omitted variables or function misspecification in the OLS model,
many things can affect the work people do, only using the kids variable is not
good. */
*c
reg morekids samesex, r
/* the coefficient is 0.0675253, the t=35.19, significant at 5%.
if the two children are of the same sex, the couple will have 6.75%
more chance to have another child.  */
*d
/* 1) relevence. samesex is correlated with morekids, as shown in c.
   2) exogeneity. samesex is probably uncorrelated with the error term
so, the variable samesex is a valid instrument for this regression. */
*e
/* F= 1238.17 >10, it's a strong instrument.  */
*f
ivreg weeksm1 (morekids = samesex), r
/* the coefficient is -6.313685, having more than 2 kids will make the monther
work 6.313685 weeks less.  */
*g
ivreg weeksm1 (morekids = samesex) agem1 black hispan othrace, r
/* 5.8 weeks less   */

log close

























