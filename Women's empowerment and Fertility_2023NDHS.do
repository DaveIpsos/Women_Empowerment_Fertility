
*************************************************************************************************************************************
*************************************************************************************************************************************
*Title: Women's empowerment Indicators and High-risk Fertility Behaviors among Married Adolescent Girls in Northern Nigeria
*Code Author: David Aduragbemi Okunlola 
*Institution: Department of Sociology, Florida State University, Tallahassee, USA
*Year: 2025/2026
*Survey year: 2023 Nigeria Demographic and Health Survey (NDHS)
*************************************************************************************************************************************
*************************************************************************************************************************************

**2023 NDHS

set maxvar 8000

use "NGIR8AFL", clear

****Generating survey*****
gen survey = 2023

*****Generating cluster and strata
gen dvweight = d005/1000000
clonevar clusterno = v001
clonevar strata = v022

***Violence Module
clonevar dvmodule = v044

set more off

**Marital Status
fre v501
recode v501 (0=0 "Never married")(1=1 "Married")(2=2 "Partnered")(else=3 "Others"), gen(marry)
fre marry

**Pregnancy
fre v213
clonevar pregnant = v213

***Contraceptive use and intention
fre v364
clonevar fpusintent = v364
recode fpusintent (1/3=1 "User/intent")(4=0 "Non-user/no intent"), gen(contra_intention)
fre contra_intention

*Fertility knowledge: dichotomize v217 (ovulatory cycle) & v244 (post-partumfecundability) into correct Y/N
fre v217
clonevar ovcycle = v217
recode ovcycle (3=1 "Yes")(1/2 4/7=0 "No")(else=.), gen(fertile)
ta fertile

***Exposure to family planning messages
fre v384a v384b v384c
clonevar fpradiohr = v384a
clonevar fptvhr = v384b
clonevar fpnewshr = v384c
egen famplan = rowtotal(fpradiohr fptvhr fpnewshr /*fpmobpsahr fpcrierhr*/)
ta famplan
recode famplan (0=0 "Unexposure")(1/3=1 "Exposed")(else=.), gen(familyplan)
ta familyplan

***Access to healthcare
***Insurance coverage
fre v481
clonevar insurance = v481
fre insurance

**Getting medical help for self: getting permission to go
fre v467b v467b v467d v467f
recode v467b (1=0)(2=1), gen(bhcpermit)
***Ability to get medical help
recode v467b (1=0)(2=1), gen(bhcmoney)
**Getting medical help for self: distance to health facility
recode v467d (1=0)(2=1), gen(bhcdistance)
**getting medical help for self: not wanting to go alone
recode v467f (1=0)(2=1), gen(bhcalone)

**Health service intercations
fre v393 v394
clonevar fphomvisity = v393
clonevar fphcvisity = v394
egen healthcare = rowtotal(bhcpermit bhcmoney bhcdistance bhcalone /*insurance*/)
ta healthcare 
recode healthcare (0/1=0 "Low ease of access")(2=1 "Moderate ease of access")(3/4=2 "High ease of access"), gen(health_care)
fre health_care

****Educational levels
fre v106 v701
clonevar educlvl = v106
clonevar husedlvl = v701
recode educlvl husedlvl (0/1 8 = 0 "< Secondary/ Don't know")(2/3 = 1 "Secondary +")(else =.), pre(new) label(newrep)
fre neweduclvl newhusedlvl

**Sexual agency
fre v822 v850a v850b
clonevar conaskifsti = v822
clonevar sxcanrefuse = v850a
clonevar conaskpar = v850b

recode sxcanrefuse conaskifsti conaskpar (0 8=0 "No/don't know")(1=1 "Yes")(else=.), pre(new) label(newrep)
fre newsxcanrefuse newconaskifsti newconaskpar
egen sexual_aut = rowtotal(newsxcanrefuse newconaskifsti newconaskpar)
clonevar sexautonom = sexual_aut
replace sexautonom=. if (sexual_aut==0 & newsxcanrefuse==. & newconaskifsti==. & newconaskpar==.)
ta sexautonom 
recode sexautonom (0/1=0 "Low agency")(2=1 "Moderate")(3=2 "High agency")(else=.), gen(sexual_autonomy)
fre sexual_autonomy

