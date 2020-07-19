function [d_out] = UpsampleAndInterpolate(data, start_date, end_date)
% fixes data that has only week days by adding days and ZOH interpolation
%   for these unsampled days
% data should be a 2Xn matrix: columns are datenum & value 
% start and end dates should be datetime instance

    c = split(char((end_date-start_date)/24),':');
    NumDays=str2double(c{1});
    d_out=zeros(NumDays,2);

    % delay start date by one day
    cnt=1;
    k=0;
    for i=start_date:end_date
        if not(data(cnt-k,1)-datenum(i) == 0)
            % fill in as ZOH undersampled data
            d_out(cnt,:) = [datenum(i),d_out(cnt-1,2)];
            k=k+1;
        else
            d_out(cnt,:) = data(cnt-k,:);
        end
        cnt=cnt+1;
    end
end