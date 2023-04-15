********************************************************************************
*Data set-up & multiple imputations for W4, 4.5 & 5
*Written by TIANZE SUN
*Date: 16 March 2023
********************************************************************************
********************************************************************************
*specify location
cd "\Users\s4476505\Dropbox\2022 PhD\5_PATH\Stata Files\Prevalence"

* Load Wave 4 dataset
use "Wave4_youth.dta", clear

* Merge Wave 4.5 dataset using the common variable "PERSONID"
merge 1:1 PERSONID using "Wave4point5_youth.dta"
rename _merge _mergeW4point5

* Save the merged Wave 4 and Wave 4.5 dataset
save "Wave4_and_Wave4point5_youth.dta", replace

* Load the merged Wave 4 and Wave 4.5 dataset
use "Wave4_and_Wave4point5_youth.dta"

* Merge Wave 5 dataset using the common variable "PERSONID"
* Keep only the observations that are common to the Wave 4 or Wave 4.5 dataset 
* and the Wave 5 dataset (merge type 2)
merge 1:1 PERSONID using "Wave5_youth.dta"
drop if _merge == 2
tab _merge, m
drop _merge
* Save the merged Wave 4 and Wave 4.5 and Wave 5 dataset
save "Wave4_and_Wave4point5_and_Wave5_youth.dta", replace

* Load the merged Wave 4 and Wave 4.5 dataset
use "Wave4_and_Wave4point5_and_Wave5_youth", clear

*Merge Wave 5, Wave 4 cohort all wave weights
merge 1:1 PERSONID using "weights5_wave4allwave.dta"
drop if _merge == 2
tab _merge, m

* Save the final merged dataset
save "merged_youth_weights_data.dta", replace
********************************************************************************
********************************************************************************
*RECODE exposure variables for W4 and w5
foreach i of numlist 4/5 {
	foreach j of numlist 2/9 {
		tab R0`i'_YX0203_0`j', m
		replace R0`i'_YX0203_0`j' = . if (R0`i'_YX0203_0`j' >= -99999 & R0`i'_YX0203_0`j' <= -1)
		replace R0`i'_YX0203_0`j' = 0 if R0`i'_YX0203_0`j' == 2
		replace R0`i'_YX0203_0`j' = 1 if R0`i'_YX0203_0`j' == 1
		label values R0`i'_YX0203_0`j' exposure
	}
}
*RECODE exposure variables for W4.5
foreach i of numlist 4 {
	foreach j of numlist 2/9 {
		tab X0`i'_YX0203_0`j', m
		replace X0`i'_YX0203_0`j' = . if (X0`i'_YX0203_0`j' >= -99999 & X0`i'_YX0203_0`j' <= -1)
		replace X0`i'_YX0203_0`j' = 0 if X0`i'_YX0203_0`j' == 2
		replace X0`i'_YX0203_0`j' = 1 if X0`i'_YX0203_0`j' == 1
		label values X0`i'_YX0203_0`j' exposure
	}
}
********************************************************************************
******************************outcome variable**********************************
*define label for use
label define use1 0 "no use 0" 1 "use 1"

*RECODE W4: lifetime e-cigarette use
recode R04R_Y_EVR_EPRODS (-99988/-99966 = .) (2 = 0) (1 = 1)
label values R04R_Y_EVR_EPRODS use1
tab R04R_Y_EVR_EPRODS, m

*RECODE W4.5: lifetime e-cigarette use
recode X04R_Y_EVR_EPRODS (-99988/-99966 = .) (2 = 0) (1 = 1)
label values X04R_Y_EVR_EPRODS use1
tab X04R_Y_EVR_EPRODS, m

*RECODE W5: lifetime e-cigarette use
recode R05R_Y_EVR_EPRODS (-99988/-99966 = .) (2 = 0) (1 = 1)
label values R05R_Y_EVR_EPRODS use1
tab R05R_Y_EVR_EPRODS, m
********************************************************************************
*RECODE W4: past 12 month e-cigarette use 
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
label values R04R_Y_P12M_EPRODS use1
tab R04R_Y_P12M_EPRODS, m