****expsosure to social and mass media
fre v157 v158 v159
clonevar newsfq = v157
clonevar tvfq = v159
clonevar radiofq = v158
recode newsfq tvfq radiofq (0=0 "No exposure")(1/2=1 "Exposed")(else=.), pre(new) label(newrep)
fre newnewsfq newtvfq newradiofq
egen mass_media = rowtotal(newnewsfq newtvfq newradiofq)
recode mass_media (0=0 "Unexposed")(1/3=1 "Exposed"), gen(massmediaa)
fre massmediaa

**Household decision making participation
fre v743a
recode v743a (1/2=1 "Participate in decision")(4/6=0 "Others")(else=.), gen(res_hlt)
ta res_hlt

****Type of marriage
fre v505
recode v505 (0 98=0 "Monogamy/Don't know")(1/6=1 "Polygamous")(else=.), gen(polygamy)
ta polygamy

***Unions
fre v503
gen multi_unions = v503==2
replace multi_unions=. if v503==.
ta multi_unions

***Wealth index
fre v190
clonevar wealthindex = v190
fre wealthindex

**Ethnicity
fre v131
recode v131 (109 130 179=1 "Hausa/Fulani/Kanuri")(else=0 "Non-Hausa/Fulani/others"), gen(ethnic)
ta ethnic 

**Religion
fre v130
recode v130 (3=1 "Islam")(else=0 "Non-muslims/others"), gen(rel)
ta rel

**Residence
clonevar residence = v025
ta residence

*Region
clonevar region = v024
ta region

*****Husband desire for children
fre v621
recode v621 (1=1 "Both want same")(2=2 "Husband wants more")(3=3 "Husband wants fewer")(8=7 "Don't know")(else=.), gen(child_desire)
ta child_desire

***Violence
****Emotional violence
fre d103a d103b d103c
foreach var in d103a d103b d103c {
gen evio_`var'=0 if (`var' == 0)
replace evio_`var'=1 if (`var' > 0 & `var' !=.)
}
egen emotional = rowtotal(evio_*)
gen emot = emotional
replace emot=. if (emotional==0) & (evio_d103a==. & evio_d103b==. & evio_d103c==.)
ta emot
recode emot (0=0 "No")(1/3=1 "Yes")(else=.), gen(newdveever)
ta newdveever

****Any severe or less severe violence
fre d105a d105b d105c d105d d105e d105f d105j
foreach var in d105a d105b d105c d105d d105e d105f d105j {
gen vio_`var'=0 if (`var' == 0)
replace vio_`var'=1 if (`var' > 0 & `var' !=.)
}
egen physical = rowtotal(vio_*)
gen phy = physical
replace phy=. if (vio_d105b==. & vio_d105c==. & vio_d105d==. & vio_d105e==. & vio_d105f==. & vio_d105j==.) & (physical==0)
ta phy
recode phy (0=0 "No")(1/7=1 "Yes")(else=.), gen(newphysical)
ta newphysical

***Sexual violence
fre d105h d105i d105k
foreach var in d105h d105i d105k {
gen svio_`var'=0 if (`var' == 0)
replace svio_`var'=1 if (`var' > 0 & `var' !=.)
}
egen sexual = rowtotal(svio_*)
gen sexy = sexual
replace sexy=. if (sexual==0) & (svio_d105h==. & svio_d105i==. & svio_d105k==.)
ta sexy
recode sexy (0=0 "No")(1/3=1 "Yes")(else=.), gen(newsexy)
ta newsexy

gen violence =.
replace violence=1 if (newdveever==1 | newphysical==1 | newsexy==1)
replace violence=0 if (newdveever==0 & newphysical==0 & newsexy==0)
ta violence

clonevar newdvpsexever = newsexy

***Ideal number of children
fre v613
recode v613 (0/2=0 "0-2")(3/4=1 "3-4")(5/6=2 "5-6")(6/30=3 "6+")(else=4 "God/Allah/fate wills/uncertain/Don't know"), gen(ideal_child)
ta ideal_child

***Total children ever born
clonevar cheb = v201
recode cheb (0=0 "Childless")(else=1 "Parous"), gen(children)
fre children

