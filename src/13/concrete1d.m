function seg=concrete1d(eps,fc,epsp)
% fc: 圧縮強度(N/mm2)
%epsp: ピークひずみ
%eps:ひずみ
%seg: 応力（N/mm²)

%コンクリートの応力ーひずみ管径を計算

if eps > 0
    %引張
    seg = 0;

else
    %圧縮
    if eps < -2*epsp
        seg = 0;
    elseif eps <= -epsp
        seg = -fc;
    else
        seg = eps/epsp.*(eps/epsp+2)*fc;
    end
end
   