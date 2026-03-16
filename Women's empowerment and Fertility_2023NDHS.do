
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
egen healthcare = rowtotal(bhcpermit bhcmoney bhcdistance bhcalone insurance)
ta healthcare 
recode healthcare (0/1=0 "Low access")(2/3=1 "Moderate access")(4/5=2 "High access"), gen(health_care)
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
recode v613 (0/2=0 "0-2")(3/30=1 "3+")(else=2 "God/Allah/fate wills/uncertain/Don't know"), gen(ideal_child)
ta ideal_child

***Total children ever born
clonevar cheb = v201
recode cheb (0=0 "Childless")(else=1 "Non-childless"), gen(children)
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

**Keep variables
keep survey clusterno strata perweight wt1 wt2 dvweight marry pregnant contra_intention dvmodule age familyplan health_care neweduclvl newhusedlvl sexual_autonomy massmediaa res_hlt polygamy wealthindex ethnic rel residence region child_desire violence ideal_child children abortion 

***Save data
save dhs_2023, replace
