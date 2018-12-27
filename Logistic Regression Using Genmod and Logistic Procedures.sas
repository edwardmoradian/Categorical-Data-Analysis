data admission;
	input major $ sex $ total admitted@@;
	datalines;
A M 825 512 B M 560 353 C M 325 120 D M 417 138 E M 191 53 F M 373 22
A F 108 89  B F 25  17  C F 593 201 D F 375 131 E F 393 94 F F 341 24
;

** fit the full model;
proc genmod data=admission;
	class major sex;
	model admitted/total = major|sex / dist=bin link=logit;
run;

** no interaction between two factors - major and sex;
proc genmod data=admission;
	class major sex;
	model admitted/total = major sex / dist=bin link=logit;
run;

** Using proc logistic for linear contrast statements;
proc logistic data=admission;
	class major(param=ref ref='F') sex(param=ref ref='M'); * choose baseline sex as M;
	model admitted/total=major /*|*/ sex; 	/* use contrasts only with additive models */
	contrast 'A vs Others' major -5 1 1 1 1 1; 
run;

proc logistic data=admission;
	class major sex(param=ref); * can choose baseline as F by ref='F';
	model admitted/total=major|sex;
	contrast 'A vs Others' major -5 1 1 1 1 1; 
run;