# InsolationAnalysis

This repository includes scripts to calculate daily and seasonally averaged top-of-atmosphere (TOA) incoming solar radiation (insolation) as a function of day and latitude. The calculation can be performed at any point during the past 5 million years.

## Contents

1. daily_insolation_curves.m
2. seasonal_insolation_curves.m

## Required companion toolboxes

The scripts in the repository use the following toolboxes:

**1. The Climate Data Toolbox**

Available at: https://github.com/chadagreene/CDT

*Links to other relevant and helpful CDT documentation:*

http://www.chadagreene.com/CDT/daily_insolation_documentation.html

http://www.chadagreene.com/CDT/doy_documentation.html

Reference: Chad A. Greene, Kaustubh Thirumalai, Kelly A. Kearney, Jose Miguel Delgado, Wolfgang Schwanghart, Natalie S. Wolfenbarger, Kristen M. Thyng, David E. Gwyther, Alex S. Gardner, and Donald D. Blankenship. 2019. The Climate Data Toolbox for MATLAB. Geochemistry, Geophysics, Geosystems. doi: 10.1029/2019GC008392

**2. cmocean perceptually-uniform colormaps for oceanography**

Available for Matlab at: https://www.mathworks.com/matlabcentral/fileexchange/57773-cmocean-perceptually-uniform-colormaps

Reference: Thyng, K.M., C.A. Greene, R.D. Hetland, H.M. Zimmerle, and S.F. DiMarco. 2016. True colors of oceanography: Guidelines for effective and accurate colormap selection. Oceanography. doi: 10.5670/oceanog.2016.66

## Example Analysis

### Insolation as a function of time of year and latitude (e.g., present-day)
*See code: **daily_insolation_curves.m***

![TOA_Insolation_0ka](https://github.com/lawmana/InsolationAnalysis/blob/master/DailyInsolation_0_ka.png)

### Insolation difference relative to present-day (0 ka)
![TOA_Insolation_6-0ka](https://github.com/lawmana/InsolationAnalysis/blob/master/DailyInsolationChange_6-0_ka.png)

### Seasonal insolation for a select latitude as a function of time
*See code: **seasonal_insolation_curves.m***
