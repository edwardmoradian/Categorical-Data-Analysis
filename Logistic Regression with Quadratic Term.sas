data beetle;
	input dose total dead;
	ratio= dead/total;
	dose2=dose*dose; /* quadratic term */
	datalines;
1.6907 59 6
1.7242 60 13
1.7552 62 18
1.7842 56 28
1.8113 63 52
1.8369 59 53
1.8610 62 61
1.8839 60 60
;
run;

proc genmod data=beetle;
model dead/total = dose / dist=bin link=logit p r covb;
output out=a pred=pi_hat stdresdev=stred;
run;

proc print data=a;
run;

** fit quadratic regression with quadratic term;
proc genmod data=beetle;
model dead/total = dose dose2/ dist=bin link= logit;
run;
