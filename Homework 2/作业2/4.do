log using 4, text replace
*HW2_4_Movies
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机3&4" 
use Movies
global yeardum "year2 year3 year4 year5 year6 year7 year8 year9 year10"
global monthdum "month2 month3 month4 month5 month6 month7 month8 month9 month10 month11 month12"
global holidum "h_chris h_newyr h_easter h_july4 h_mem h_labor"
global weatherdum "w_rain w_snow w_maxa w_maxb w_maxc w_mina w_minb w_minc"

*a
*(i
gen ln_assaults = ln(assaults)
reg ln_assaults $yeardum $monthdum, r
*There tend to be more assaults in month5,6,7,8,9
*(ii
gen attend = attend_v + attend_m + attend_n
reg attend  $yeardum $monthdum, r
*month5,6,7,8 have more movie attendance. Seasonality exists.
*b
reg ln_assaults attend_v attend_m attend_n $yeardum $monthdum $holidum $weatherdum, r
dis 6*(-.0031689)+(-2)*(-.0031382)+(-1)*(-.0021052)
/*(i
 viewing a strongly violent movie decrease assaults, by 0.0031689*100%=0.32%. P(t) =0.002<5%, significant at 5% level.
  (ii
 attend at strongly violent movies affect assaults differently than attendance at moderate violent movies
 also different from nonviolent movies.
  (iii
  6*(-.0031689)+(-2)*(-.0031382)+(-1)*(-.0021052)= -.0106318
  predicted effect on assaults is decreasing assaults by 1.06%
*/
*c
ivreg ln_assaults (attend_v attend_m attend_n =  pr_attend_v pr_attend_m pr_attend_n) $yeardum $monthdum $holidum $weatherdum, r
/*
viewing a strongly violent movie decrease assaults, by 0.0038738*100%=0.39%. P(t) =0.000<1%, significant at 1% level.
attend at strongly violent movies affect assaults differently than attendance at moderate violent movies  
also different from nonviolent movies. 
6*(-.0038738)+(-2)*(-.003893)+(-1)*(-.0027221)= -.0127347
predicted effect on assaults is decreasing assaults by 1.27%
*/
*d
gen att_vs = attend_v_f+attend_v_b
gen att_ms = attend_m_f+attend_m_b
gen att_ns = attend_n_f+attend_n_b
ivreg ln_assaults (attend_v attend_m attend_n = att_vs att_ms att_ns) $yeardum $monthdum $holidum $weatherdum, r
/*
viewing a strongly violent movie decrease assaults, by 0.0031738*100%=0.32%. P(t) =0.104, not significant
attend at strongly violent movies affect assaults differently than attendance at moderate violent movies  
also different from nonviolent movies. 
6*(-.0031738)+(-2)*(-.0041215)+(-1)*(-.0025823)= -.0082175 
predicted effect on assaults is decreasing assaults by 0.82%
*/
*e
ivregress 2sls ln_assaults (attend_v attend_m attend_n =  pr_attend_v attend_v_f attend_v_b pr_attend_m attend_m_f attend_m_b pr_attend_n attend_n_f attend_n_b) $yeardum $monthdum $holidum $weatherdum, r
estat overid
*f
/* viewing violent movies can decrease the violent behavior, compared to viewing non-violent movies
or not vewing movies.

*/

log close












