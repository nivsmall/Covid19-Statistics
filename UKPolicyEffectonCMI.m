
% read CMI (Capital Market Indices) data and upsample it:
CMI_UK_CSV = '^FTAS';
T_C_UK=readtable(CMI_UK_CSV,'HeaderLines',1);
CMI_UK_raw=table2array(T_C_UK(1:83,7));
CMI_dates_UK=datenum(table2array(T_C_UK(1:83,1)));
lst_date_UK=table2array(T_C_UK(1,1));
end_date_UK=table2array(T_C_UK(83,1));
CMI_UK=UpsampleAndInterpolate([CMI_dates_UK,CMI_UK_raw],lst_date_UK,end_date_UK);
UK_x_d=datetime(CMI_UK(:,1),'ConvertFrom','datenum');
UK_x = [1:length(UK_x_d)]';

% mask (and later split) time line according to change in policy:
UK_policy_dates = {'16-Mar-2020','23-Mar-2020','10-May-2020'};
X = split2time_slots(UK_x_d,UK_policy_dates);
x1=X(2);
x2=X(3);
x3=X(4);

            %%%% first time slot for first change in policy: %%%%
x1_1=UK_x_d(x1-20:x1);          % 20 days prior change
x1_2=UK_x_d(x1+1:x2-1);         % week following change
startDate1=datenum(x1_1(1));
startDate1_m=datenum(x1_2(1));
endDate1=datenum(x1_2(end));
xData1=linspace(startDate1,endDate1,length([x1_1' x1_2']))';
xData1_m=linspace(startDate1_m,endDate1,length(x1_2))';
d=datetime(xData1,'ConvertFrom','datenum');
UK_x1=[1:length(x1_1)];

[coe,s,mu]=polyfit(UK_x1,CMI_UK(x1-20:x1,2),1);
UK_x1=[1:length([x1_1' x1_2'])];
y_hat_continued_1=polyval(coe,UK_x1,s,mu)';

actual_y_cont_1 = CMI_UK(x1-20:x2-1,2);


            %%%%% second time slot for second change in policy: %%%%
x2_1=UK_x_d(x2-6:x2);           % week prior change
x2_2=UK_x_d(x2+1:x3-1);         % month following change
startDate2=datenum(x2_1(1));
startDate2_m=datenum(x2_2(1));
endDate2=datenum(x2_2(end));
xData2=linspace(startDate2,endDate2,length([x2_1' x2_2']))';
xData2_m=linspace(startDate2_m,endDate2,length(x2_2))';
d=datetime(xData2,'ConvertFrom','datenum');
UK_x2=[1:length(x2_1)];

[coe,s,mu]=polyfit(UK_x2,CMI_UK(x2-6:x2,2),1);
UK_x2=[1:length([x2_1' x2_2'])];
y_hat_continued_2=polyval(coe,UK_x2,s,mu)';
actual_y_cont_2 = CMI_UK(x2-6:x3-1,2);


        %%%% third time slot for third change in policy: %%%%
x3_1=UK_x_d(x2+1:x3);          % month prior change
x3_2=UK_x_d(x3+1:end);         % following change
startDate3=datenum(x3_1(1));
startDate3_m=datenum(x3_2(1));
endDate3=datenum(x3_2(end));
xData3=linspace(startDate3,endDate3,length([x3_1' x3_2']))';
xData3_m=linspace(startDate3_m,endDate3,length(x3_2))';
d=datetime(xData3,'ConvertFrom','datenum');
UK_x3=[1:length(x3_1)];

[coe,s,mu]=polyfit(UK_x3,CMI_UK(x2+1:x3,2),1);
UK_x3=[1:length([x3_1' x3_2'])];
y_hat_continued_3=polyval(coe,UK_x3,s,mu)';
actual_y_cont_3 = CMI_UK(x2+1:end,2);

f=figure;
plot(xData1,actual_y_cont_1,xData1,y_hat_continued_1,xData2,actual_y_cont_2,xData2,y_hat_continued_2,xData3,actual_y_cont_3,xData3,y_hat_continued_3);
title('UK Policy Effect on Capital Market');
datetick('x','dd/mm','keepticks');
legend('1st phase true Market Indices','1st phase approximation','2nd phase true Market Indices','2nd phase approximation','3rd phase true Market Indices','3rd phase approximation');
text(xData3_m(1),min(actual_y_cont_3),'| <-change in policy')
txt_vert1=zeros(1,11)'+xData1_m(1);
txt_horiz1=[1:0.5:6]'.*1e8;
text(txt_vert1,txt_horiz1, '|');
txt_vert2=zeros(1,11)'+xData2_m(1);
txt_horiz2=[1:0.5:6]'.*1e8;
text(txt_vert2,txt_horiz2, '|');
txt_vert3=zeros(1,11)'+xData3_m(1);
txt_horiz3=[1:0.5:6]'.*1e8;
text(txt_vert3,txt_horiz3, '|');


% f2=figure;
% plot(xData2,actual_y_cont_2,xData2,y_hat_continued_2);
% datetick('x','dd/mm','keepticks');
% legend('2nd phase true Market Indices','2nd phase approximation');
% text(xData2_m(1),min(actual_y_cont_2),'| <-change in policy')
% 
% 
% f3=figure;
% plot(xData3,actual_y_cont_3,xData3,y_hat_continued_3);
% datetick('x','dd/mm','keepticks');
% legend('3rd phase true Market Indices','3rd phase approximation');
% text(xData3_m(1),min(actual_y_cont_3),'| <-change in policy')