function [cc,mc,abscc]=calcc(fai,eps,fc,epsp,CONC)
% --出力--
% cc: コンクリートの合力(N)
% mc: コンクリートのモーメント(N-mm)，y=0まわり
% abscc: コンクリートの合力の絶対値(N)

% --入力--
% fai: 曲率(/mm)
% eps: y=0のひずみ
% fc: コンクリートの圧縮強度(N/mm2)
% epsp: コンクリートの圧縮ピークひずみ
%CONC(i,j): コンクリートファイバーの情報(i:ファイバーの番号, 
%           j=1: y座標(mm), j=2: ファイバーの長さ(mm)，j=3: ファイバーの幅(mm)

[rw, col] = size(CONC);

% 初期化
cc = 0.0;
mc = 0.0;
abscc = 0.0;

for i=1:rw
    y = CONC(i,1);
    b = CONC(i,2);
    dy = CONC(i,3);

    % ひずみ
    epsc = fai*y+eps;

    % コンクリートの応力
    segc = concrete1d(epsc, fc, epsp);

    % ファイバーの力
    p = segc*b*dy;

    % コンクリートの合力
    cc = cc+p;

    % 曲げモーメント（図心まわり）
    mc = mc+p*y;

    % 合力の絶対値
    abscc = abscc*abs(p);
end











