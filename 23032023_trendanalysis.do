********************************************************************************
*EXPOSURE VARIABLES TREND ANALYSIS 
*Written by TIANZE SUN
*Date: 23 March 2023
********************************************************************************
********************************************************************************
*Specify location
cd "\Users\s4476505\Dropbox\2022 PhD\5_PATH\Stata Files\23032023_files"
********************************************************************************
********************************************************************************
*WAVE 4 TREND ANALYSES
*Load Wave 4 dataset
use "Wave4_youth.dta", clear

*Merge weights (W4, wave 4 cohort, cross-sectional analyses)
merge 1:1 PERSONID using "weights4_CrossSectional.dta"
tab _merge, m
*svyset your data using the new weight variable:
svyset VARPSU [pweight=R04_Y_C04WGT], strata(VARSTRAT)
********************************************************************************
**EXPOSURE VARIABLES FOR W4
**EXPOSURE TO E-CIGARETTE MARKETING AT: 
**GAS STATIONS
svy: tab R04_YX0203_02, ci
**BILLBOARDS
svy: tab R04_YX0203_03, ci
** NEWSPAPERS/MAGAZINES
svy: tab R04_YX0203_04, ci
** RADIO
svy: tab R04_YX0203_05, ci
** TV
svy: tab R04_YX0203_06, ci
** EVENTS
svy: tab R04_YX0203_07, ci
** NIGHTCLUBS, BARS, MUSIC CONCERTS
svy: tab R04_YX0203_08, ci
** SOCIAL MEDIA/WEBSITES
svy: tab R04_YX0203_09, ci
**LIFETIME E-CIGARETTE USE
svy: tab R04R_Y_EVR_EPRODS, ci
**PAST 12 MONTHS
generate R04R_Y_P12M_EPRODS = .

replace R04R_Y_P12M_EPRODS = 1 if R04R_Y_EVR_EPRODS == 1 | R04_YV1002_12M == 1 ///
| R04_YV1112 == 1 | R04_YV1112 == 2 | R04_YV1112 == 3 | R04_YV1112 == 4 | R04_YV1112 == 5

replace R04R_Y_P12M_EPRODS = 0 if R04_YV1001_NB == 2 | R04_YV1002_NB == 2 ///
| R04R_Y_EVR_EPRODS == 2 | R04_YV1112 == 6 | R04_YV1112 == 7 

replace R04R_Y_P12M_EPRODS = -99999 if R04_YV1001_NB == -9 | R04_YV1002_NB == -9 ///
| R04_YV1002_12M == -9 | R04_YV1112 == -9 | R04R_Y_EVR_EPRODS == -99999

replace R04R_Y_P12M_EPRODS = -99988 if R04_YV1001_NB == -8 | R04_YV1002_NB == -8 ///
| R04_YV1002_12M == -8 | R04_YV1112 == -8 | R04R_Y_EVR_EPRODS == -99988

replace R04R_Y_P12M_EPRODS = -99977 if R04_YV1001_NB == -7 | R04_YV1002_NB == -7 ///
| R04_YV1002_12M == -7 | R04_YV1112 == -7 | R04R_Y_EVR_EPRODS == -99977

replace R04R_Y_P12M_EPRODS = -99966 if R04R_Y_EVR_EPRODS == -99966

recode R04R_Y_P12M_EPRODS (-99988/-99966 = .) 
svy: tab R04R_Y_P12M_EPRODS, ci
**PAST 30-DAYS
svy: tab R04R_Y_CUR_EPRODS, ci
********************************************************************************
********************************************************************************
*WAVE 4.5 TREND ANALYSES
*Load Wave 4.5 dataset
use "Wave4point5_youth.dta", clear

*Merge weights (W4.5, wave 4 cohort, single-wave/all-waves for cross sectional analyses)
merge 1:1 PERSONID using "weights4point5_wave4cohort.dta"
tab _merge, m
*svyset your data using the new weight variable:
svyset VARPSU [pweight=X04_Y_S04WGT], strata(VARSTRAT)
********************************************************************************
**EXPOSURE VARIABLES FOR W4.5
**EXPOSURE TO E-CIGARETTE MARKETING AT: 
**GAS STATIONS
svy: tab X04_YX0203_02, ci
**BILLBOARDS
svy: tab X04_YX0203_03, ci
** NEWSPAPERS/MAGAZINES
svy: tab X04_YX0203_04, ci
** RADIO
svy: tab X04_YX0203_05, ci
** TV
svy: tab X04_YX0203_06, ci
** EVENTS
svy: tab X04_YX0203_07, ci
** NIGHTCLUBS, BARS, MUSIC CONCERTS
svy: tab X04_YX0203_08, ci
** SOCIAL MEDIA/WEBSITES
svy: tab X04_YX0203_09, ci
**LIFETIME E-CIGARETTE USE
svy: tab X04R_Y_EVR_EPRODS, ci
**PAST 12 MONTHS
svy: tab X04R_Y_P12M_EPRODS, ci
**PAST 30-DAYS
svy: tab X04R_Y_CUR_EPRODS, ci
********************************************************************************
********************************************************************************
*WAVE 5 TREND ANALYSES
*Load Wave 5 dataset
use "Wave5_youth.dta", clear

*Merge weights (W5, wave 4 cohort single-wave/all-waves for cross-sectional analysis)
merge 1:1 PERSONID using "weights5_wave4singlewavecohort.dta"

*svyset your data using the new weight variable:
svyset VARPSU [pweight=R05_Y_S04WGT], strata(VARSTRAT)
********************************************************************************
**EXPOSURE VARIABLES FOR W5
**EXPOSURE TO E-CIGARETTE MARKETING AT: 
**GAS STATIONS
svy: tab R05_YX0203_02, ci
**BILLBOARDS
svy: tab R05_YX0203_03, ci
** NEWSPAPERS/MAGAZINES
svy: tab R05_YX0203_04, ci
** RADIO
svy: tab R05_YX0203_05, ci
** TV
svy: tab R05_YX0203_06, ci
** EVENTS
svy: tab R05_YX0203_07, ci
** NIGHTCLUBS, BARS, MUSIC CONCERTS
svy: tab R05_YX0203_08, ci
** SOCIAL MEDIA/WEBSITES
svy: tab R05_YX0203_09, ci
**LIFE E-CIGARETTE USE
svy: tab R05R_Y_EVR_EPRODS, ci
**PAST 12 MONTHS
svy: tab R05R_Y_P12M_EPRODS, ci
**PAST 30-DAYS
svy: tab R05R_Y_CUR_EPRODS, ci
********************************************************************************

