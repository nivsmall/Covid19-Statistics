function [err]=FitFuncFindError(x,y,n,lambda,exp)
    [coe,s,mu] = polyfit(x,y,n);
    coe
    poly = polyval(coe,x,s,mu);
    err = EvaluateFit_MSE(y,poly,lambda,coe);
end
