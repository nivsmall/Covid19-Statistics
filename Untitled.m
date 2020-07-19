% read CSV files
    % Morbidity data:
Ireland_csv = 'CovidStatisticsProfileHPSCIrelandOpenData.csv';
UK_CSV = 'UK_covid19_data_OWID.xlsx'
T_Ire=readtable(Ireland_csv, 'HeaderLines', 2);
T_UK=readtable(UK_CSV,'HeaderLines',1);
    

% extract relevant dates (x-axis) to vector:
dates = char(table2cell(T_Ire(:,3)));
x_d = datetime(dates(:,1:10),'InputFormat','yyyy/MM/dd');
UK_x_d = (table2array(T_UK(35:123,3)));

% extract relevant data (y-axis) to vectors:
daily_cases = table2array(T_Ire(:,4));
cumu_cases = table2array(T_Ire(:,5));
daily_death = table2array(T_Ire(:,6));
cumu_death = table2array(T_Ire(:,7));
UK_d_cases = table2array(T_UK(40:123,5));
UK_cu_cases = table2array(T_UK(40:123,4));
UK_d_death =  table2array(T_UK(40:123,7));
UK_cu_death =  table2array(T_UK(40:123,6));

lambda = 0;

% diff = cumsum(daily_cases)-cumu_cases;

              %%%%%%%%%%%% Research Questions:  %%%%%%%%%%%%

%     % Fit daily cases to function:
% f1_Ire=FitData2Func(x_d,daily_cases,true,lambda,0,'CPC',[1,1e3],"Ireland Daily Cases Fit Function (Fourier)");
% f1_UK=FitData2Func(UK_x_d(34:end),UK_d_cases(34:end),true,lambda,0,'CPC',[1,1e3],"UK Daily Cases Fit Function (Fourier)");

    % Fit cumulative cases to function:
% f2_Ire=FitData2Func(x_d,cumu_cases,false,lambda,0,'CPC',[1,1e3],"Ireland Cumulative Cases Fit Function (Polynom)");
% f2_UK=FitData2Func(UK_x_d(34:end),UK_cu_cases(34:end),false,lambda,0,'CPC',[1,1e3],"UK Cumulative Cases Fit Function (Polynom)");

% 
%     % Fit daily deaths to function:
% f3_Ire=FitData2Func(x_d,daily_death,true,lambda,0,'CPC',[1,1e3],"Ireland Daily Deaths Fit Function (Fourier)");
% f3_UK=FitData2Func(UK_x_d(6:end),UK_d_death,true,lambda,0,'CPC',[1,1e3],"UK Daily Deaths Fit Function (Fourier)");

% 
%     % Fit cumulative deaths to function:
% f4_Ire=FitData2Func(x_d(10:end),cumu_death(10:end),false,lambda,0,'CPC',[1,1e3],"Ireland Cumulative Deaths Fit Function (Polynom)");
% f4_UK=FitData2Func(UK_x_d(40:end),UK_cu_death(40:end),false,lambda,0,'CPC',[1,1e3],"UK Cumulative Deaths Fit Function (Polynom)");

%     
%     % policy changes dates:
% Ire_dates = {'12-Mar-2020','27-Mar-2020','05-May-2020'};
% UK_eff_LckDwn_dates = {'28-Mar-2020'};

% %UK_dates = ;
% mask_Ire = split2time_slots(x_d,Ire_dates);
% mask_UK = split2time_slots(UK_x_d,UK_eff_LckDwn_dates);

% 
%     % Policy effect on contagion cases:

%%% double derivative of daily deaths to find delay of policy effect on deaths %%%
% f_Ire_2nd_deriv = diff(f3_Ire,2);
% % f_UK_2nd_deriv = diff(f3_UK,2);
% startDate=datenum(x_d(1));
% % startDate=datenum(UK_x_d(6));
% endDate=datenum(x_d(end-2));
% % endDate=datenum(UK_x_d(end));
% xData=linspace(startDate,endDate,85)';
% hold off
% plot(xData,f_Ire_2nd_deriv);
% datetick('x','dd/mm','keepticks');


% f5=FitData2Func(x_d,daily_cases,false,lambda,false,'CPC-CCD',mask_Ire,"Ireland Daily Cases Functions Split by Policy (Polynoms)");
% PlotFit(UK_x_d(1:mask_UK(2)),UK_d_cases(1:mask_UK(2)),3,lambda,0,0,"Daily Cases Functions Split by Policy (Polynoms)");


% fa_UK=PlotFit

% 
%     % Policy effect on death cases:
%     
% f6=FitData2Func(x_d,daily_death,false,lambda,0,'CPC-CCD',mask_Ire,"Ireland Daily Deaths Functions Split by Policy (Polynoms)");
% f6=FitData2Func(UK_x_d,UK_d_death,false,lambda,0,'CPC-CCD',mask_UK,"UK Daily Deaths Functions Split by Policy (Polynoms)");

%     
%     % Correlation between hospitalization and death rate
% UK_hosp_cases = table2array(T_UK(50:123,33));
% UKdeaths2cases = UK_d_death(1+10:end)./UK_d_cases(1:end-10);
% UK_HOSPITALIZATION_DEATHRATE_correlation_coe = corrcoef(UKdeaths2cases,UK_hosp_cases)
% 
% hosp_cases = table2array(T_Ire(16:end-11,12));
% deaths2cases = daily_death(16+11:end)./daily_cases(16:end-11);
% Ire_HOSPITALIZATION_DEATHRATE_correlation_coe = corrcoef(deaths2cases,hosp_cases)



    
     % Correlation between daily tests and contagion cases
% UK_d_tests = table2array(T_UK(1:109,13));
% UK_d_cases = table2array(T_UK(1:109,5));
% UK_TESTS_CONTAGION_correlation_coe = corrcoef(UK_d_tests,UK_d_cases);

Ire_d_tests = table2array(T_Ire(14:81,42));
Ire_d_cases = table2array(T_Ire(14:81,4));
Ire_TESTS_CONTAGION_correlation_coe = corrcoef(Ire_d_tests,Ire_d_cases)    

