
function [y_hat] = FitData2Func(x_d,y,fourier_flag,lambda,exp_flag,params,mask,title_)
% params - parameters to choose from
    x=[1:length(x_d)]';
    if fourier_flag
        fourier1 = fit(x,y,'fourier3')
    else
        fourier1 = zeros(1,length(x))';
    end
    if exp_flag
        exp = fit(x,y,'exp1');
    else
        exp = zeros(1,length(x))';
    end
    y_fixed = y-fourier1(x)-exp(x);
    
    par = ChooseParams(params,x,y_fixed,lambda,mask);       %par = [n1,n2,n3,n4,d]
    d=par(1,end);
    if length(mask)==2
        y_hat = PlotFit(x_d,y,par(1,1),lambda,fourier1,exp,title_);
    else
%         y_hat = [PlotFit(x_d(mask(1):mask(2)+d),y(mask(1):mask(2)+d),par(1,1),lambda,fourier1,exp,title_),
%                PlotFit(x_d(mask(2)+d:mask(3)+d),y(mask(2)+d:mask(3)+d),par(1,2),lambda,fourier1,exp,title_),
%                PlotFit(x_d(mask(3)+d:mask(4)+d),y(mask(3)+d:mask(4)+d),par(1,3),lambda,fourier1,exp,title_),
%                PlotFit(x_d(mask(4)+d:mask(5)),y(mask(4)+d:mask(5)),par(1,4),lambda,fourier1,exp,title_)];
            y_hat = [PlotFit(x_d(mask(1):mask(2)+d),y(mask(1):mask(2)+d),par(1,1),lambda,fourier1,exp,title_),
                    PlotFit(x_d(mask(2)+d:mask(3)+d),y(mask(2)+d:mask(3)+d),par(1,2),lambda,fourier1,exp,title_)];
    end
end