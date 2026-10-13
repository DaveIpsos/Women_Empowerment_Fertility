

*************************************************************************************************************************************
*************************************************************************************************************************************
*Title: Women's empowerment Indicators and High-risk Fertility Behaviors among Married Adolescent Girls in Northern Nigeria
*Code Author: David Aduragbemi Okunlola 
*Institution: Department of Sociology, Florida State University, Tallahassee, USA
*Year: 2025/2026
*Survey year: 2008-2023 Nigeria Demographic and Health Survey (NDHS)
*************************************************************************************************************************************
*************************************************************************************************************************************

* Input the predicted probabilities data for sexual agency
clear
* Average predicted probabilities from mimrgns ..., predict(pr eq(#)) -- already on 0-1 scale
input str30 outcome byte level double margin double se double lci double uci
"Parous" 1 .3442723 .0153022 .3142806 .3742641
"Parous" 2 .3416339 .0305282 .2817998 .401468
"Parous" 3 .3125058 .0324089 .2489855 .3760261
"Pregnancy" 1 .2318126 .0147563 .2028909 .2607344
"Pregnancy" 2 .2139638 .0284387 .158225 .2697026
"Pregnancy" 3 .2394301 .0332719 .1742184 .3046418
"Contraceptive" 1 .1025538 .009969 .0830149 .1220927
"Contraceptive" 2 .1643236 .0234096 .1184416 .2102055
"Contraceptive" 3 .1958807 .0270797 .1428054 .248956
end

* Label levels
label define levellab 1 "Low" 2 "Moderate" 3 "High"
label values level levellab

* Create separate variables for each outcome
gen nc_margin = margin if outcome == "Parous"
gen nc_lci = lci if outcome == "Parous"
gen nc_uci = uci if outcome == "Parous"

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
* Average predicted probabilities from mimrgns ..., predict(pr eq(#)) -- already on 0-1 scale
input str30 outcome byte level double margin double se double lci double uci
"Parous" 1 .3075251 .026169 .2562347 .3588155
"Parous" 2 .356424 .0308442 .2959706 .4168775
"Parous" 3 .3473784 .0179914 .3121159 .3826409
"Pregnancy" 1 .2444178 .0248312 .1957493 .2930863
"Pregnancy" 2 .2125316 .0240725 .1653499 .2597134
"Pregnancy" 3 .2299665 .0152536 .2000699 .259863
"Contraceptive" 1 .096947 .0157658 .0660466 .1278475
"Contraceptive" 2 .0971217 .0155511 .0666422 .1276012
"Contraceptive" 3 .1403547 .011556 .1177053 .163004
end

* Label levels
label define levellab 1 "Low" 2 "Moderate" 3 "High"
label values level levellab

* Create separate variables for each outcome
gen nc_margin = margin if outcome == "Parous"
gen nc_lci = lci if outcome == "Parous"
gen nc_uci = uci if outcome == "Parous"

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
* Average predicted probabilities from mimrgns ..., predict(pr eq(#)) -- already on 0-1 scale
input str30 outcome byte level double margin double se double lci double uci
"Parous" 1 .3255937 .0136465 .298847 .3523404
"Parous" 2 .4154895 .0351311 .3466338 .4843452
"Pregnancy" 1 .2314486 .0125184 .206913 .2559842
"Pregnancy" 2 .2219861 .02909 .1649708 .2790014
"Contraceptive" 1 .1214703 .0098305 .1022028 .1407377
"Contraceptive" 2 .136197 .0203254 .0963599 .1760341
end

* Label levels
label define levellab 1 "Others" 2 "Respondent"
label values level levellab

* Create separate variables for each outcome
gen nc_margin = margin if outcome == "Parous"
gen nc_lci = lci if outcome == "Parous"
gen nc_uci = uci if outcome == "Parous"

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
    legend(order(2 "Parous" 4 "Pregnancy" 6 "Contraceptive Use/Intention") ///
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

