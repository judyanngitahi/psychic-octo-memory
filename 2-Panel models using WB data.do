* using a world bank merged and cleaned datatset, I am going to estimate the determinants of life expectancy on a global dataset and panel methods. 

clear all
set more off

use /Users/judygitahi/Desktop/Learning/Econometrics/psychic-octo-memory/wbmerged
 
* change GDP into log format and encode data source into ids since they are currently in strign format
gen logGDP =ln(GDPCapita)
encode datasource, gen(id)

global id id
global t Year
global ylist life_expect_total
global xlist logGDP healthspend infant_mortality literacy_rate HIV_prevalence Physicians water_use

describe 
summarize 

describe $id $t $ylist $xlist
summarize $id $t $ylist $xlist

sort $id $t
xtset $id $t
xtdescribe

xtsum $id $t $ylist $xlist

*pooled OLS estimator
reg $ylist $xlist


*popualtion averaged estimator
xtreg $ylist $xlist, pa

xtreg $ylist $xlist, be

xtreg $ylist $xlist, fe
*with the fixed effects, 93% of the variance is due to coutnry specific factors affecting life expectancy

reg D.($ylist $xlist), noconstant

* the random effects model here also has a high theta which is is good
xtreg $ylist $xlist, re theta

* Breusch-Pagan LM test to test the linear model assumption of heterskedasticity, that is would a linear model be better and is the variance of the random effect zero. this is significant meaning the variance is significantly not zero, so a panel model is more suitable. Hausmann test checks which would be more suitable, re or fe
quietly xtreg $ylist $xlist, re
xttest0


* haussman test shows there is no systematic difference between countries  meaning whatever the cause of hgiher or lower life expectancy in certain countries, it has no systematic relationship to the regressors. this means a re model is better suited for this estimation
quietly xtreg $ylist $xlist, fe
estimates store fixed
quietly xtreg $ylist $xlist, re
estimates store random

hausman fixed random




