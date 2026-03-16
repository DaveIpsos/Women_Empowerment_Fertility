
*************************************************************************************************************************************
*************************************************************************************************************************************
*Title: Women's empowerment Indicators and High-risk Fertility Behaviors among Married Adolescent Girls in Northern Nigeria
*Code Author: David Aduragbemi Okunlola 
*Institution: Department of Sociology, Florida State University, Tallahassee, USA
*Year: 2025/2026
*Survey year: 2008-2013 Nigeria Demographic and Health Survey (NDHS) IPUMS Data combined with 2023 NDHS Data from Measuredhs.com
*************************************************************************************************************************************
*************************************************************************************************************************************


***Append
use ipums_2008, clear
append using ipums_2013
append using ipums_2018

fre year survey

***Violence module
fre dvmodule

***Weight for violence
fre dvweight

**Marital Status
fre marstat
recode marstat (10=0 "Never married")(21=1 "Married")(22=2 "Partnered")(else=3 "Others"), gen(marry)
fre marry

***Pregnant
fre pregnant

***Contraceptive use and intention
fre fpusintent
recode fpusintent (1/3=1 "User/intent")(4=0 "Non-user/no intent"), gen(contra_intention)
fre contra_intention

*Fertility knowledge: dichotomize v217 (ovulatory cycle) & v244 (post-partumfecundability) into correct Y/N
fre ovcycle
recode ovcycle (3=1 "Yes")(1/2 4/7=0 "No")(else=.), gen(fertile)
fre fertile

***Exposure to family planning messages
fre fpradiohr fptvhr fpnewshr /*fpmobpsahr fpcrierhr*/
foreach var in fpradiohr fptvhr fpnewshr /*fpmobpsahr fpcrierhr*/ {
	replace `var'=. if `var'==8 | `var'== 98
	replace `var'=1 if `var'==10
}

egen family_plan = rowtotal(fpradiohr fptvhr fpnewshr /*fpmobpsahr fpcrierhr*/)
clonevar famplan = family_plan
replace famplan =. if (family_plan==0) & (fpradiohr==. & fptvhr==. & fpnewshr==.)
ta famplan
recode famplan (0=0 "Unexposure")(2/3=1 "Exposed")(else=.), gen(familyplan)
ta familyplan

***Insurance coverage
fre inscoveryn
clonevar insurance = inscoveryn
replace insurance=. if inscoveryn==8
fre insurance

***Access to healthcare
fre bhcpermit bhcmoney bhcdistance bhcalone /*fphomvisity fphcvisity*/
foreach var in bhcpermit bhcmoney bhcdistance bhcalone {
	replace `var'=. if `var'==8 | `var'==98
	replace `var'=1 if `var'==10
	replace `var'=0 if `var'==20
}

egen healthh_care = rowtotal(bhcpermit bhcmoney bhcdistance bhcalone insurance)
clonevar healthcare = healthh_care
replace healthcare =. if (healthh_care==0) & (bhcpermit==. & bhcmoney==. & bhcdistance==. & bhcalone==. & insurance==.)
ta healthcare 
recode healthcare (0/1=0 "Low access")(2/3=1 "Moderate access")(4/5=2 "High access")(else=.), gen(health_care)
fre health_care

****Educational levels
fre educlvl husedlvl
recode educlvl husedlvl (0/1 7 = 0 "< Secondary/ Don't know")(2/3 = 1 "Secondary +")(else =.), pre(new) label(newrep)
fre neweduclvl newhusedlvl

**Sexual agency
fre sxcanrefuse conaskifsti conaskpar
recode sxcanrefuse conaskifsti conaskpar (0 7=0 "No/don't know")(1=1 "Yes")(else=.), pre(new) label(newrep)
fre newsxcanrefuse newconaskifsti newconaskpar
egen sexual_aut = rowtotal(newsxcanrefuse newconaskifsti newconaskpar)
clonevar sexautonom = sexual_aut
replace sexautonom=. if (sexual_aut==0 & newsxcanrefuse==. & newconaskifsti==. & newconaskpar==.)
ta sexautonom 
recode sexautonom (0/1=0 "Low agency")(2=1 "Moderate")(3=2 "High agency")(else=.), gen(sexual_autonomy)
fre sexual_autonomy

