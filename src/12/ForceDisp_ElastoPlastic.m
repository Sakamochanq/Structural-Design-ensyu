% function F=ForceDisp(x,xmax,xmin)
% if x>=xmax
%     if x<=0.05
%         F=10^8*x;
%     else
%         F=10^7*(5*x)^0.5;
%     end
% elseif x<=xmin
%     if x>=-0.05
%         F=10^8*x;
%     else
%        F=-10^7*(5*(-x))^0.5; 
%     end
% else
%     if x>0
%         F0=10^7*(5*xmax)^0.5;
%         K=F0/xmax;
%         F= K*x;
%     else
%         F0=-10^7*(5*(-xmin))^0.5;
%         K=F0/xmin;
%         F=K*x;
%     end
% end

function F=ForceDisp_ElastoPlastic(x, xmax, xmin)
if x>= xmax
    if x <= 0.025 % case1 骨格曲線弾性部分 プラス側
       F = 4*10^8*x;
    else
        F=4*10^8*0.025; %case2 骨格曲線塑性部分 プラス側
    end
elseif x <= xmin
    if x>= -0.025
        F=4*10^8*x; % case1 骨格曲線弾性部分 マイナス側
    else
        F=-4*10^8*0.025; %case3 骨格曲線塑性部分 マイナス側
    end
else %除荷、再載荷
    if x>0.001
        K=10^7 / xmax; % case4
        F=K*x;
    elseif x < -0.001 % case5
        K = -10^7 / xmin;
        F = K*x;
    else
        K = 4 * 10^8;
        F = K*x;
    end
end














