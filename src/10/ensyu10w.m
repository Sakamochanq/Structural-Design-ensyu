% 1列目：時間（sec）,　2列目：基盤面の加速度（m/s²）
data = readmatrix("l2wave.csv");

% 基盤面の加速度a（m/s²）
a = data(:,2)'/1000*9.81;

% 時刻t
t = data(:,1)';

plot(t, a)
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
c = 2 * gzai * (m*k)^0.5;



% 外力増分 delt_p
delta_p = -m * diff(a);

t2 = (1:nt-1);

plot(t2, delta_p)
xlabel('Time (s)')
ylabel('Increment of external force (N)')

% Newmark-beta法
beta = 1/6; gamma = 1/2;


% ------- 初期化 -------%

% 変位（m）
x = zeros(1, nt);

% 速度（m/s）
xd = zeros(1, nt);

% 加速度（m/s2）
x2d = zeros(1, nt);

% ----------------------%


for n=1:nt-1

    dt = delta_t(n);
    dp = delta_p(n);

    A = m/(beta*dt^2)+gamma*c/(beta*dt)+k;

    B = (m/(beta*dt)+gamma*c/beta)*xd(n)...
          +(m/(2*beta)-dt*c*(1-gamma/(2*beta)))*x2d(n)...
          +dp;

    delta_x = B/A;   % 変位増分


    % 変位増分から速度、加速度の増分を計算

    delta_x_2d = delta_x / (beta*dt^2) - xd(n) / (beta*dt) - x2d(n) / (2*beta);

    delta_x_d = gamma / (beta*dt) * delta_x - gamma / beta * xd(n) ...
                + (1 - gamma / (2*beta)) * dt * x2d(n);

    % 次ステップの変位
    x(n+1) = x(n) + delta_x;

    % 次ステップの速度
    xd(n+1) = xd(n) + delta_x_d;

    % 次ステップの加速度
    x2d(n+1) = x2d(n) + delta_x_2d;

end

% ------- 未定義？ ------- %

% nstep = 0;
% natural = 0;

% ----------------------- %

x_max = max(x)
x_min = min(x)

temp = max(x_max, -x_min);

amax(nstep) = k*temp / m / 9.81 * 1000


plot(natural, amax)
xlabel('Natural Period（s）')
ylabel('Maxium response of accelerati')

plot(t, x)
xlabel('Times (s)')
ylabel('Displacement (m)');

% print -dpng ./09/figure09-1

plot(t, xd)
xlabel('Times (s)')
ylabel('Velocity (m/s)');

plot(t, x2d)
xlabel('Times (s)')
ylabel('Acceleration (m/s2)');