**Mass media
fre newsfq tvfq radiofq
recode newsfq tvfq radiofq (0=0 "No exposure")(10/22=1 "Exposed")(else=.), pre(new) label(newrep)
fre newnewsfq newtvfq newradiofq
egen mass_media = rowtotal(newnewsfq newtvfq newradiofq)
clonevar massmedia = mass_media
replace massmedia =. if (mass_media==0) & (newnewsfq==. & newtvfq==. & newradiofq==.)
ta mass_media
recode mass_media (0=0 "Unexposed")(1/3=1 "Exposed")(else=.), gen(massmediaa)
fre massmediaa

**Household decision making participation
fre decfemhcare
recode decfemhcare (1/2=1 "Participate in decision")(4/6=0 "Others")(else=.), gen(res_hlt)
ta res_hlt

****Type of marriage
fre wifenum
recode wifenum (0 97=0 "Monogamy/Don't know")(1/15=1 "Polygamous")(else=.), gen(polygamy)
ta polygamy

***Unions
fre union1more
gen multi_unions = union1more ==1
replace multi_unions=. if union1more > 1
ta multi_unions

*****Wealth index
fre wealthq
clonevar wealthindex = wealthq
fre wealthindex

**Ethnicity
fre ethnicityng
recode ethnicityng (2/3 8=1 "Hausa/Fulani/Kanuri")(else=0 "Non-Hausa/Fulani/others"), gen(ethnic)
ta ethnic 

**Religion
fre religion
recode religion (1000=1 "Islam")(else=0 "Non-Islam/others"), gen(rel)
ta rel

**Residence
fre urban
clonevar residence = urban
ta residence

*Region
fre geo_ng2003_2021
clonevar region = geo_ng2003_2021
ta region

*****Husband desire for children
fre husfertpref
recode husfertpref (1=1 "Both want same")(2=2 "Husband wants more")(3=3 "Husband wants fewer")(7=7 "Don't know")(else=.), gen(child_desire)
ta child_desire

***Violence
fre dveever dvpmsever dvplsever dvpsexever
recode dveever dvpmsever dvplsever dvpsexever (0=0 "No")(1=1 "Yes")(else=.), pre(new) label(newrep)
egen vio = rowtotal(newdveever newdvpmsever newdvplsever newdvpsexever)
clonevar violent = vio 
replace violent =. if (vio==0) & (newdveever==. & newdvpmsever==. & newdvplsever==. & newdvpsexever==.)
ta violent
gen violence=violent>0
replace violence=. if (vio==0) & (newdveever==. & newdvpmsever==. & newdvplsever==. & newdvpsexever==.)
ta violence

***Ideal number of children
fre idealkid
recode idealkid (0/2=0 "0-2")(3/50=1 "3+")(else=2 "God/Allah/fate wills/uncertain/Don't know/others"), gen(ideal_child)
ta ideal_child

**CEB
fre cheb
recode cheb (0=0 "Childless")(else=1 "Non-childless"), gen(children)
fre children

**Age
fre age 
la def age 15 "15 years" 16 "16 years" 17 "17 years"
la val age age
fre age

***Abortion
fre pregtermin
clonevar abortion = pregtermin
replace abortion=. if abortion > 1

**Keep variables
keep survey clusterno strata perweight wt1 wt2 dvweight marry pregnant contra_intention dvmodule age familyplan health_care neweduclvl newhusedlvl sexual_autonomy massmediaa res_hlt polygamy wealthindex ethnic rel residence region child_desire violence ideal_child children abortion 

**Append 2023
append using dhs_2023

ta survey

egen dhsidnew = group(survey clusterno), label
ta dhsidnew

