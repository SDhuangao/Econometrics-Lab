log using labwork1, replace

*遗漏变量的蒙特卡洛实验
clear all
program No_Omi, rclass
drop _all
set obs 100
gen x = rnormal(0,10)
gen u = rnormal(0,2)
gen y = -20+3*x+u
qui reg y x
return scalar bhat = _b[x]
end

simulate best1 = r(bhat), seed(12345) reps(10000) nodots: No_Omi
summarize(best1), detail


clear
matrix P = (100, 16 \ 16, 9)
mat A = cholesky(P)
mat list A
global A

program Omi_Bia, rclass
drop _all
set obs 100
gen x1 = rnormal(0,1)
gen v1 = rnormal(0,1)
gen x = A[1,1]*x1
gen v = A[2,1]*x1+A[2,2]*v1
gen u = rnormal(0,4)
gen y = -20+3*x+u+v
qui reg y x
return scalar bhat = _b[x]
end

simulate best2 = r(bhat), seed(66666) reps(10000) nodots: Omi_Bia
summarize(best2), detail


clear
matrix P = (100, -16 \ -16, 9)
mat A = cholesky(P)
mat list A
global A

program Omi_Bia1, rclass
drop _all
set obs 100
gen x1 = rnormal(0,1)
gen v1 = rnormal(0,1)
gen x = A[1,1]*x1
gen v = A[2,1]*x1+A[2,2]*v1
gen u = rnormal(0,4)
gen y = -20+3*x+u+v
qui reg y x
return scalar bhat = _b[x]
end

simulate best3 = r(bhat), seed(98765) reps(10000) nodots: Omi_Bia1
summarize(best3), detail

clear
matrix P = (100, 0 \ 0, 9)
mat A = cholesky(P)
mat list A
global A

program Omi_Bia2, rclass
drop _all
set obs 100
gen x1 = rnormal(0,1)
gen v1 = rnormal(0,1)
gen x = A[1,1]*x1
gen v = A[2,1]*x1+A[2,2]*v1
gen u = rnormal(0,4)
gen y = -20+3*x+u+v
qui reg y x
return scalar bhat = _b[x]
end

simulate best4 = r(bhat), seed(45678) reps(10000) nodots: Omi_Bia2
summarize(best4), detail

*Sample Selection 的蒙特卡洛实验

clear
program Sam_Sel, rclass
drop _all
set obs 200
gen x = rnormal(0,100)
gen u = rnormal(0,4)
gen y = -20+3*x+u
qui reg y x
return scalar bhat = _b[x]
end
simulate best5 = r(bhat), seed(12345) reps(10000) nodots: Sam_Sel
summarize(best5), detail



clear all
program Sam_Sel1, rclass
drop _all
set obs 200
gen x = rnormal(0,100)
gen u = rnormal(0,4)
sample 50
gen y = -20+3*x+u
qui reg y x
return scalar bhat = _b[x]
end
simulate best6 = r(bhat), seed(123321) reps(10000) nodots: Sam_Sel1
summarize(best6), detail


clear all
program Sam_Sel2, rclass
drop _all
set obs 200
gen x = rnormal(0,100)
gen u = rnormal(0,4)
gen y = -20+3*x+u
keep if u >0
qui reg y x
return scalar bhat = _b[x]
end
simulate best7 = r(bhat), seed(34554) reps(10000) nodots: Sam_Sel2
summarize(best7), detail


clear all
program Sam_Sel3, rclass
drop _all
set obs 200
gen x = rnormal(0,100)
gen u = rnormal(0,4)
gen y = -20+3*x+u
keep if u < -0.5
qui reg y x
return scalar bhat = _b[x]
end
simulate best8 = r(bhat), seed(22222) reps(10000) nodots: Sam_Sel3
summarize(best8), detail

*测量误差的蒙特卡洛实验
clear all
program Mea_Err, rclass
drop _all
set obs 100
gen x = rnormal(0,100)
gen u = rnormal(0,4)
gen v = rnormal(0,1)
gen y = -20+3*x+u
gen x1 = x +v
qui reg y x1
return scalar bhat = _b[x1]
end
simulate best9 = r(bhat), seed(11111) reps(10000) nodots: Mea_Err
summarize(best9), detail


clear all
program Mea_Err, rclass
drop _all
set obs 100
gen x = rnormal(0,100)
gen u = rnormal(0,4)
gen v = rnormal(0,1)
gen y = -20+3*x+u
gen y1 = y +v
qui reg y x
return scalar bhat = _b[x]
end
simulate best10 = r(bhat), seed(33333) reps(10000) nodots: Mea_Err
summarize(best10), detail

*互为因果的蒙特卡洛实验
clear all
program Sim_Cau, rclass
drop _all
set obs 100
gen t=_n
gen u =rnormal(0,4)
gen v =rnormal(0,9)
gen x =rnormal(100,100) if t==1
gen y =150-0.2*x+u if t==1

forvalues i=2/100{
replace x =-20+0.4*y[_n-1]+v if t>1
replace y =150-0.2*x[_n]+u if t>1
}

qui reg y x
return scalar bhat = _b[x]
end
simulate best11 = r(bhat), seed(23333) reps(10000) nodots: Sim_Cau
summarize(best11), detail

log close
translate labwork1.smcl labwork1.log, replace