***Abortion
fre v228
clonevar abortion = v228

**Age
clonevar age = v012
fre age
la def age 15 "15 years" 16 "16 years" 17 "17 years"
la val age age
fre age


**********************************************************************
* Stage A *** Compile parameters/inputs for Level-weights calculations
**********************************************************************
* a_c_h completed clusters by strata
gen a_c_h=.
quietly levelsof v022, local(lstrata)
quietly foreach ls of local lstrata {
tab v021 if v022==`ls', matrow(T)
scalar stemp=rowsof(T)
replace a_c_h=stemp if v022==`ls'
}

gen A_h = 0
replace A_h = 3040 if v022 == 1
replace A_h = 11743 if v022 == 2
replace A_h = 4539 if v022 == 3
replace A_h = 19234 if v022 == 4
replace A_h = 14760 if v022 == 5
replace A_h = 4229 if v022 == 6
replace A_h = 2035 if v022 == 7
replace A_h = 7084 if v022 == 8
replace A_h = 3799 if v022 == 9
replace A_h = 10686 if v022 == 10
replace A_h = 3851 if v022 == 11
replace A_h = 7658 if v022 == 12
replace A_h = 2576 if v022 == 13
replace A_h = 15685 if v022 == 14
replace A_h = 9625 if v022 == 15
replace A_h = 18684 if v022 == 16
replace A_h = 17799 if v022 == 17
replace A_h = 23380 if v022 == 18
replace A_h = 8436 if v022 == 19
replace A_h = 20025 if v022 == 20
replace A_h = 3715 if v022 == 21
replace A_h = 12225 if v022 == 22
replace A_h = 1806 if v022 == 23
replace A_h = 13321 if v022 == 24
replace A_h = 3128 if v022 == 25
replace A_h = 9773 if v022 == 26
replace A_h = 5179 if v022 == 27
replace A_h = 15210 if v022 == 28
replace A_h = 6682 if v022 == 29
replace A_h = 3901 if v022 == 30
replace A_h = 3412 if v022 == 31
replace A_h = 7106 if v022 == 32
replace A_h = 5345 if v022 == 33
replace A_h = 7986 if v022 == 34
replace A_h = 5469 if v022 == 35
replace A_h = 7093 if v022 == 36
replace A_h = 6466 if v022 == 37
replace A_h = 14305 if v022 == 38
replace A_h = 3456 if v022 == 39
replace A_h = 13659 if v022 == 40
replace A_h = 5130 if v022 == 41
replace A_h = 5243 if v022 == 42
replace A_h = 7522 if v022 == 43
replace A_h = 5337 if v022 == 44
replace A_h = 3169 if v022 == 45
replace A_h = 6416 if v022 == 46
replace A_h = 8483 if v022 == 47
replace A_h = 4815 if v022 == 48
replace A_h = 5053 if v022 == 49
replace A_h = 10520 if v022 == 50
replace A_h = 7717 if v022 == 51
replace A_h = 8378 if v022 == 52
replace A_h = 2931 if v022 == 53
replace A_h = 1638 if v022 == 54
replace A_h = 4738 if v022 == 55
replace A_h = 3264 if v022 == 56
replace A_h = 10214 if v022 == 57
replace A_h = 2930 if v022 == 58
replace A_h = 7259 if v022 == 59
replace A_h = 1813 if v022 == 60
replace A_h = 14120 if v022 == 61
replace A_h = 3500 if v022 == 62
replace A_h = 4181 if v022 == 63
replace A_h = 1122 if v022 == 64
replace A_h = 32280 if v022 == 65
replace A_h = 1121 if v022 == 66
replace A_h = 21572 if v022 == 67
replace A_h = 4167 if v022 == 68
replace A_h = 6610 if v022 == 69
replace A_h = 3847 if v022 == 70
replace A_h = 10093 if v022 == 71
replace A_h = 2156 if v022 == 72
replace A_h = 16086 if v022 == 73
replace A_h = 4452 if v022 == 74

