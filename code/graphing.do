clear all
do globals

use "${data}/phillips_analysis_file.dta", clear

* Create a monthly date variable
gen datem = mofd(dated)
format %tm datem  // Make the monthly date readable to humans
order datem dated // reorder columns of data

* Designate time index
tsset datem

* Calculate year over year inflation
gen pi_yoy = (cpi / l12.cpi - 1) * 100
la var pi_yoy "%{&Delta} YoY"

* Simple line graph of inflation
tw line pi_yoy datem, xlab(, nogrid angle(45) labsize(small)) ylab(, nogrid) legend(on order(1) label(1 "{&pi}") pos(2) ring(0)) ///
xtitle("") yline(0, lc(black%50) lp(solid)) name(simple_pi)

* You can overlay graphs too
tw line pi_yoy datem || line urate datem, xlab(, nogrid angle(45) labsize(small)) ylab(, nogrid) ///
legend(on label(1 "{&pi}") label(2 "U-rate") pos(4) ring(0)) xtitle("") yline(0, lc(black%50) lp(solid)) ytitle("") ///
name(pi_urate_line)

* Scatter of inflation and unemployment - doesn't identify the Phillips curve!
qui reg pi_yoy urate
loc beta = round(_b[urate],0.01)
tw scatter pi_yoy urate || lfit pi_yoy urate, lp(dash) name(phillips_basic) ytitle("{&pi}") xlab(,nogrid) ylab(,nogrid) ///
legend(label(2 "{&beta} = `beta'") order(2))

****** HOW TO SAVE GRAPHS
loc graph_names "pi_urate_line phillips_basic"
foreach g in `graph_names' {
    graph export "${graphs}/`g'.pdf", replace name(`g')
}

