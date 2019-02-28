clear all
cap log close
log using HW3_2, text replace
*HW3_2
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机5&6"
import excel Stock_Returns_1931_2002, sheet(Sheet1) cellrange(A1:D865) firstrow
des
replace time=m(1931m1)+_n-1
format time %tm
sort time
tsset time

*a
reg ExReturn L.ExReturn if tin(1932m1,2002m12), r
reg ExReturn L(1/2).ExReturn if tin(1932m1,2002m12), r
reg ExReturn L(1/4).ExReturn if tin(1932m1,2002m12), r


*b
gen dln_DivYield=ln_DivYield[_n]-ln_DivYield[_n-1]
reg ExReturn L.ExReturn L.dln_DivYield if tin(1932m1,2002m12), r
reg ExReturn L(1/2).ExReturn L(1/2).dln_DivYield if tin(1932m1,2002m12), r
reg ExReturn L.ExReturn L.ln_DivYield if tin(1932m1,2002m12), r

*c
dfuller ln_DivYield, lags(2) regress
*t=-2.232, does not reject a unit root at 10%, some evidence of unit root, we find ln_DivYield is highly persistent.

*d
reg ExReturn L.ExReturn L.dln_DivYield if tin(1932m1,2002m12), r
predict ExReturn_hat

*e
gen fe=ExReturn-ExReturn_hat
sum fe
gen sfe=(fe)^2
sum sfe
gen msfe=_result(3)
dis msfe
gen rmsfe=(msfe)^(1/2)
dis "rmsfe=" rmsfe

/* in the a, Root MSE=5.1352 < rmsfe The pseudo out-of-sample forecast based on the ADL(1,1)
model with the log dividend yield does worse than forecasts in which there are no predictors.
the results in (a) through (d) suggest important changes to the conclusions reached in the boxes.
We can conclude that this lack of predictability is consistent with the strong form of the efficient markets hypothesis,
which holds that all publicly available information is incorporated into stock prices so that returns should not be predictable 
using publicly available information.
*/


log close
