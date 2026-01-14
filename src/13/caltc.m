function [tc,mt,abstc]=caltc(fai,eps,fy,Es,STL)

% --出力--
% tc: 鉄筋の合力(N)
% mt: 鉄筋のモーメント(N-mm)，y=0まわり
% abstc: 鉄筋の合力の絶対値(N)

% --入力--
% fai: 曲率(/mm)
% eps: y=0のひずみ
% fy: 鉄筋の降伏強度(N/mm2)
% Es: 鉄筋の弾性係数(N/mm2)
%STL(i,j): 鉄筋の情報(i:鉄筋の番号, j=1: y座標(mm), j=2: 1本あたりの断面積(mm2)，j=3: 本数

[rw, col] = size(STL);

tc = 0;
mt = 0.0;
abstc = 0.0;

for i=1:rw
    y = STL(i,1);
    b = STL(i,2);
    dy = STL(i,3);

    epss = fai*y+eps;

    segs = steel1d(epss, fy, Es);

    p = segs*b*dy;

    tc = tc+p;

    mt = mt+p*y;

    abstc = abstc+abs(p);
end














