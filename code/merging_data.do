clear all
do globals

* Read the imported data into the default frame
use "${data}/phillips.dta", clear

* Merge in the Michigan data
merge 1:1 dated using "${data}/ex_pi.dta", nogen // all observations matched, no need to generate a match code

* Save the analysis file
save "${data}/phillips_analysis_file.dta", replace

