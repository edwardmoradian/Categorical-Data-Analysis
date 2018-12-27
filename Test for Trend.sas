/*
Test for Trend:
Is the proportion of shoulder harness usage increasing or decreasing linearly as the car size gets larger? 
Response is either the usage of the shoulder harness (y) or the not using of the shoulder harness (n) in 
large, medium and small cars.
*/

ods graphics on;

data trend;
input response $ car_size $ count;
datalines;
n large 226
y large 83
n medium 165
y medium 70
n small 175
y small 71
;
run;

proc freq order=data data=trend;
title "chi-square test for trend";
weight count;
table response*car_size/ chisq plots=all; /* car_size needs to be ordinal */
run;