*RECODE W4.5: past 12 month e-cigarette use 
recode X04R_Y_P12M_EPRODS (-99988/-99977 = .) (2 = 0) (1 = 1)
label values X04R_Y_P12M_EPRODS use1
tab X04R_Y_P12M_EPRODS, m

*RECODE W5: past 12 month e-cigarette use 
recode R05R_Y_P12M_EPRODS (-99988/-99977 = .) (2 = 0) (1 = 1)
label values R05R_Y_P12M_EPRODS use1
tab R05R_Y_P12M_EPRODS, m
********************************************************************************
*RECODE W4: past 30-day e-cigarette use
recode R04R_Y_CUR_EPRODS (-99988/-99977 = .) (2 = 0) (1 = 1)
label values R04R_Y_CUR_EPRODS use1
tab R04R_Y_CUR_EPRODS, m

*RECODE W4.5: past 30-day e-cigarette use
recode X04R_Y_CUR_EPRODS (-99988/-99977 = .) (2 = 0) (1 = 1)
label values X04R_Y_CUR_EPRODS use1
tab X04R_Y_CUR_EPRODS, m

*RECODE W5: past 30-day e-cigarette use
recode R05R_Y_CUR_EPRODS (-99988/-99977 = .) (2 = 0) (1 = 1)
label values R05R_Y_CUR_EPRODS use1
tab R05R_Y_CUR_EPRODS, m
********************************************************************************
**************************control variables*************************************
**RECODE W4 & W5: parent past 30 day vaping
foreach i of numlist 4/5 {
	recode R0`i'_PN0337_01 (-10/-1 = .) (1 = 1) (2 = 0)
	label values R0`i'_PN0337_01 use1
}
tab R04_PN0337_01, m
tab R05_PN0337_01, m

**RECODE W4.5: parent past 30 day e-cigarette use
recode X04_PN0337_01 (-10/-1 = .) (1 = 1) (2 = 0)
label values X04_PN0337_01 use1
tab X04_PN0337_01, m
********************************************************************************
**RECODE W4 & W5: parent past 30 day smoking
foreach i of numlist 4/5 {
	recode R0`i'_PN0335_01 (-10/-1 = .) (1 = 1) (2 = 0)
	label values R0`i'_PN0335_01 use1
}
tab R04_PN0335_01, m
tab R05_PN0335_01, m

**RECODE W4.5: parent past 30 day smoking
recode X04_PN0335_01 (-10/-1 = .) (1 = 1) (2 = 0)
label values X04_PN0335_01 use1
tab X04_PN0335_01, m
********************************************************************************
label define peeruse 0 "none 0" 1 "some 1" 2 "most 2"
**RECODE W4 & W5: peer smoking
foreach i of numlist 4/5 {
	recode R0`i'_YX0680 (-10/-1 = .) (1 = 0) (2/3 = 1) (4/5 = 2)
	label values R0`i'_YX0680 peeruse
}
tab R04_YX0680, m
tab R05_YX0680, m

**RECODE W4.5: peer smoking
recode X04_YX0680 (-10/-1 = .) (1 = 0) (2/3 = 1) (4/5 = 2)
label values X04_YX0680 peeruse
tab X04_YX0680, m
********************************************************************************
**RECODE W4 & W5: peer vaping
foreach i of numlist 4/5 {
	recode R0`i'_YX0681 (-10/-1 = .) (1 = 0) (2/3 = 1) (4/5 = 2)
	label values R0`i'_YX0681 peeruse
}
tab R04_YX0681, m
tab R05_YX0681, m

**RECODE W4.5: peer vaping
recode X04_YX0681 (-10/-1 = .) (1 = 0) (2/3 = 1) (4/5 = 2)
label values X04_YX0681 peeruse
tab X04_YX0681, m
********************************************************************************
**RECODE W4, W4.5 & W5: sex 
tab R04R_Y_SEX_IMP, m
tab X04R_Y_SEX, m
tab R05R_Y_SEX, m

