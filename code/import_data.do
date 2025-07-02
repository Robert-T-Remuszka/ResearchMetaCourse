/************
You will need to request an API key from fred in order to run this script.
*************/
clear all                            // Clears memory and starts fresh
do globals                           // File paths that allow me to access other folders in the project

* Import the CPI into the default frame
import fred CPIAUCSL UNRATE, clear daterange(1978-1-1 .)
drop datestr                         // drop variable named datestr   
ren daten dated                      // rename variable date to dated
ren CPIAUCSL cpi
ren UNRATE urate

/*
Stata allows users to abbreviate commands in their scripts. If you see a command which you do not recognize use the help menu. In this example
just write 'help ren' in the command line and hit enter. The help meu for the command rename will pop up and the underlined portion under the
syntax section of the documetation tells us that 'ren' is valid syntax for 'rename'. Alternatively, you can write the entire command.
*/

* Create a separtae frame and import the year ahead inflation expectation from Michigan
frame create expected_pi
frame expected_pi {
    import fred MICH, clear
    ren MICH ex_pi_1y
    ren daten dated
    drop datestr
}

****************** SAVING DATA ************
* Saving as .dta - note the use of relative file paths (see globals.do)
save "${data}/phillips.dta", replace
frame expected_pi: save "${data}/ex_pi.dta", replace

* You can also save files in formats other than .dta files. This is useful if you are using multiple programming langauges for different
* parts of the project
export delimited "${data}/phillips.csv", replace
frame expected_pi: export delimited "${data}/ex_pi.csv", replace

