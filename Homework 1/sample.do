clear
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
summarize(best1)

matrix P = (100, -16 \ -16, 4)
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
gen u = rnormal(0,1)
gen y = -20+3*x+u+v
qui reg y x
return scalar bhat = _b[x]
end

simulate best2 = r(bhat), seed(55555) reps(10000) nodots: Omi_Bia
summarize(best2)

* For random sample in Stata, check the following link
* https://www.stata.com/support/faqs/statistics/random-samples/



















