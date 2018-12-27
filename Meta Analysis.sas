/*
Meta Analysis:
Does the effect of treatment on the respiratory improvement differ for the 2 centers?
Response is whether there was an improvement in respiratory function (y/n)
*/

data respire;
input center trtmnt $ response $ count @@;
datalines;
1 test y 29 1 test n 16
1 placebo y 14 1 placebo n 31
2 test y 37 2 test n 8
2 placebo y 24 2 placebo n 21
;
run;
proc freq order=data data=respire;
	weight count;
	tables center*trtmnt*response/all;
run;
