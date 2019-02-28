clear all
cap log close
log using HW3_3, text replace
*HW3_3
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机5&6"

program myp
clear
drop _all
set obs 100
gen n=_n

gen e = rnormal()
gen y=e[1]
replace y=y[_n-1]+e[_n] if n>1

gen a = rnormal()
gen x=a[1]
replace x=x[_n-1]+a[_n] if n>1

reg y x
gen Rsquare=e(r2)
gen T_value=_b[x]/_se[x]
end

*a
myp
*Rsquared is 0.5068, t= -12.34<-1.96, reject the null at 5%

*b
simulate r2=Rsquare t=T_value, seed(12345) reps(1000) nodots: myp
su r2 t, detail
histogram r2, saving(Rsquare, replace)
histogram t, saving(T_value, replace)
*Rsquare 5% :.0019926  50% :.1740297  95%:.6863762
*T_value 5% :-11.18675 50% :.3334793  95%:12.41548
count if t>1.96|t<-1.96
local count= r(N)
local total = _N
gen fra=r(N)/1000
dis "fraction=" fra

*c
//T=50
program myp1
clear
drop _all
set obs 50
gen n=_n

gen e = rnormal()
gen y=e[1]
replace y=y[_n-1]+e[_n] if n>1

gen a = rnormal()
gen x=a[1]
replace x=x[_n-1]+a[_n] if n>1

reg y x
gen Rsquare=e(r2)
gen T_value=_b[x]/_se[x]
end
simulate r21=Rsquare t1=T_value, seed(12345) reps(1000) nodots: myp1
count if t1>1.96|t1<-1.96
local count= r(N)
gen fra1=r(N)/1000
dis "fraction=" fra1


//T=200
program myp2
clear
drop _all
set obs 200
gen n=_n

gen e = rnormal()
gen y=e[1]
replace y=y[_n-1]+e[_n] if n>1

gen a = rnormal()
gen x=a[1]
replace x=x[_n-1]+a[_n] if n>1

reg y x
gen Rsquare=e(r2)
gen T_value=_b[x]/_se[x]
end
simulate r22=Rsquare t2=T_value, seed(34566) reps(1000) nodots: myp2
count if t2>1.96|t2<-1.96
local count= r(N)
gen fra2=r(N)/1000
dis "fraction=" fra2

//As the sample size increases,the fraction of times that we reject the null hypothesis gets bigger.
//the limit is 1???







log close