egen stratanew = group(survey strata), label
ta stratanew

fre newhusedlvl
la def newhusedlvl 0 "< Secondary/Don't know" 1 "Secondary +", modify
la val newhusedlvl newhusedlvl
fre newhusedlvl
la val neweduclvl newhusedlvl
ta neweduclvl [iw=dvweight]
ta newhusedlvl [iw=dvweight]

**Save data
save ipums_2023_2018_2013_2008, replace

**Target population for spacing
gen targpop = 0
replace targpop=1 if (marry==1 & age < 18 & inrange(region, 1, 3) & dvmodule==1)
ta targpop [iw=dvweight]   //  1,690

egen nmiss_1 = rowmiss(pregnant contra_intention sexual_autonomy health_care age survey familyplan neweduclvl newhusedlvl massmediaa res_hlt polygamy wealthindex ethnic rel residence region child_desire ideal_child abortion children violence) 
ta nmiss_1

ta nmiss_1 if (targpop==1) // 9.94% missing (184) of 1,852
ta nmiss_1 [iw=dvweight] if (targpop==1) 

missings report pregnant contra_intention sexual_autonomy health_care age survey familyplan neweduclvl newhusedlvl massmediaa res_hlt polygamy wealthindex ethnic rel residence region child_desire ideal_child abortion children violence if (targpop==1), percent

***Descriptive statistics
dtable i.children i.pregnant i.contra_intention i.sexual_autonomy i.health_care i.res_hlt i.familyplan i.ethnic i.rel i.polygamy i.abortion i.child_desire i.ideal_child i.violence i.massmediaa i.neweduclvl i.newhusedlvl i.wealthindex i.residence i.region i.survey [iw=dvweight] if (targpop==1), factor(pregnant contra_intention sexual_autonomy health_care res_hlt familyplan ethnic rel polygamy abortion children child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey) nformat(%7.1f q1 q2 q3) /*export(myfile.docx, replace) */


***GRAPHING
la def pregnant 0 "No/unsure" 1 "Pregnant", modify
la val pregnant pregnant
fre pregnant

la def res_hlt 0 "Others decide" 1 "Participates in decision", modify
la val res_hlt res_hlt
fre res_hlt

