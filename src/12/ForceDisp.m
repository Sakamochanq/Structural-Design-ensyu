function F=ForceDisp(x,xmax,xmin)
if x>=xmax
    if x<=0.05
        F=10^8*x;
    else
        F=10^7*(5*x)^0.5;
    end
elseif x<=xmin
    if x>=-0.05
        F=10^8*x;
    else
       F=-10^7*(5*(-x))^0.5; 
    end
else
    if x>0
        F0=10^7*(5*xmax)^0.5;
        K=F0/xmax;
        F= K*x;
    else
        F0=-10^7*(5*(-xmin))^0.5;
        K=F0/xmin;
        F=K*x;
    end
end