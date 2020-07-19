Ireland_csv = 'CovidStatisticsProfileHPSCIrelandOpenData.csv';
T_Ire=readtable(Ireland_csv, 'HeaderLines', 2);
dates = char(table2cell(T_Ire(:,3)));
x_d = datetime(dates(:,1:10),'InputFormat','yyyy/MM/dd');
daily_death = table2array(T_Ire(:,6));

Ire_LckDwn_date = datenum('27-Mar-2020');
Ire_eff_LckDwn_dates = {'08-Apr-2020'};
mask_Ire = split2time_slots(x_d,Ire_eff_LckDwn_dates);

x=[1:length(x_d)]';
x1=[1:length(x_d(1:mask_Ire(2)))]';
x2=[1:length(x_d(mask_Ire(2)+1:end))]';

startDate=datenum(x_d(1));
endDate=datenum(x_d(end));
endDate1=datenum(x_d(mask_Ire(2)))
xData=linspace(startDate,endDate,length(x_d))';
xData1=linspace(startDate,endDate1,length(x1))';

[coe,s,mu]=polyfit(x1,daily_death(1:mask_Ire(2)),3);
y_w_cont=polyval(coe,x,s,mu);

y_continued=y_w_cont(mask_Ire(2)+1:end);
actual_y_cont = daily_death(mask_Ire(2)+1:end);

f=figure;
% plot(xData1,polyval(coe,x1,s,mu),xData1, daily_death(1:mask_Ire(2)));
% datetick('x','dd/mm','keepticks');
% title('Ireland Daily Deaths with Fit Prior Policy Change');
% coe

plot(xData(1:length(xData1)+30),y_w_cont(1:length(xData1)+30),xData(1:length(xData1)+30),daily_death(1:length(xData1)+30));
datetick('x','dd/mm','keepticks');
title('Ireland Policy Effect on Daily Deaths');
legend('aproximation prior policy change','cases after policy change');
text(Ire_LckDwn_date,0,'| <-Lockdown')
txt_vert=zeros(1,5)'+Ire_LckDwn_date;
txt_horiz=[0:20:80]';
text(txt_vert,txt_horiz, '|');


