/* 
Test for Agreement:
Does the results from the 1st survey agree with the results from the 2nd survey?
Repeated measures for same subjects
Response is either a for agreement or d for disagreement in two different surveys
*/
ods graphics on;

proc format;
value $opinion 	'a'='approval'
				'd'='disapproval';

data prime_minister;
input first $ second $ count@@;
format first $opinion. second $opinion.;
datalines;
a a 794 a d 150
d a 86 d d 570
;
run;

/* McNemars Test with exact p-value and Kappa coefficient */

proc freq data=prime_minister;
exact mcnem;
weight count;
table first*second/agree plots=all;
run;
