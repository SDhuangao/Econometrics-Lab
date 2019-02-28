log using 6, text replace
clear all
cd "D:\大三上\中级计量经济学\老师发的\Lab\上机3&4" 
use Names
*a
reg call_back black
/*
the white call-back is .0965092, the black call-back is .0965092-.0320329
= .0644763 =6.44763%
95% CI is [-.0472949, -.0167708]
the difference is significant, it's large in a real-world sense.
*/
*b
gen febla = female*black
reg call_back black female febla
*white male .0886957
*white female  .0989248
*balck male .0582878
*black female .0662779
*different, but not significant
*c
gen higbla = high*black
reg call_back high
dis .0140574+.0734323
reg call_back black high higbla
dis .0229478-.0177808-.0231023
/*
high-quality get more call-back, .0140574 
low get .0734323, high is .0874897
not significant
for white, .0229478
for black, .0229478-.0177808 = .005167
difference in this high-quality/low-quality difference for whites
versus African Americans is -.0179353, not significant
*/
*d
sort black
by black: sum
* There is no evidence of non-random assignment.
log close


