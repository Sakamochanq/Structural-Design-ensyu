% 基盤面の加速度 (G)
a = ones(1, 101);

% 初期条件入力 =0G
a(1) = 0;

% 基盤面の加速度 (m/s2)
a = a*9.81;

% 時刻t
t = (0:0.1:10);

plot(t, a);
xlabel('Time (s)')
ylabel('Ground acceleration (m/s2)')



% 時間増分（s） delta_t
delta_t = diff(t);

% ステップ数 nt
[mt, nt] = size(t);

% 質量m（kg）
m = 2*10^6;

% バネ定数（N/m）
k = 1*10^8;

% 減衰定数、土木構造物は0.02-0.05
gzai = 0.05;

% 減衰係数c
c = 2 * gzai * (m/k)^0.5;





















