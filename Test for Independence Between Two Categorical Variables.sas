/* 
Test for Independence Between Two Categorical Variables:
Does taking aspirin regularly reduce the risk of heart attack significantly?
Response is whether or not patient suffered a heart attack
From independent binomial sampling
*/

data aspirin;
input group $ response $ count;
datalines;
placebo yes 189 
placebo no 10845
aspirin yes 104 
aspirin no 10933
;

proc print data=aspirin;
run;

proc freq data=aspirin order=data; 
** use the order we input**;
	weight count;
	tables group*response/cellchi2 crosslist(stdres) expected measures;
**standardized Pearson residuals, expected counts and (measures: RR (Relative Risk), odds ratio and so on) **;
/* cellchi2 gives (Eij)^2, Pearson Residual squared */
exact chisq fisher or; * Requests Exact(good for small data)Chi-square and Fisher's exact test and CI for the ORs (Odds Ratios);
run;
