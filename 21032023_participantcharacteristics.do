********************************************************************************
*PARTICIPANT CHARACTERISTICS 
*Written by TIANZE SUN
*Date: 21 March 2023
********************************************************************************
********************************************************************************
*specify location
cd "\Users\s4476505\Dropbox\2022 PhD\5_PATH\Stata Files\Prevalence"

* Load combined, imputed dataset
use "16032023 imputed.dta", clear
use "16032023 cleaned data", clear


*svyset your data using the new weight variable:
mi svyset VARPSU [pweight=R05_Y_S04WGT], strata(VARSTRAT)
svyset [pweight=R05_Y_S04WGT], psu(VARPSU) strata(VARSTRAT)

********************************************************************************
********************************************************************************
**DEMOGRAPHICS for W4
**AGE GROUP
svy: tab R04R_Y_AGECAT2, ci
tab R04R_Y_AGECAT2, m

**SEX
tab Sex, m
svy: tab Sex, ci

**ETHINICITY
tab Race, m

**ACADEMIC PERFORMANCE
tab R04_PT0019

**HOUSEHOLD INCOME
tab R04R_Y_PM0130, m

**PARENTAL EDUCATION
tab R04R_Y_PM0001, m
tab X04R_P_PARSP_EDUC, m

**PARENTAL USE OF CIGARETTES
tab R04_PN0335_01, m

**NUMBER OF BEST FRIENDS THAT SMOKE
tab R04_YX0680, m

**NUMBER OF BEST FRIENDS THAT VAPE
tab R04_YX0681, m

**ALCOHOL USE IN THE PAST 30-DAYS
tab R04_YX0673, m

**CANNABIS USE IN THE PAST 30-DAYS
tab R04_YX0675, m
********************************************************************************
**EXPOSURE VARIABLES FOR W4, W4.5 & W5
**EXPOSURE TO E-CIGARETTE MARKETING AT: GAS STATIONS
svy: tab R04_YX0203_02, ci
svy: tab X04_YX0203_02, ci
svy: tab R05_YX0203_02, ci
tab R04_YX0203_02
tab X04_YX0203_02
tab R05_YX0203_02
**EXPOSURE TO E-CIGARETTE MARKETING AT: BILLBOARDS
tab R04_YX0203_03
tab X04_YX0203_03
tab R05_YX0203_03
**EXPOSURE TO E-CIGARETTE MARKETING AT: NEWSPAPERS/MAGAZINES
tab R04_YX0203_04
tab X04_YX0203_04
tab R05_YX0203_04
**EXPOSURE TO E-CIGARETTE MARKETING AT: RADIO
tab R04_YX0203_05
tab X04_YX0203_05
tab R05_YX0203_05
**EXPOSURE TO E-CIGARETTE MARKETING AT: TV
tab R04_YX0203_06
tab X04_YX0203_06
tab R05_YX0203_06
**EXPOSURE TO E-CIGARETTE MARKETING AT: EVENTS
tab R04_YX0203_07
tab X04_YX0203_07
tab R05_YX0203_07
**EXPOSURE TO E-CIGARETTE MARKETING AT: NIGHTCLUBS, BARS, MUSIC CONCERTS
tab R04_YX0203_08
tab X04_YX0203_08
tab R05_YX0203_08
**EXPOSURE TO E-CIGARETTE MARKETING AT: SOCIAL MEDIA/WEBSITES
tab R04_YX0203_09
tab X04_YX0203_09
tab R05_YX0203_09
********************************************************************************
