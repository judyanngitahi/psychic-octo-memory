* Acemoglu, Johnson and Robinson (2001) use settler mortality to estimate the effect that institutions have on economic development. There was likely more settlement in areas where there was a less threat to mortality, and therefore institutions were likely established in these places. Mortality rates are thus an instrument for current institutions
* dataset and isntructions are from http://www.guoxu.org/teaching/EC307/AJR.zip

use /Users/judygitahi/Desktop/Learning/Econometrics/psychic-octo-memory/AJR 

describe 
summarize

* the relationship between income and protection from expropriation. the realtionship is positive, meaning more protection from expropriation will result in higher income
scatter logpgp95 avexpr
lfit logpgp95 avexpr
twoway (scatter logpgp95 avexpr) (lfit logpgp95 avexpr)

* the relationship between income and setller mortality is negative, meaning higher settler mortality is related to lower income
scatter logpgp95 logem4
lfit logpgp95 logem4
twoway (scatter logpgp95 logem4) (lfit logpgp95 logem4)


* closer look at the realtionship between average risk of expropriation and income
* increasing the expropriation score by 1 will increase GDP by 51%, relationship is significant, but reverse causlity or endogeneity of institutions is possible

reg logpgp95 avexpr

* so we need to establish a causal relation between institutions to economic development using IV that's related to institutions (relevant) but unrelated to gdp(exogenous)

*to test for relevance
twoway(scatter logem4 avexpr) (lfit logem4 avexpr)

* first stage regression we test relationship between settler mortality and exproriation that is the IV and the explanatory value to extract the exogenous part of institutions that is driven by settler mortality
* in the second stage, we use this extrated infuence of settler mortality to expalin gdp levels

ivregress 2sls logpgp95 (avexpr=logem4), first
