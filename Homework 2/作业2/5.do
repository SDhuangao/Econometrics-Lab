log using 5, text replace
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机3&4"
import excel WeakInstrument, sheet(Sheet1) cellrange(A1:C201) firstrow
*a
ivregress 2sls y (x = z), r first
/* the coefficient is 1.157732, the s.e is  0.4360587, 
95% Conf. Interval: [0.3030724, 2.012391]
*/
*b
reg x z, r
*F(1, 198) = 4.27 < 10, weak instrument
*c
ivregress 2sls y (x = z), r

/*
foreach package in ivreg2 ranktest {
capture which `package'
if _rc==111 ssc install `package'
}
ivreg2 y (x = z), r first
Anderson-Rubin Wald test           F(1,198)=       1.54     P-val=0.2154
Anderson-Rubin Wald test           Chi-sq(1)=      1.56     P-val=0.2116
F < Chi-sq(1), fail to reject the null assumption, 
*/

log close