***Sexual Agency & Fertility
catplot [iw=dvweight] if (targpop==1), by(children, l1title(Sexual agency status) note("")) over(sexual_autonomy) percent(sexual_autonomy)  blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(2, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(3, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(4, fcolor(navy) fintensity(inten100) lcolor(navy)) /// 
ytitle("") name(G6, replace) scheme(cleanplots)

***Sexual Agency & Pregnancy
catplot [iw=dvweight] if (targpop==1), by(pregnant, l1title("") note("")) over(sexual_autonomy) percent(sexual_autonomy)  blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(2, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(3, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(4, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) /// 
ytitle("") name(G7, replace) scheme(cleanplots)

***Sexual Agency & Contraception
catplot [iw=dvweight] if (targpop==1), by(contra_intention, l1title("") note("")) over(sexual_autonomy) percent(sexual_autonomy)  blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(2, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(3, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(4, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) /// 
 ytitle("") name(G8, replace) scheme(cleanplots)

***Healthcare Accessibility & Fertility
catplot [iw=dvweight] if (targpop==1), by(children, l1title(Healthcare accessibility status) note("")) over(health_care) percent(health_care) blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(2, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(3, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(4, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
ytitle("") name(G9, replace) scheme(cleanplots)

***Healthcare Accessibility & Pregnancy
catplot [iw=dvweight] if (targpop==1), by(pregnant, l1title("") note("")) over(health_care) percent(health_care) blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(2, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(3, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(4, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
ytitle("") name(G10, replace) scheme(cleanplots)

***Healthcare Accessibility & Contraception
catplot [iw=dvweight] if (targpop==1), by(contra_intention, l1title("") note("")) over(health_care) percent(health_care) blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(2, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(3, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(4, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
ytitle("") name(G11, replace) scheme(cleanplots)

***Decision for respondent's healthcare & Fertility
catplot [iw=dvweight] if (targpop==1), by(children, l1title(Decision on girl's healthcare) note("")) over(res_hlt) percent(res_hlt) blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(2, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(3, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
bar(4, fcolor(navy) fintensity(inten100) lcolor(navy)) ///
ytitle(Percentage) name(G12, replace) scheme(cleanplots)

***Decision for respondent's healthcare & Pregnancy
catplot [iw=dvweight] if (targpop==1), by(pregnant, l1title("") note("")) over(res_hlt) percent(res_hlt) blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(2, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(3, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
bar(4, fcolor(cranberry) fintensity(inten100) lcolor(cranberry)) ///
ytitle(Percentage) name(G13, replace) scheme(cleanplots)

***Decision for respondent's healthcare & Contraception
catplot [iw=dvweight] if (targpop==1), by(contra_intention, l1title("") note("")) over(res_hlt) percent(res_hlt) blabel(bar, format(%9.1f) size(small)) ysc(r(0 100)) ///
bar(1, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(2, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(3, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
bar(4, fcolor(forest_green) fintensity(inten100) lcolor(forest_green)) ///
ytitle(Percentage) name(G14, replace) scheme(cleanplots)

* Combine Sexual and agency, fertility behavior, and contraceptive use
	graph combine G6 G7 G8, ///
    rows(1) ///
	title("(A) Sexual Agency and Fertility Behaviors", size(medium)) ///
    graphregion(color(white) margin(small)) ///
    imargin(small) ///
    xsize(10) ysize(5) ///
    name(uni_6_8, replace)
	
* Combine healthcare accessibility, fertility behavior, and contraceptive use
	graph combine G9 G10 G11, ///
    rows(1) ///
	title("(B) Healthcare Accessibility and Fertility Behaviors", size(medium)) ///
    graphregion(color(white) margin(small)) ///
    imargin(small) ///
    xsize(10) ysize(5) ///
    name(uni_9_11, replace)

* Combine Decision on respondent's healthcare, fertility behavior, and contraceptive use
	graph combine G12 G13 G14, ///
    rows(1) ///
	title("(C) Decision-maker on Respondent's Health and Fertility Behaviors", size(medium)) ///
    graphregion(color(white) margin(small)) ///
    imargin(small) ///
    xsize(10) ysize(5) ///
    name(uni_12_14, replace)

* Combine all graphs
	graph combine uni_6_8 uni_9_11 uni_12_14, ///
    rows(3) ///
    graphregion(color(white) margin(small)) ///
    imargin(small) ///
    xsize(10) ysize(5) ///
    name(uni_all, replace)
	
graph export "combined_univariate.png", replace width(3000) height(1500)

***Crosstabs for Fertility
tabout sexual_autonomy health_care res_hlt familyplan ethnic rel polygamy abortion child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey children if (targpop==1) ///
    using fertility.xls, /*mi*/ ///
    cells(freq row) format(0 1) clab(n %) ///
    ptotal(single) ///
    show(label) ///
    h1("Weighted Crosstabulation") replace

svyset dhsidnew, weight(wt2) strata(stratanew) , singleunit(centered) || _n, weight(dvweight)

foreach var in sexual_autonomy health_care res_hlt familyplan ethnic rel polygamy abortion child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey {
	svy,subpop(if targpop==1): tab `var' children
}

***Crosstabs for Pregnancy
tabout sexual_autonomy health_care children res_hlt familyplan ethnic rel polygamy abortion child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey pregnant [iw=dvweight] if (targpop==1) ///
    using agency_health_fertility.xls, /*mi*/ ///
    cells(freq row) format(0 1) clab(n %) ///
    ptotal(single) ///
    show(label) ///
    h1("Weighted Crosstabulation") replace

foreach var in sexual_autonomy health_care children res_hlt familyplan ethnic rel polygamy abortion child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey {
	svy,subpop(if targpop==1): tab `var' pregnant
}

***Crosstabs for contraception and intent
tabout sexual_autonomy health_care children pregnant res_hlt familyplan ethnic rel polygamy abortion child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey contra_intention [iw=dvweight] if (targpop==1) ///
    using agency_health_contra.xls, /*mi*/ ///
    cells(freq row) format(0 1) clab(n %) ///
    ptotal(single) ///
    show(label) ///
    h1("Weighted Crosstabulation") replace

foreach var in sexual_autonomy health_care children pregnant res_hlt familyplan ethnic rel polygamy abortion child_desire ideal_child violence massmediaa neweduclvl newhusedlvl wealthindex residence region survey {
	svy,subpop(if targpop==1): tab `var' contra_intention
}

*****Missing data imputations 
mi unset
mi set wide
mi misstable patterns pregnant contra_intention sexual_autonomy health_care age survey familyplan neweduclvl newhusedlvl massmediaa res_hlt polygamy wealthindex ethnic rel residence region child_desire ideal_child abortion children violence dhsidnew if (targpop==1)

fre child_desire sexual_autonomy res_hlt rel health_care polygamy abortion newhusedlvl familyplan if (targpop==1)

mi register imputed child_desire sexual_autonomy res_hlt rel health_care polygamy abortion newhusedlvl familyplan

mi impute chained (logit) res_hlt rel polygamy abortion newhusedlvl familyplan (mlogit) child_desire (ologit) sexual_autonomy health_care = pregnant contra_intention age children ideal_child neweduclvl massmediaa violence wealthindex ethnic residence region survey dhsidnew if (targpop==1), augment add(25) rseed (1901) chaindots savetrace(trace1, replace)

**Run model to decide
mi svyset dhsidnew, weight(wt2) strata(stratanew) , singleunit(centered) || _n, weight(dvweight)
*mi svyset dhsidnew [pweight=dvweight], strata(stratanew) singleunit(centered)

*net install cmp, replace
*net install ghk2, replace

***Fit multivariate probit regression
* Step 1: Set up cmp (do this once before running the model)
cmp setup

* Step 2: Then run your mi estimate command
mi estimate, post cmdok dots: ///
    cmp (children = i.sexual_autonomy i.health_care i.res_hlt i.familyplan ///
        i.polygamy i.abortion i.child_desire i.ideal_child i.neweduclvl ///
        i.newhusedlvl i.massmediaa i.violence i.wealthindex i.ethnic i.rel ///
        i.residence i.region i.survey) ///
    (pregnant = i.sexual_autonomy i.health_care i.res_hlt ///
        i.familyplan i.polygamy i.abortion i.child_desire i.ideal_child ///
        i.neweduclvl i.newhusedlvl i.massmediaa i.violence i.wealthindex ///
        i.ethnic i.rel i.residence i.region i.survey) ///
    (contra_intention = i.sexual_autonomy i.health_care ///
        i.res_hlt i.familyplan i.polygamy i.abortion i.child_desire ///
        i.ideal_child i.neweduclvl i.newhusedlvl i.massmediaa i.violence ///
        i.wealthindex i.ethnic i.rel i.residence i.region i.survey) ///
    [iw=dvweight] if targpop==1, ///
    indicators($cmp_probit $cmp_probit $cmp_probit) ///
    robust cluster(dhsidnew) redraws(300) 

***Determine number of imputations
how_many_imputations   // this recommends imputations
Fraction of missing information (95% CI):  0.27 (0.17, 0.39)
Imputations in pilot:                      25
Imputations needed:                        32
Imputations to add:                        7

***Add 7 extra imputations
mi impute chained (logit) res_hlt rel polygamy abortion newhusedlvl familyplan (mlogit) child_desire (ologit) sexual_autonomy health_care = pregnant contra_intention age children ideal_child neweduclvl massmediaa violence wealthindex ethnic residence region survey dhsidnew if (targpop==1), augment add(7) rseed (1901) chaindots savetrace(trace1, replace)

* Step 1: Set up cmp (do this once before running the model)
cmp setup

* Step 2: Then run your mi estimate command
mi estimate, post cmdok dots: ///
    cmp (children = i.sexual_autonomy i.health_care i.res_hlt i.familyplan ///
        i.polygamy i.abortion i.child_desire i.ideal_child i.neweduclvl ///
        i.newhusedlvl i.massmediaa i.violence i.wealthindex i.ethnic i.rel ///
        i.residence i.region i.survey) ///
    (pregnant = i.sexual_autonomy i.health_care i.res_hlt ///
        i.familyplan i.polygamy i.abortion i.child_desire i.ideal_child ///
        i.neweduclvl i.newhusedlvl i.massmediaa i.violence i.wealthindex ///
        i.ethnic i.rel i.residence i.region i.survey) ///
    (contra_intention = i.sexual_autonomy i.health_care ///
        i.res_hlt i.familyplan i.polygamy i.abortion i.child_desire ///
        i.ideal_child i.neweduclvl i.newhusedlvl i.massmediaa i.violence ///
        i.wealthindex i.ethnic i.rel i.residence i.region i.survey) ///
    [iw=dvweight] if targpop==1, ///
    indicators($cmp_probit $cmp_probit $cmp_probit) ///
    robust cluster(dhsidnew) redraws(300) 

estimates store children_model	

estimate restore children_model

***Fertility
mimrgns if (targpop==1), at(sexual_autonomy=(0 1 2)) predict(eq(#1)) cmdmargins // for children

mimrgns if (targpop==1), at(sexual_autonomy=(0 1 2)) predict(eq(#1)) pwcompare cmdmargins

***Pregnancy
mimrgns if (targpop==1), at(sexual_autonomy=(0 1 2)) predict(eq(#2)) cmdmargins // for pregnant

mimrgns if (targpop==1), at(sexual_autonomy=(0 1 2)) predict(eq(#2)) pwcompare cmdmargins

***Contraceptive use or intention
mimrgns if (targpop==1), at(sexual_autonomy=(0 1 2)) predict(eq(#3)) cmdmargins // for contra_intention

mimrgns if (targpop==1), at(sexual_autonomy=(0 1 2)) predict(eq(#3)) pwcompare cmdmargins

***Health_care & Fertility
mimrgns if (targpop==1), at(health_care=(0 1 2)) predict(eq(#1)) cmdmargins // for children

mimrgns if (targpop==1), at(health_care=(0 1 2)) predict(eq(#1)) pwcompare cmdmargins

***Pregnancy
mimrgns if (targpop==1), at(health_care=(0 1 2)) predict(eq(#2)) cmdmargins // for pregnant

mimrgns if (targpop==1), at(health_care=(0 1 2)) predict(eq(#2)) pwcompare cmdmargins

***Contraceptive use or intention
mimrgns if (targpop==1), at(health_care=(0 1 2)) predict(eq(#3)) cmdmargins // for contra_intention

mimrgns if (targpop==1), at(health_care=(0 1 2)) predict(eq(#3)) pwcompare cmdmargins

***Participation in decision 
**Fertility
mimrgns if (targpop==1), at(res_hlt=(0 1)) predict(eq(#1)) cmdmargins // for children

mimrgns if (targpop==1), at(res_hlt=(0 1)) predict(eq(#1)) pwcompare cmdmargins

mimrgns if (targpop==1), at(res_hlt=(0 1)) predict(eq(#2)) cmdmargins // for children

mimrgns if (targpop==1), at(res_hlt=(0 1)) predict(eq(#2)) pwcompare cmdmargins

***Contraceptive use or intention
mimrgns if (targpop==1), at(res_hlt=(0 1)) predict(eq(#3)) cmdmargins // for children

mimrgns if (targpop==1), at(res_hlt=(0 1)) predict(eq(#3)) pwcompare cmdmargins
