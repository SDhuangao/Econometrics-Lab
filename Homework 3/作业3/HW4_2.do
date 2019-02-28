clear all
cap log close
log using HW4_2, text replace
*HW4_2
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机5&6"
import excel us_macro_quarterly, sheet(us_macro_quarterly.xls) cellrange(A1:J229) firstrow
generate time=q(1957q1)+_n-1
format time %tq
sort time
tsset time

gen LPCECTPI = log(PCECTPI)
gen IPCEP = 400*(LPCECTPI[_n]-LPCECTPI[_n-1])

gen LCPIAUCSL = log(CPIAUCSL)
gen ICPI = 400*(LCPIAUCSL[_n]-LCPIAUCSL[_n-1])

gen y=ICPI-IPCEP
*a
sum IPCEP if tin(1963q1,2012q4)
sum ICPI if tin(1963q1,2012q4)
//mean(IPCEP) <mean(ICPI), these point estimates are consistent with the presence
//of economically significant substitution bias in the CPI

*b
sum y if tin(1963q1,2012q4)
//in the sample:y=ICPI-IPCEP
//E(y)=E(ICPI-IPCEP)=E(ICPI)-E(IPCEP), so they are equal.

*c
//in population:y=ICPI-IPCEP
//E(y)=E(ICPI-IPCEP)=E(ICPI)-E(IPCEP), so they are equal.

*d
//E(Y_t)=E(b_0+u_t)=E(b_0)+E(u_t)=b_0
//cov(u_t,u_t-1)=cov(Y_t-b_0,Y_(t-1)-b_0)=cov(Y_t,Y_(t-1))
reg y L.y, r
//_b[L1.y]=.2573233, not small. so we can think it's  serially correlated.

*e
//y mean:.5038252   se:.9674085
//a 95% confidence interval: .5038252+-.9674085  [-.4635833,1.4712337]
//m = 0.75*T^(1/3)= 4.  ,choose 4 ,rule of thumb
dis "m =" 0.75*(200^(1/3))

*f
//Not at 5%, the 95% confidence interval is [-.4635833,1.4712337]

*g
estat sbsingle
//we reject the null hypothesis of no structural break at the 1% level 
//and that the estimated break date is 1966q1.
//b is not stable at 1% level, we think b has a structral break at 1966q1


log close
