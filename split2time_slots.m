function [mask] = split2time_slots(x_d, d_s)
%     mask=[1,0,0];
    mask=zeros(1,length(d_s)+2)';
    mask(1)=1;
    for i=2:length(d_s)+1
        mask(i) = find(x_d==datetime(d_s(i-1)));
    end
    mask(end) = length(x_d);
end
