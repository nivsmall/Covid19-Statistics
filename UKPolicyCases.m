UK_CSV = 'UK_covid19_data_OWID.xlsx'
T_UK=readtable(UK_CSV,'HeaderLines',1);

UK_x_d = (table2array(T_UK(35:123,3)));

UK_d_cases = table2array(T_UK(35:123,5));
UK_cu_cases = table2array(T_UK(35:123,4));
UK_d_death =  table2array(T_UK(35:123,7));
UK_cu_death =  table2array(T_UK(35:123,6));

UK_eff_LckDwn_dates = {'28-Mar-2020'};
mask_UK = split2time_slots(UK_x_d,UK_eff_LckDwn_dates);

UK_x=[1:length(UK_x_d)]';
x1=[1:length(UK_x_d(1:mask_UK(2)))]';
x2=[1:length(UK_x_d(mask_UK(2)+1:end))]';

startDate=datenum(UK_x_d(1));
endDate=datenum(UK_x_d(end));
endDate1=datenum(UK_x_d(mask_UK(2)))
xData=linspace(startDate,endDate,length(UK_x_d))';
xData1=linspace(startDate,endDate1,length(x1))';


[coe,s,mu]=polyfit(x1,UK_d_cases(1:mask_UK(2)),3);
y_w_cont=polyval(coe,UK_x,s,mu);

y_continued=y_w_cont(mask_UK(2)+1:end);
actual_y_cont = UK_d_cases(mask_UK(2)+1:end);

f=figure
plot(xData1,polyval(coe,x1,s,mu),xData1, UK_d_cases(1:mask_UK(2)));
datetick('x','dd/mm','keepticks');
title('UK Daily Cases with Fit Prior Policy Change');
coe;

plot(xData(1:length(xData1)+20),y_w_cont(1:length(xData1)+20),xData(1:length(xData1)+20),UK_d_cases(1:length(xData1)+20));
datetick('x','dd/mm','keepticks');
title('UK Policy Effect on Daily Cases');
legend('aproximation prior policy change','cases after policy change');
text(endDate1,0,'| <-Lockdown')
txt_vert=zeros(1,5)'+endDate1;
txt_horiz=[0:0.5:2]'.*1e4;
text(txt_vert,txt_horiz, '|');



