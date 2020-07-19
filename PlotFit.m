function [y_hat] = PlotFit(x_d,y,n,lambda,fourier,exp,title_)
    x=[1:length(x_d)]';
    y_fixed = y -fourier(x);
    [coe,s,mu] = polyfit(x,y_fixed,n);
    coe_str = array2string(coe);
    y_hat = polyval(coe,x,s,mu) + fourier(x)%+exp(x);
    err = EvaluateFit_MSE(y,y_hat,lambda,coe);
    str=strcat('Fit MSE = ',num2str(round(err)))%,', Polynom Coefficients: ',coe_str);
    
    %X-axis to dates
    startDate=datenum(x_d(1));
    endDate=datenum(x_d(end));
    xData=linspace(startDate,endDate,length(x_d));
    
    f=figure('Name',title_);
    plot(xData,y_hat);
    hold;
    plot(xData,y);
    datetick('x','dd/mm','keepticks');
    text(xData(1),median(y),str);
    title(title_);

    
    function [o_str] = array2string(d_arr)
        o_str='';
    	d_str = arrayfun(@num2str,round(d_arr),'un',0);
        for i=1:length(d_str)-1
            o_str=strcat(o_str,d_str(i),',');
        end
        o_str=strcat(o_str,d_str(end));
    end

end
