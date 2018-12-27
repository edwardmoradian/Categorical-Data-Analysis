/* Testing a Hypothesized Distribution */
/* Testing to determine if the distribution of hair colors matches our hypothesized distribution by proportion */
/* Fair, Red, Medium, Dark and Black Hair */

ods graphics on;

data haircolor;
input color $ count@@;
datalines;
f 76 r 19 m 83 d 65 bk 3  
;
run;

proc print data=haircolor;
run;

proc freq data=haircolor order=data;
	title 'Hair Color of Children';
	weight count;							/* frequency table as count */
	tables color/ testp=(30 12 30 25 3) plots=all;	/* these are in percentage */
run;
