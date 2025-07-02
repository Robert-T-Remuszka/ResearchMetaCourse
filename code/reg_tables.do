clear all
do globals

* Read in the analysis file
use "${data}/phillips_analysis_file.dta", clear

* Create a monthly date variable
gen datem = mofd(dated)
format %tm datem  // Make the monthly date readable to humans
order datem dated // reorder columns of data

* Designate time index
tsset datem

* Calculate year over year inflation
gen pi_yoy = (cpi / l12.cpi - 1) * 100

* Label variables for tables - keep in mind that we are exporing to latex
la var ex_pi_1y "Expected $\pi$"
la var pi_yoy "$\pi$"


* Save regressions and round point estimates for coloring
eststo basic_phillips: qui reg pi_yoy urate, vce(robust)
loc b_ols: display %9.3f _b[urate]

eststo exp_augment: qui reg pi_yoy urate ex_pi_1y, vce(robust)
loc b_ols_aug: display %9.3f _b[urate]

esttab basic_phillips exp_augment using "${tables}/phillips_regs.tex", label keep(urate ex_pi_1y) booktabs stats(N, fmt(%3.0f)) se replace ///
b(%9.3f) /// Rounds the point estimates in the table
subs("Standard errors" "Robust standard errors" "`b_ols'" "\textcolor{mycolor2}{`b_ols'}" "`b_ols_aug'" "\textcolor{mycolor5}{`b_ols_aug'}") 