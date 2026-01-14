eps=-0.005:0.0001:0.003;
[row,col]=size(eps);
segc=zeros(1,col);
segs=zeros(1,col);

%コンクリートの応力―ひずみ関係を計算
fc=33; %圧縮強度(N/mm2)　、正の値で定義
epsp=0.002; %圧縮のピークひずみ（無次元）、正の値で定義
for i=1:col
    segc(i)=concrete1d(eps(i),fc,epsp);
end
plot(eps,segc)
title("Concrete");xlabel("strain");ylabel("stress (N/mm2)");

print -dpng ./figure13-1

%鉄筋の応力―ひずみ関係を計算
fy=345; %降伏強度
Es=200000; %弾性係数(N/mm2)
for i=1:col
    segs(i)=steel1d(eps(i),fy,Es);
end
plot(eps,segs)
title("Rebar");xlabel("strain");ylabel("stress (N/mm2)");

print -dpng ./figure13-2
