clear all
cap log close
log using HW3_1, text replace
*HW3_1
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机5&6"
import excel us_macro_quarterly, sheet(us_macro_quarterly.xls) cellrange(A1:J229) firstrow
des
destring TIME, replace ignore (":")
generate time=q(1957q1)+_n-1
format time %tq
sort time
tsset time


*a
gen LPCECTPI = log(PCECTPI)
gen infl = 400*(LPCECTPI[_n]-LPCECTPI[_n-1])
des infl
*the unit of infl is percentage points per year.
line infl time if tin(1963q1,2012q4), title(inflation over time) saving(inflation, replace)
*I think Infl has a stochastic trend. It looks like random walk.


*b
corrgram inf if tin(1963q1,2012q4), noplot lags(4)
gen dinfl = infl[_n]-infl[_n-1]
line dinfl time if tin(1963q1,2012q4), title(difference of inflation over time) saving(difference_of_inflation, replace)
*dinfl changes a lot, so the graph is choppy.


*c
reg dinfl L.dinfl if tin(1963q1,2012q4), r
dis "Adjusted Rsquared = " _result(8)
*Rsquared is very small, this means knowing the change in
*inflation this quarter  can't help predict the change in inflation next quarter much.
reg dinfl L(1/2).dinfl if tin(1963q1,2012q4), r
dis "Adjusted Rsquared = " _result(8)
*Rsquared is bigger, so the AR(2) model is better than an AR(1) model
reg dinfl L.dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/2).dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/3).dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/4).dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/5).dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/6).dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/7).dinfl if tin(1963q1,2012q4), r
estat ic
reg dinfl L(1/8).dinfl if tin(1963q1,2012q4), r
estat ic
* AIC:5   BIC:2
reg dinfl L(1/2).dinfl if tin(1963q1,2012q4), r
predict dinfl_hat
* the predicted value of Infl2013:1Q is -.14086185
* the predicted level of the inflation rate in 2013:Q1 is -.14086185+1.6126633=1.4718014
dis -.14086185+1.6126633


*d
dfuller infl, lags(2) regress
* t=-2.707, rejects a unit root at 10% level but not at 5% level
dfuller infl, lags(2) trend regress
* t=-2.900, does not reject a unit root at 10% level，better.
* so the first is not preferred to the latter with trend.

dfuller infl, lags(5) regress
*t=-2.165, does not reject at 10%, this is lag the AIC prefer, and the Rsquared is bigger. maybe better than lag of 2.
*so more lags may be better, we can choose 5.

*the (i) rejects a unit root at 10% level but not at 5% level.
*failing to reject(FTR) does not mean the null is true, but we can say there is Some evidence of a unit root – not clear cut.


*e
estat sbsingle
*p_value=0.1978>0.1, can not reject the null at 10%, we think the model is stable.

*f
reg dinfl L(1/2).dinfl if tin(1963q1,2002q4), r
predict dinfl_hat1
gen fe= dinfl-dinfl_hat1 if tin(2003q1,2012q4)
sum fe
gen sfe=(fe)^2
sum sfe
gen msfe=_result(3)
dis msfe
gen rmsfe=(msfe)^(1/2)
dis "rmsfe=" rmsfe
/*the forecasts are dinfl_hat1
.2737572
-.2546307
.5577055
-.1414871
-.148019
-.264019
-.1978824
.1989463
-.1473093
.1716431
.0443869
-.6209659
.0480272
.6335815
-.1123476
-.1628754
1.114336
-.6313962
-.6797541
.386235
-.3378887
-.1551652
-.1063591
-.1089831
2.991516
.864515
-1.894148
-.9970336
-.2003172
.3763086
.5461434
-.0350702
-.4168141
-.4252429
-.3619196
.2880114
.5547899
-.0855659
.1908099
.0536658
*/
* the mean is  -.0254224!=0, so the pseudo out-of-sample forecasts is biased
*rmsfe=2.0380802
* AR(2) Root MSE = 1.1991< rmsfe, NOT consistent
* 2008's financial crisis make the inflation fall quickly in 2008q4.
 




log close
