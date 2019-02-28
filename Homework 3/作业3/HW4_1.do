clear all
cap log close
log using HW4_1, text replace
*HW4_1
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机5&6"
import excel us_macro_monthly, sheet(us_macro_monthly.xls) cellrange(A1:D709) firstrow

generate time=m(1955m1)+_n-1
format time %tm
sort time
tsset time

*a
gen LINDPRO=log(INDPRO)
gen ip_growth=100*(LINDPRO[_n]-LINDPRO[_n-1])
sum ip_growth
//the mean is .2350164, the se is .8828442
//the units for ip_growth is percent points per month

*b
plot _T time
//the oil price fluctuates over time, many differences are negative, so O is 0.
//the minimal of O is 0. It can't be negative.

*c
global g_T "L(0/18)._T"
newey ip_g $g_T, lag(19)
//m = 0.75T^(1/3)=7
dis "m =" 0.75*654^(1/3)

*d
test _T L._T L2._T L3._T L4._T L5._T L6._T L7._T L8._T L9._T L10._T L11._T L12._T L13._T L14._T L15._T L16._T L17._T L18._T
//the coefficients on Ot are statistically significantly different from zero.

*e
save mydata, replace
statsby _b[_T] _b[L._T] _b[L2._T] _b[L3._T] _b[L4._T] _b[L5._T] _b[L6._T] _b[L7._T] _b[L8._T] _b[L9._T] _b[L10._T] _b[L11._T] _b[L12._T] _b[L13._T] _b[L14._T] _b[L15._T] _b[L16._T] _b[L17._T] _b[L18._T]: newey ip_g $g_T, lag(19)
xpose, clear
gen n=_n
rename v1 b
save tempt1, replace
use mydata,clear
statsby _se[_T] _se[L._T] _se[L2._T] _se[L3._T] _se[L4._T] _se[L5._T] _se[L6._T] _se[L7._T] _se[L8._T] _se[L9._T] _se[L10._T] _se[L11._T] _se[L12._T] _se[L13._T] _se[L14._T] _se[L15._T] _se[L16._T] _se[L17._T] _se[L18._T]: newey ip_g $g_T, lag(19)
xpose, clear
gen n=_n
rename v1 se
merge 1:1 n using tempt1
drop _merge
save data1, replace
gen b_up=b+1.96*se
gen b_down=b-1.96*se
line b b_up b_down n ,title(dynamic multipliers) saving(dynamicmultipliers, replace)

clear all
use mydata
gen d_T=_T[_n]-_T[_n-1]
global gd_T1 "L(0/17).d_T"
newey ip_g L18._T $gd_T1, lag(19)
save mydata, replace
statsby _b[d_T] _b[L.d_T] _b[L2.d_T] _b[L3.d_T] _b[L4.d_T] _b[L5.d_T] _b[L6.d_T] _b[L7.d_T] _b[L8.d_T] _b[L9.d_T] _b[L10.d_T] _b[L11.d_T] _b[L12.d_T] _b[L13.d_T] _b[L14.d_T] _b[L15.d_T] _b[L16.d_T] _b[L17.d_T] _b[L18._T]: newey ip_g L18._T $gd_T1, lag(19)
xpose, clear
gen n=_n
rename v1 b
save tempt1, replace
use mydata,clear
statsby _se[d_T] _se[L.d_T] _se[L2.d_T] _se[L3.d_T] _se[L4.d_T] _se[L5.d_T] _se[L6.d_T] _se[L7.d_T] _se[L8.d_T] _se[L9.d_T] _se[L10.d_T] _se[L11.d_T] _se[L12.d_T] _se[L13.d_T] _se[L14.d_T] _se[L15.d_T] _se[L16.d_T] _se[L17.d_T] _se[L18._T]: newey ip_g L18._T $gd_T1, lag(19)
xpose, clear
gen n=_n
rename v1 se
merge 1:1 n using tempt1
drop _merge
save data2, replace
gen b_up=b+1.96*se
gen b_down=b-1.96*se
line b b_up b_down n ,title(Cumulative multipliers) saving(Cumulativemultipliers, replace)

//the Cumulative multipliers show that oil price has negative impact on Industrial Production.

*f
// No, it's not exogenous.  Simultaneous causality is the reason.
// the estimated multipliers shown in the graphs in (e) is not reliable, because the OLS is biased.



log close
