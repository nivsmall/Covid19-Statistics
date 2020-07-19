
function[MSE] = EvaluateFit_MSE(y,y_hat,lambda,coe)
% y - True label vector
% y_hat - Function label vector
n=length(y);
reg_sqr_error_v = (y-y_hat).^2 - lambda*sum(coe);
MSE = 1./n*sum(reg_sqr_error_v);
end