label define sexlabel 1 "male 1" 2 "female 2" 
generate Sex = .
replace Sex = 1 if R04R_Y_SEX_IMP == 1
replace Sex = 2 if R04R_Y_SEX_IMP == 2
replace Sex = 1 if X04R_Y_SEX == 1
replace Sex = 2 if X04R_Y_SEX == 2
replace Sex = 1 if R05R_Y_SEX == 1
replace Sex = 2 if R05R_Y_SEX == 2
recode Sex (-100000000/-1 = .)
label values Sex sexlabel 
tab Sex, m
********************************************************************************
**RECODE W4, W4.5 & W5: student grades
recode R04_PT0019 (-8/-1= .) (10 = .) 
recode X04_PT0019 (-8/-1= .) (10 = .)
recode R05_PT0019 (-8/-1= .) (10 = .) 
tab R04_PT0019, m
tab X04_PT0019, m
tab R05_PT0019, m
********************************************************************************
**RECODE W4, W4.5 & W5: age range
tab R04R_Y_AGECAT2, m
tab X04R_Y_AGECAT2, m
********************************************************************************
**RECODE: race
label define race1 0 "NH White 0" 1 "NH African 1" 2 "Latino 2" 3 "NH Other 3"
generate race = .
replace race = 0 if (R04R_Y_HISP == 2 & R04R_Y_RACECAT3 == 1)
replace race = 1 if (R04R_Y_HISP == 2 & R04R_Y_RACECAT3 == 2)
replace race = 2 if (R04R_Y_HISP == 1)
replace race = 3 if (R04R_Y_HISP == 2 & R04R_Y_RACECAT3 == 3)

replace race = 0 if (X04R_Y_HISP == 2 & X04R_Y_RACECAT3 == 1)
replace race = 1 if (X04R_Y_HISP == 2 & X04R_Y_RACECAT3 == 2)
replace race = 2 if (X04R_Y_HISP == 1)
replace race = 3 if (X04R_Y_HISP == 2 & X04R_Y_RACECAT3 == 3)
label values race race1
tab race, m
********************************************************************************
**RECODE: parental education for W4 & W4.5 
recode R04R_Y_PM0001 (-99999/-99911= .) 
tab R04R_Y_PM0001, m
recode X04R_P_PARSP_EDUC (-99999/-99911= .) 
tab X04R_P_PARSP_EDUC, m
********************************************************************************
**RECODE: household income for W4 & W4.5 
recode R04R_Y_PM0130 (-99999/-99911= .) 
recode X04R_Y_PM0130 (-99999/-99911= .) 
tab X04R_Y_PM0130,m 
tab R04R_Y_PM0130,m
********************************************************************************
**RECODE: alcohol  for W4 & W4.5 
replace R04_YX0673 = 0 if R04_YX0084_NB == 2
replace R04_YX0673 = 0 if R04_YX0084_12M == 2
recode R04_YX0673 (-8/-1 = .) (1 = 1) (2 = 0)
label values R04_YX0673 use1
tab R04_YX0673, m

replace X04_YX0673 = 0 if X04_YX0084_NB == 2
replace X04_YX0673 = 0 if X04_YX0084_12M == 2
recode X04_YX0673 (-8/-1 = .) (1 = 1) (2 = 0)
tab X04_YX0673, m
label values X04_YX0673 use1
tab X04_YX0673, m
********************************************************************************
**RECODE: cannabis 
replace R04_YX0675 = 0 if (R04_YX0085_NB == 2 & R04_YOUTHTYPE != 1)
replace R04_YX0675 = 0 if (R04_YG9105_NB == 2 & R04_YOUTHTYPE != 1)
replace R04_YX0675 = 0 if (R04_YH9031 == 2 & R04_YOUTHTYPE != 1)
replace R04_YX0675 = 0 if (R04_YV9042 == 2 & R04_YOUTHTYPE != 1)
replace R04_YX0675 = 0 if (R04_YX0085_12M == 2 & R04_YOUTHTYPE == 1)
replace R04_YX0675 = 0 if (R04_YG9107 == 2 & R04_YOUTHTYPE == 1)
recode R04_YX0675 (-9/-1 = .) (1 = 1) (2 = 0)
label values R04_YX0675 use1
tab R04_YX0675, m