* M_h average number of households per cluster by strata
gen M_h = 0
replace M_h = 210 if v022== 1
replace M_h = 870 if v022== 2
replace M_h = 210 if v022== 3
replace M_h = 1020 if v022== 4
replace M_h = 870 if v022== 5
replace M_h = 270 if v022== 6
replace M_h = 210 if v022== 7
replace M_h = 720 if v022== 8
replace M_h = 300 if v022== 9
replace M_h = 750 if v022== 10
replace M_h = 330 if v022== 11
replace M_h = 660 if v022== 12
replace M_h = 150 if v022== 13
replace M_h = 930 if v022== 14
replace M_h = 480 if v022== 15
replace M_h = 810 if v022== 16
replace M_h = 570 if v022== 17
replace M_h = 780 if v022== 18
replace M_h = 330 if v022== 19
replace M_h = 840 if v022== 20
replace M_h = 240 if v022== 21
replace M_h = 840 if v022== 22
replace M_h = 150 if v022== 23
replace M_h = 960 if v022== 24
replace M_h = 240 if v022== 25
replace M_h = 810 if v022== 26
replace M_h = 360 if v022== 27
replace M_h = 870 if v022== 28
replace M_h = 690 if v022== 29
replace M_h = 390 if v022== 30
replace M_h = 390 if v022== 31
replace M_h = 690 if v022== 32
replace M_h = 480 if v022== 33
replace M_h = 630 if v022== 34
replace M_h = 510 if v022== 35
replace M_h = 570 if v022== 36
replace M_h = 450 if v022== 37
replace M_h = 750 if v022== 38
replace M_h = 270 if v022== 39
replace M_h = 900 if v022== 40
replace M_h = 570 if v022== 41
replace M_h = 480 if v022== 42
replace M_h = 690 if v022== 43
replace M_h = 450 if v022== 44
replace M_h = 390 if v022== 45
replace M_h = 630 if v022== 46
replace M_h = 750 if v022== 47
replace M_h = 360 if v022== 48
replace M_h = 390 if v022== 49
replace M_h = 780 if v022== 50
replace M_h = 600 if v022== 51
replace M_h = 570 if v022== 52
replace M_h = 570 if v022== 53
replace M_h = 300 if v022== 54
replace M_h = 630 if v022== 55
replace M_h = 420 if v022== 56
replace M_h = 960 if v022== 57
replace M_h = 240 if v022== 58
replace M_h = 900 if v022== 59
replace M_h = 180 if v022== 60
replace M_h = 1020 if v022== 61
replace M_h = 240 if v022== 62
replace M_h = 750 if v022== 63
replace M_h = 180 if v022== 64
replace M_h = 1470 if v022== 65
replace M_h = 60 if v022== 66
replace M_h = 1170 if v022== 67
replace M_h = 210 if v022== 68
replace M_h = 720 if v022== 69
replace M_h = 390 if v022== 70
replace M_h = 960 if v022== 71
replace M_h = 180 if v022== 72
replace M_h = 1050 if v022== 73
replace M_h = 240 if v022== 74

* m_c total number of completed households (added from the HR dataset)
gen m_c= 40047
* M total number of households in country
gen M = 55529028
* S_h households selected per stratum
gen S_h = 30
gen DHSwt = v005 / 1000000

**********************************************************************
* Stage B *** Approximate Level-weights ***
**********************************************************************
* Steps to approximate Level-1 and Level-2 weights from Household or Individual Weights
*Step 1. De-normalize the final weight, using approximated normalization factor
gen d_HH = DHSwt * (M/m_c)
*Step 2. Approximate the Level-2 weight
* f the variation factor
gen f = d_HH / ((A_h/a_c_h) * (M_h/S_h))
* Calculating the level-weights based on different values of alpha
scalar alpha = 0.5
gen wt2 = (A_h/a_c_h)*(f^alpha)
*** 3 ***************************
gen wt1 = d_HH/wt2

clonevar perweight = DHSwt

**Keep variables
keep survey clusterno strata perweight wt1 wt2 dvweight marry pregnant contra_intention dvmodule age familyplan health_care neweduclvl newhusedlvl sexual_autonomy massmediaa res_hlt polygamy wealthindex ethnic rel residence region child_desire violence ideal_child children abortion 

***Save data
save dhs_2023, replace
