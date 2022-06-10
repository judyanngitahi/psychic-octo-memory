* this is a dataset from sage publishing that has binary values for marital and health and gender, and then data on age and education. going to use it to run logit and probit models with health as the outcome variable, and the rest as explanatory variables 

clear all
set more off

* to create a log file 
log using probitlogit, text replace

use /Users/judygitahi/Desktop/Learning/Econometrics/psychic-octo-memory/probitdata

describe
summarize 

* to show the outcomes that are binary, 
tab healths maritals

logit healths maritals

* or asks to report odss ratios and fitstat calculate the various measures of fit for a model and summarises in a table format
logit healths maritals, or
fitstat

xi: logit healths i.marital age
xi: logit healths i.marital age, or
fitstat

* this command shows a classification table for the model, and the ability of the model to correctly predict y = 1 and y =0 
* in this case, the sensitivity is 100% but the specificoty is 0% meaning those who have health=1 are always correctly predicted while those with health=0 are always wrognly predicted
estat class

* Hosmer–Lemeshow goodness-of-fit test which calculates if the observed event rates match the expected event rates in population subgroups, and gives a probability for when this matches
*https://www.statisticshowto.com/hosmer-lemeshow-test/
estat gof,group(10) table

* Pearson goodness-of-fit test for current estimation results to evaluate how likely it is that any observed difference between the sets arose by chance
* in this case there is indeed a likely relationship 
estat gof, all

*add more expalantory variables to the multiple regression 
xi: logit healths i.marital age educ male
xi: logit healths i.marital age educ male, or
fitstat
estat class
estat gof,group(10) table

* estimate marginal effects 
quietly xi: logit healths i.marital age educ male
margins, dydx(*) atmeans
margins, dydx(*)

quietly xi: logit healths i.marital age educ male
predict plogit, pr

summarize healths plogit

