

*************************************************************************************************************************************
*************************************************************************************************************************************
*Title: Women's empowerment Indicators and High-risk Fertility Behaviors among Married Adolescent Girls in Northern Nigeria
*Code Author: David Aduragbemi Okunlola 
*Institution: Department of Sociology, Florida State University, Tallahassee, USA
*Year: 2025/2026
*Survey year: 2008-2023 Nigeria Demographic and Health Survey (NDHS)
*************************************************************************************************************************************
*************************************************************************************************************************************


cd "C:\Users\Daves\OneDrive - Florida State University\Send to Dr Mike\Social Science and Medicine\idhs_00008.dat"
preserve
* Input the predicted probabilities data
clear
input str30 outcome byte level float margin float se float lci float uci
"Non-childless" 1 -0.41 0.04 -0.50 -0.33
"Non-childless" 2 -0.43 0.09 -0.60 -0.26
"Non-childless" 3 -0.51 0.10 -0.70 -0.33
"Pregnancy" 1 -0.75 0.05 -0.85 -0.66
"Pregnancy" 2 -0.81 0.10 -1.00 -0.62
"Pregnancy" 3 -0.71 0.11 -0.92 -0.49
"Contraceptive" 1 -1.46 0.06 -1.58 -1.33
"Contraceptive" 2 -1.10 0.11 -1.32 -0.89
"Contraceptive" 3 -0.95 0.12 -1.18 -0.72
end

* Convert to probability scale using normal()
replace margin = normal(margin)
replace lci = normal(lci)
replace uci = normal(uci)

* Label levels
label define levellab 1 "Low" 2 "Moderate" 3 "High"
label values level levellab

* Create separate variables for each outcome
gen nc_margin = margin if outcome == "Non-childless"
gen nc_lci = lci if outcome == "Non-childless"
gen nc_uci = uci if outcome == "Non-childless"

gen preg_margin = margin if outcome == "Pregnancy"
gen preg_lci = lci if outcome == "Pregnancy"
gen preg_uci = uci if outcome == "Pregnancy"

gen contra_margin = margin if outcome == "Contraceptive"
gen contra_lci = lci if outcome == "Contraceptive"
gen contra_uci = uci if outcome == "Contraceptive"

* Create the graph
twoway ///
    (rarea nc_lci nc_uci level, color(navy%15) lwidth(none)) ///
    (connected nc_margin level, lcolor(navy) mcolor(navy) msymbol(D) msize(small) lwidth(thin)) ///
    (rarea preg_lci preg_uci level, color(cranberry%15) lwidth(none)) ///
    (connected preg_margin level, lcolor(cranberry) mcolor(cranberry) msymbol(O) msize(small) lwidth(thin)) ///
    (rarea contra_lci contra_uci level, color(forest_green%15) lwidth(none)) ///
    (connected contra_margin level, lcolor(forest_green) mcolor(forest_green) msymbol(T) msize(small) lwidth(thin)), ///
    xlabel(1 "Low" 2 "Moderate" 3 "High", labsize(small)) ///
    ylabel(0(0.1)0.5, format(%4.2f) labsize(small) angle(0)) ///
    xtitle("") ///
    ytitle("Probability", size(small) margin(medium)) ///
    title("Sexual Agency Status", size(medium) margin(medium)) ///
    legend(off) ///
    graphregion(color(white) margin(small)) ///
    plotregion(margin(medium)) ///
    scheme(cleanplots) ///
    ysize(7) xsize(10) name(sex_agency_probit, replace)

restore

**************************************************************************************
preserve
* Input the predicted probabilities data for Healthcare Access
clear
input str30 outcome byte level float margin float se float lci float uci
"Non-childless" 1 -0.53 0.08 -0.69 -0.38
"Non-childless" 2 -0.38 0.06 -0.49 -0.26
"Non-childless" 3 -0.42 0.07 -0.55 -0.29
"Pregnancy" 1 -0.70 0.08 -0.86 -0.54
"Pregnancy" 2 -0.84 0.06 -0.96 -0.72
"Pregnancy" 3 -0.70 0.06 -0.83 -0.57
"Contraceptive" 1 -1.48 0.11 -1.69 -1.28
"Contraceptive" 2 -1.36 0.08 -1.51 -1.20
"Contraceptive" 3 -1.24 0.08 -1.39 -1.08
end

* Convert to probability scale using normal()
replace margin = normal(margin)
replace lci = normal(lci)
replace uci = normal(uci)

* Label levels
label define levellab 1 "Low" 2 "Moderate" 3 "High"
label values level levellab

* Create separate variables for each outcome
gen nc_margin = margin if outcome == "Non-childless"
gen nc_lci = lci if outcome == "Non-childless"
gen nc_uci = uci if outcome == "Non-childless"

