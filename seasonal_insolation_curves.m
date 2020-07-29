%==========================================================================
% SEASONAL TOP-OF-ATMOSPHERE (TOA) INSOLATION FOR SELECTED LATITUDE

% Calculate seasonally averaged insolation as a function of time
% Calculate the seasonal insolation contrats as a function of time

% The figures generated in this analysis are inspired by Figure S9 in
% Emile-Geay et al., (2015), doi: 10.1038/ngeo2608
%--------------------------------------------------------------------------
% REQUIRED FUNCTIONS & TOOLBOXES:
% daily_insolation.m - Ian Eisenman and Peter Huybers, August 2006
% Modified for the Climate Data Toolbox: http://www.chadagreene.com/CDT/daily_insolation_documentation.html

% doy.m - day of year available in the Climate Data Toolbox for Matlab

% Use the default option 1 for 'day_type' that specifies days in the range 
% 1 to 365.24, where day 1 is January first and the vernal equinox always 
% occurs on day 80
%--------------------------------------------------------------------------
% References:
% Berger A. and Loutre M.F. (1991). Insolation values for the climate of the last 10 million years. Quaternary Science Reviews, 10(4), 297-317.
% Berger A. (1978). Long-term variations of daily insolation and Quaternary climatic changes. Journal of Atmospheric Science, 35(12), 2362-2367.
% Huybers, Peter (2006). Early Pleistocene glacial cycles and the integrated summer insolation forcing. Science, 313.5786, 508-511.
% Emile-Geay et al. (2016). Links between tropical Pacific seasonal, interannual and orbital variability during the Holocene. Nature Geoscience, 9(2), 168-173. 
%==========================================================================
close all; clc; 

% directory to export figures
saveLoc = [mfilename('fullpath') '/'];
mkdir(saveLoc);

%=====================================================
% USER INPUTS: SELECTED LATITUDE AND TIME INTERVALS
%=====================================================
% selected latitude and kyears (ka)
lat = 0;
start_kyear = 0;    % ka
end_kyear = 24;     % ka

% increment for the time axis
kInc = 0.5; 

%=====================================================
% SEASONAL INSOLATION
%=====================================================
% define time axis
kyears = start_kyear:kInc:end_kyear; 

% Dec-Jan-Feb = DJF; Mar-Apr-May = MAM; Jun-Jul-Aug = JJA; Sep-Oct-Nov = SON
day_DJF = [doy('December 1'):doy('December 31'), doy('January 1'):doy('February 28')];
day_MAM = doy('March 1'):doy('May 31');
day_JJA = doy('June 1'):doy('August 31');
day_SON = doy('September 1'):doy('November 30');

% preallocate vectors for seasonally averaged insolation vs. kyears
DJF = zeros(length(kyears),1);
MAM = zeros(length(kyears),1);
JJA = zeros(length(kyears),1);
SON = zeros(length(kyears),1);

for i = 1:length(kyears)
    Fsw = daily_insolation(kyears(i), lat, day_MAM);
    MAM(i) = mean(Fsw);
    
    Fsw = daily_insolation(kyears(i), lat, day_JJA);
    JJA(i) = mean(Fsw);
    
    Fsw = daily_insolation(kyears(i), lat, day_SON);
    SON(i) = mean(Fsw);
    
    Fsw = daily_insolation(kyears(i), lat, day_DJF);
    DJF(i) = mean(Fsw);
end

% present-day seasonal contrast
JJA_DJF_0ka = JJA(1) - DJF(1);
SON_MAM_0ka = SON(1) - MAM(1);

%=====================================================
%% FIGURE GENERATION
%=====================================================
% plot formatting
linWidth = 1.5;
legendLoc = 'northwest';

figure(1); clf; hold on;
% seasonal insolation
subplot(2,1,1); hold on;
title(['Seasonal Insolation at Latitude = ' num2str(lat) char(0176)])
plot(kyears, DJF, '--r', 'linewidth', linWidth)
plot(kyears, MAM, '--k', 'linewidth', linWidth)
plot(kyears, JJA, '-r', 'linewidth', linWidth)
plot(kyears, SON, '-k', 'linewidth', linWidth)
legend('DJF', 'MAM', 'JJA', 'SON')
xlabel('Time (ka)')
ylabel('Seasonal Insolation (W/m^2)')

ax = gca;
ax.XDir = 'reverse';
ax.FontWeight = 'bold';

% seasonal insolation contrast
subplot(2,1,2); hold on;
title('Seasonal Insolation Contrast')
plot(kyears, SON - MAM, '-k', 'linewidth', linWidth)
plot(kyears, JJA - DJF, '-r', 'linewidth', linWidth)
legend('SON - MAM', 'JJA - DJF')
xlabel('Time (ka)')
ylabel('\Delta Insolation (W/m^2)')

ax = gca;
ax.XDir = 'reverse';
ax.FontWeight = 'bold';

% save figure
figName = ['SeasonalInsolation_lat=' num2str(lat) '_' num2str(end_kyear) '-' num2str(start_kyear) '_ka'];
print([saveLoc figName '.png'], '-dpng');