replace X04_YX0675 = 0 if (X04_YX0085_NB == 2 & X04_YOUTHTYPE != 1)
replace X04_YX0675 = 0 if (X04_YG9105_NB == 2 & X04_YOUTHTYPE != 1)
replace X04_YX0675 = 0 if (X04_YH9031 == 2 & X04_YOUTHTYPE != 1)
replace X04_YX0675 = 0 if (X04_YV9042 == 2 & X04_YOUTHTYPE != 1)
replace X04_YX0675 = 0 if (X04_YX0085_12M == 2 & X04_YOUTHTYPE == 1)
replace X04_YX0675 = 0 if (X04_YG9107 == 2 & X04_YOUTHTYPE == 1)
recode X04_YX0675 (-8/-1 = .) (1 = 1) (2 = 0)
label values X04_YX0675 use1
tab X04_YX0675, m

* Save the CLEANED data for W4, W4.5, & W5 dataset
save "21032023 cleaned data", replace
********************************************************************************
********************************************************************************
*MULTIPLE IMPUTATIONS 
mi set flong 
mi register imputed R04_YX0203_02 R04_YX0203_03 R04_YX0203_04 R04_YX0203_05 ///
R04_YX0203_06 R04_YX0203_07 R04_YX0203_08 R04_YX0203_09 X04_YX0203_02 ///
X04_YX0203_03 X04_YX0203_04 X04_YX0203_05 X04_YX0203_06 X04_YX0203_07 ///
X04_YX0203_08 X04_YX0203_09 R05_YX0203_02 R05_YX0203_03 R05_YX0203_04 ///
R05_YX0203_05 R05_YX0203_06 R05_YX0203_07 R05_YX0203_08 R05_YX0203_09 ///
R04R_Y_EVR_EPRODS X04R_Y_EVR_EPRODS R05R_Y_EVR_EPRODS R04R_Y_P12M_EPRODS ///
X04R_Y_P12M_EPRODS R05R_Y_P12M_EPRODS R04R_Y_CUR_EPRODS X04R_Y_CUR_EPRODS ///
R05R_Y_CUR_EPRODS R04_PN0337_01 X04_PN0337_01 R05_PN0337_01 R04_PN0335_01 ///
X04_PN0335_01 R05_PN0335_01 R04_YX0680 X04_YX0680 R05_YX0680 R04_YX0681 ///
X04_YX0681 R05_YX0681 R04_PT0019 X04_PT0019 R05_PT0019 R04R_Y_AGECAT2 ///
X04R_Y_AGECAT2 R04R_Y_PM0001 X04R_P_PARSP_EDUC R04R_Y_PM0130 X04R_Y_PM0130 ///
R04_YX0673 X04_YX0673 R04_YX0675 X04_YX0675 race Sex 

mi impute chain (pmm, knn(20)) R04_YX0203_02 R04_YX0203_03 R04_YX0203_04 R04_YX0203_05 ///
R04_YX0203_06 R04_YX0203_07 R04_YX0203_08 R04_YX0203_09 X04_YX0203_02 ///
X04_YX0203_03 X04_YX0203_04 X04_YX0203_05 X04_YX0203_06 X04_YX0203_07 ///
X04_YX0203_08 X04_YX0203_09 R05_YX0203_02 R05_YX0203_03 R05_YX0203_04 ///
R05_YX0203_05 R05_YX0203_06 R05_YX0203_07 R05_YX0203_08 R05_YX0203_09 ///
R04R_Y_EVR_EPRODS X04R_Y_EVR_EPRODS R05R_Y_EVR_EPRODS R04R_Y_P12M_EPRODS ///
X04R_Y_P12M_EPRODS R05R_Y_P12M_EPRODS R04R_Y_CUR_EPRODS X04R_Y_CUR_EPRODS ///
R05R_Y_CUR_EPRODS R04_PN0337_01 X04_PN0337_01 R05_PN0337_01 R04_PN0335_01 ///
X04_PN0335_01 R05_PN0335_01 R04_YX0680 X04_YX0680 R05_YX0680 R04_YX0681 ///
X04_YX0681 R05_YX0681 R04_PT0019 X04_PT0019 R05_PT0019 R04R_Y_AGECAT2 ///
X04R_Y_AGECAT2 R04R_Y_PM0001 X04R_P_PARSP_EDUC R04R_Y_PM0130 X04R_Y_PM0130 ///
R04_YX0673 X04_YX0673 R04_YX0675 X04_YX0675 race Sex, add(50) rseed(12345) noisily augment

save "21032023 imputed.dta", replace

