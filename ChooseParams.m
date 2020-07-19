
function [best_params] = ChooseParams(params, x, y,lambda,mask)
 % y - data, x - timeline, mask - splitting data to time slots
 %  best params: [best_n1, best_n2, best_n3, best_n4, best_d]
    best_curr_params = zeros(1,4);
    best_cumu_Err = 1e10;
    d_end=0;
    n_end=5;
    
    
    
    if any(strfind(params,'CCD'))
        %CCD - Check Constant Delay (delay from change in policy date)
        % in the sense of how to fit function to timeline
        d_end = 0;
    end

    if any(strfind(params,'CPC'))
        %CPC - Check Polynom Coeffiecients
        if length(mask)==2
            n_end = 1;
        else
            n_end = 3;
    end
    
    if any(strfind(params,'EXP'))
        %EXP - Check exponential fit as well
    end
    
        for d=d_end:d_end
            if d_end == 0
                best_err = [1e10,0,0,0];
            else
                best_err = [1e10,1e10,1e10,1e10];
            end
            for n=1:n_end
                
                for i=1:length(mask)-1
                    x_i = x(mask(i)+d:min(mask(i+1)+d,length(x)));
                    y_i = y(mask(i)+d:min(mask(i+1)+d,length(x)));
                    error = FitFuncFindError(x_i,y_i,n,lambda);
                    if error < best_err(i)
                        best_err(i)=error;
                        best_curr_params(i)= n;
                    end
                end
            end
            Err = sum(best_err);
            if Err<best_cumu_Err
                best_cumu_Err = Err;
                best_params = [[best_curr_params d];[best_err Err]];
            end
        end
end