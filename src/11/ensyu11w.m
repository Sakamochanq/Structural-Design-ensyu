% 基盤面の加速度 (G)
a = (0:0.000075:3);

% 初期条件入力 =0G
% a(1) = 0;

% 基盤面の加速度 (m/s2)
a = a*9.81;

% 時刻t
t = (0:0.1:4000);

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

t2 = t(1:nt-1);

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

% maximum displacement
xmax = 0.0;

% minimum displacement
xmin = 0.0;

% un-valanced force (N)
unvf = 0.0;

% ----------------------%


for n=1:nt-1

    dt = delta_t(n);

    % 次のステップに誤差を持ち越して、誤差の蓄積を防ぐ
    dp = delta_p(n) + unvf;

    % 初期荷重（この値を調整して収束計算する）
    p0 = 0.0;
    
    for iter = 1:10
        A = m/(beta*dt^2)+gamma*c/(beta*dt)+k;

        B = (m/(beta*dt)+gamma*c/beta)*xd(n)...
            +(m/(2*beta)-dt*c*(1-gamma/(2*beta)))*x2d(n)...
            +dp+p0;

        % 変位増分
        delta_x = B/A;

        % 新しい変位
        x(n+1) = x(n) + delta_x;


        f2 = ForceDisp(x(n+1), xmax, xmin);
 
        f1 = ForceDisp(x(n), xmax, xmin);

        delta_f = f2 - f1;

        unvf = k * delta_x - p0 - delta_f;

        % 初期荷重の更新
        p0 = p0 + unvf;

        % 収束判定
        if f2 < 10^(-4) && f2 > -10^(-4) % f2が0に近いとき
            if delta_f < 10^(-4) && delta_f > -10^(-4) % Δfが0に近いとき
                break
            end
        elseif delta_f / f2 < 10^(-4) && delta_f / f2 > -10^(-4) % |Δf/f|が10^-4未満
            break;
        end

    end


    % 変位増分から速度、加速度の増分を計算

    delta_x_2d = delta_x / (beta*dt^2) - xd(n) / (beta*dt) - x2d(n) / (2*beta);

    delta_x_d = gamma / (beta*dt) * delta_x - gamma / beta * xd(n) ...
                + (1 - gamma / (2*beta)) * dt * x2d(n);

    % 次ステップの変位
    % x(n+1) = x(n) + delta_x;

    % 次ステップの速度
    xd(n+1) = xd(n) + delta_x_d;

    % 次ステップの加速度
    x2d(n+1) = x2d(n) + delta_x_2d;


    % 次のステップの剛性kを設定する
    if x(n+1) > xmax
        xmax = x(n+1);
        f = ForceDisp(xmax, xmax, xmin);

        % 割線剛性
        k = f / xmax;

    elseif x(n+1) < xmin
        xmin = x(n+1);
        f = ForceDisp(xmin, xmax, xmin);

        % 割線剛性
        k = f / xmin;

    else
        f = ForceDisp(x(n+1), xmax, xmin);

        % 割線剛性
        k = f / x(n+1);
    end
    
end

x_max = max(x)
x_min = min(x)

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







