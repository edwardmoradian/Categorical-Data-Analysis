*** Logistic regression for ordinal factors;
*** Concept of saturated model;
*** Table 4.2 (Categorical Data Analysis by Agresti, 2nd edition);


data snoring;
input snore $ hd $ count;
datalines;
N YES 24
N NO 1355
O YES 35
O NO 603
AD YES 21
AD NO 192
D YES 30
D NO 224
;

** Fit saturated model;
proc genmod data=snoring descending;
freq count;
class snore;
model hd=snore/ dist=bin link=logit p;
run;

** Assign scores to the response categories;
data snoring1;
set snoring;
if snore='N' then score=0; /* difference between N and O is more than the difference between AD and D */
if snore='O' then score=2;
if snore='AD' then score=4;
if snore='D' then score=5;
run;

** Fit different links; 
proc genmod data=snoring1 descending; /* descending for modeling probability of sucess */
freq count;
model hd=score/ dist=bin link=idenity p; /* model for score rather than snore -> systematic component, random component, link component */
run;

proc genmod data=snoring1 descending;
freq count;
model hd=score/ dist=bin link=logit p r obstats;
run;

proc genmod data=snoring1 descending;
freq count;
model hd=score/ dist=bin link=probit p r obstats;
run;

** the model with better fit;
proc genmod data=snoring1 descending;
freq count;
model hd=score/ dist=bin link=idenity p r obstats;
run;

** different way to input data;
data snoring2;
input snore $ n_hd total;
datalines;
N 24 1379
O 35 638
AD 21 213
D 30 254
;

data snoring2;
set snoring2;
if snore='N' then score=0;
if snore='O' then score=2;
if snore='AD' then score=4;
if snore='D' then score=5;
run;

** by this way SAS provides the deviance values;
** Saturated model fits each cell frequency;
** saturated model with any link will be the same; 
proc genmod data=snoring2;
class snore;
model n_hd/total=snore/ dist=bin link=identity; /* fitting sample proportion - no need for ascending or descending */
run;

** linear association model;
proc genmod data=snoring2;
class snore;
model n_hd/total=score/ dist=bin link=identity;
run;

** no association or say independent model;
** independent model with any link will give the same fit/deviance;
proc genmod data=snoring2;
class snore;
model n_hd/total= / dist=bin link=identity; /* does not depend on snoring - independence model */
run;


