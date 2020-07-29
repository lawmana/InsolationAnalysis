%==========================================================================
% DAILY TOP-OF-ATMOSPHERE (TOA) INSOLATION CURVES AS A FUNCTION OF 
% LATITUDE AND DAY OF YEAR

% Calculate daily insolation for past time intervals at every latitude
% Compare the insolation to present day (0 ka)

% Author Info: 
% Allison Lawman, UT Austin, 2020
%--------------------------------------------------------------------------
% REQUIRED FUNCTIONS & TOOLBOXES:
% daily_insolation.m - Ian Eisenman and Peter Huybers, August 2006
% Modified for the Climate Data Toolbox: http://www.chadagreene.com/CDT/daily_insolation_documentation.html

% Use the default option 1 for 'day_type' that specifies days in the range 
% 1 to 365.24, where day 1 is January first and the vernal equinox always 
% occurs on day 80

% cmocean: colormaps for oceanography available for Matlab:
% https://www.mathworks.com/matlabcentral/fileexchange/57773-cmocean-perceptually-uniform-colormaps
%--------------------------------------------------------------------------
% References:
% Berger A. and Loutre M.F. (1991). Insolation values for the climate of the last 10 million years. Quaternary Science Reviews, 10(4), 297-317.
% Berger A. (1978). Long-term variations of daily insolation and Quaternary climatic changes. Journal of Atmospheric Science, 35(12), 2362-2367.
% Huybers, Peter (2006). Early Pleistocene glacial cycles and the integrated summer insolation forcing. Science, 313.5786, 508-511.
% Emile-Geay et al. (2016). Links between tropical Pacific seasonal, interannual and orbital variability during the Holocene. Nature Geoscience, 9(2), 168-173. 
% Thyng, K.M., C.A. Greene, R.D. Hetland, H.M. Zimmerle, and S.F. DiMarco. 2016. True colors of oceanography: Guidelines for effective and accurate colormap selection. Oceanography 29(3):9?13.
%==========================================================================
close all; clc; 

% directory to export figures
saveLoc = [mfilename('fullpath') '/'];
mkdir(saveLoc);

%=====================================================
% USER INPUTS: SELECTED LATITUDES AND TIME INTERVALS
%=====================================================

% selected past time intervals (start, end and increment) in units
% thousands of years before present (ka)
start_ka = 0;
end_ka = 30;
incYr = 3;

% selected latitudes
lats = -90:90;

%=====================================================
% LATITUDE vs. DAILY INSOLATION
%=====================================================
% define vector of selected kyears
kyears = start_ka:incYr:end_ka;

% use meshgrid to create grids of the day and latitude variables
[day,lat]=meshgrid(1:365, lats);

% preallocate matrix to store insolation values for each day and latitude
Fsw = zeros([size(lat), length(kyears)]);

% iterate over the kyears, storing the daily insolation at each latitude
for i = 1:length(kyears)

    Fsw(:,:,i) =daily_insolation(kyears(i),lat,day);  
    
end

%-------------------------------------------------------
%% FIGURE GENERATION
%-------------------------------------------------------

monthLabels = {'Jan','Feb','Mar','Apr','May','Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};

%-------------------------------------------------------
% Orbital configuration at slelected time interval
% (e.g., 0 ka)
%-------------------------------------------------------
selectedKyr = 0; % ka

% index for selected time interval
iKyr = find(kyears == selectedKyr);

figure(1); clf; hold on;
title(['TOA Insolation (' num2str(kyears(iKyr)) ' ka)'])
% colormap with formatted color bar
pcolor(day, lat, Fsw(:,:,iKyr))
shading interp
cmap = cmocean('thermal', 10);
colormap(cmap)
c = colorbar;
cbarrow('up')
c.Label.String = 'W/m^2';
caxis([0 500])

% add contours
[c,h]=contour(day,lat,Fsw(:,:,iKyr),0:50:500, 'k');
clabel(c,h)
xlabel 'time of year'
ylabel 'latitude'

% axis formatting
ax = gca;

% set x-ticks to be spaced every 30 days starting on the 15th day of the
% year so that the calendar month labels approximately line up with the
% mid-point of every month
ax.XTick = 15:30:365;
xticklabels(monthLabels)
ax.YTick = lats(1):10:lats(end);
ax.FontWeight = 'bold';

% save figure
figName = ['DailyInsolation_' num2str(kyears(iKyr)) '_ka'];
print([saveLoc figName '.png'], '-dpng');

%=====================================================
%% Difference in insolation relative to present (0 ka)
%=====================================================
for i = 2:length(kyears)
    
    % calculate difference relative to 0 ka
    Fsw_diff = Fsw(:,:,i) - Fsw(:,:,1);
    
    % plot
    figure(i); clf; hold on;
    title(['TOA Insolation (' num2str(kyears(i)) ' - 0 ka)'])
    
    % color map
    pcolor(day, lat, Fsw_diff)
    shading interp
    cmap = cmocean('balance', 20);
    colormap(cmap)
    c = colorbar;
    c.Label.String = 'W/m^2';
    caxis([-50 50])
    cbarrow

    % contours
    [c,h]=contour(day,lat,Fsw_diff,-50:10:50, 'k');
    clabel(c,h)
    xlabel 'time of year'
    ylabel 'latitude'
    
    % axis formatting and x-tick labeling with calendar months
    ax = gca;
    ax.XTick = 15:30:365;
    xticklabels(monthLabels)
    ax.YTick = lats(1):10:lats(end);
    ax.FontWeight = 'bold';
    
    % save figure
    figName = ['DailyInsolationChange_' num2str(kyears(i)) '-0_ka'];
    print([saveLoc figName '.png'], '-dpng');
end