gen preg_margin = margin if outcome == "Pregnancy"
gen preg_lci = lci if outcome == "Pregnancy"
gen preg_uci = uci if outcome == "Pregnancy"

gen contra_margin = margin if outcome == "Contraceptive"
gen contra_lci = lci if outcome == "Contraceptive"
gen contra_uci = uci if outcome == "Contraceptive"

* Create the graph
twoway ///
    (rarea nc_lci nc_uci level, color(navy%15) lwidth(none)) ///
    (connected nc_margin level, lcolor(navy) mcolor(navy) msymbol(D) msize(small) lwidth(thin)) ///
    (rarea preg_lci preg_uci level, color(cranberry%15) lwidth(none)) ///
    (connected preg_margin level, lcolor(cranberry) mcolor(cranberry) msymbol(O) msize(small) lwidth(thin)) ///
    (rarea contra_lci contra_uci level, color(forest_green%15) lwidth(none)) ///
    (connected contra_margin level, lcolor(forest_green) mcolor(forest_green) msymbol(T) msize(small) lwidth(thin)), ///
    xlabel(1 "Low" 2 "Moderate" 3 "High", labsize(small)) ///
    ylabel(0(0.1)0.5, format(%4.2f) labsize(small) angle(0)) ///
    xtitle("") ///
    ytitle("") ///
    title("Healthcare Access Status", size(medium) margin(medium)) ///
	legend(off) ///
    graphregion(color(white) margin(small)) ///
    plotregion(margin(medium)) ///
    scheme(cleanplots) ///
    ysize(7) xsize(10) name(healthcare_probit, replace)

restore


***********************************
preserve
* Input the predicted probabilities data for Decision on respondent's health
clear
input str30 outcome byte level float margin float se float lci float uci
"Non-childless" 1 -0.47 0.04 -0.54 -0.39
"Non-childless" 2 -0.23 0.09 -0.42 -0.05
"Pregnancy" 1 -0.76 0.04 -0.84 -0.67
"Pregnancy" 2 -0.77 0.10 -0.96 -0.58
"Contraceptive" 1 -1.36 0.06 -1.47 -1.24
"Contraceptive" 2 -1.26 0.11 -1.48 -1.03
end

* Convert to probability scale using normal()
replace margin = normal(margin)
replace lci = normal(lci)
replace uci = normal(uci)

* Label levels
label define levellab 1 "Others" 2 "Respondent"
label values level levellab

* Create separate variables for each outcome
gen nc_margin = margin if outcome == "Non-childless"
gen nc_lci = lci if outcome == "Non-childless"
gen nc_uci = uci if outcome == "Non-childless"

gen preg_margin = margin if outcome == "Pregnancy"
gen preg_lci = lci if outcome == "Pregnancy"
gen preg_uci = uci if outcome == "Pregnancy"

gen contra_margin = margin if outcome == "Contraceptive"
gen contra_lci = lci if outcome == "Contraceptive"
gen contra_uci = uci if outcome == "Contraceptive"

* Create the graph
twoway ///
    (rarea nc_lci nc_uci level, color(navy%15) lwidth(none)) ///
    (connected nc_margin level, lcolor(navy) mcolor(navy) msymbol(D) msize(small) lwidth(thin)) ///
    (rarea preg_lci preg_uci level, color(cranberry%15) lwidth(none)) ///
    (connected preg_margin level, lcolor(cranberry) mcolor(cranberry) msymbol(O) msize(small) lwidth(thin)) ///
    (rarea contra_lci contra_uci level, color(forest_green%15) lwidth(none)) ///
    (connected contra_margin level, lcolor(forest_green) mcolor(forest_green) msymbol(T) msize(small) lwidth(thin)), ///
    xlabel(1 "Others" 2 "Respondent participates", labsize(small)) ///
    ylabel(0(0.1)0.5, format(%4.2f) labsize(small) angle(0)) ///
    xtitle("") ///
    ytitle("Probability", size(small) margin(l=5)) ///
    title("Decision on Respondent's Healthcare", size(medium) margin(small)) ///
    legend(order(2 "Non-childless" 4 "Pregnancy" 6 "Contraceptive Use/Intention") ///
    pos(6) cols(3) size(small) region(lcolor(none))) ///
    graphregion(color(white) margin(small)) ///
    plotregion(margin(medium)) ///
    scheme(cleanplots) ///
    ysize(7) xsize(10) name(health_decision_probit, replace)

restore

* Combine graphs
grc1leg2 sex_agency_probit healthcare_probit health_decision_probit, ///
    rows(2) cols(2) ///
    legendfrom(health_decision_probit) ///
    position(6) ///
    graphregion(color(white)) ///
    imargin(medium) ///
    name(probit_combined, replace)

graph export "combined_probit.png", replace width(6000) height(4200)
