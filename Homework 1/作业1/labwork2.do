log using labwork2, replace

clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\作业1"
use fatality
keep state year beertax mrall
gen mrallp = mrall*10000

reg mrallp beertax if year == 1982, r
predict t1
twoway scatter mrallp t1 beertax if year == 1982, s(o i) c(. 1) name(first)

reg mrallp beertax if year == 1988, r
predict t2
twoway scatter mrallp t2 beertax if year == 1988, s(o i) c(. 1) name(second)

gen fatr1 = mrallp-mrallp[_n-6]
gen bet = beertax-beertax[_n-6]
reg fatr1 bet if year == 1988, r
predict t3
twoway scatter fatr1 t3 bet if year == 1988, s(o i) c(. 1) name(third)

xtset state year
xtreg mrallp beertax, fe vce(cluster state)


gen y83=(year==1983)
gen y84=(year==1984)
gen y85=(year==1985)
gen y86=(year==1986)
gen y87=(year==1987)
gen y88=(year==1988)
global yeardum "y83 y84 y85 y86 y87 y88"
xtreg mrallp beertax $yeardum, fe vce(cluster state)

log close
translate labwork2.smcl labwork2.log, replace
