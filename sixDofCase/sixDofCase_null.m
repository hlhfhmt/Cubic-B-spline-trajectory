clc,clear, close all
set(0,'defaultfigurecolor','w');

Q = [10 60 75 130 110 100 -10 -50;
    15 25 30 -45 -55 -70 -10 10;
    45 180 200 120 15 -10 100 50;
    5 20 60 110 20 60 -100 -30;
    10 30 -40 -60 10 50 -40 10;
    6 40 80 70 -10 10 30 20;]';

col = size(Q, 2);   % 数据点的维数

%% 同时指定速度和加速度

% 边界条件：
% ctrlIndes = 1： 速度为零的边界条件
% ctrlIndes = 2： 自然边界条件
% ctrlIndes = 3：同时指定速度和加速度为零
ctrlIndes = 3;  

alpha = 0.5; beta = 0.5;
if ctrlIndes == 3  % 采用速度-加速度边界条件
    q_add1 = alpha*Q(1,:)+(1-alpha)*Q(2,:);
%     q_add2 = (Q(end-1,:) + Q(end,:))/2;
    q_add2 = beta*Q(end,:)+(1-beta)*Q(end-1,:);
    Q = [Q(1,:);q_add1; Q(2:end-1,:);q_add2;Q(end,:)];
end

% B样条基本参数计算
k = 3;                     % B样条次数
s = size(Q,1) -1;          % 数据点末端端号： r
n = s + k -1;              % 控制点端号：n
m = n + k + 1;             % 节点向量的末端号：m

U = para( s,Q,k, 3)*30;                     % 计算节点向量
d = controlPoints( U,Q, col, ctrlIndes);    % 追赶法求解控制点
f = spmak(U,d');                            % B样条曲线
d_f = fnder(f,1);
dd_f = fnder(d_f,1);

% 绘图
u = U(4):0.05:U(end-3);
p = fnval(f, u);
v = fnval(d_f, u);
a = fnval(dd_f, u);

% Puma 560 Joint #1
figure(1)
plot(u, p(1,:), 'linewidth',3,'color',[0, 0.45, 0.74]); hold on;
plot(u, v(1,:),'linewidth',3,'color',[0.85, 0.33, 0.10]); hold on;
plot(u, a(1,:),'linewidth',3,'color',[0.93, 0.69, 0.13]); 

xlabel('Time (s)');
title('Puma 560 Joint #1');
% set(gca,'xticklabel',[0:4:32])
grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight','bold',...,
    'Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

figure(2)
plot(u, p(2,:), 'linewidth',3,'color',[0, 0.45, 0.74]); hold on;
plot(u, v(2,:),'linewidth',3,'color',[0.85, 0.33, 0.10]); hold on;
plot(u, a(2,:),'linewidth',3,'color',[0.93, 0.69, 0.13]); 

xlabel('Time (s)');
title('Puma 560 Joint #2');
grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight','bold',...,
    'Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

figure(3)
plot(u, p(3,:), 'linewidth',3,'color',[0, 0.45, 0.74]); hold on;
plot(u, v(3,:),'linewidth',3,'color',[0.85, 0.33, 0.10]); hold on;
plot(u, a(3,:),'linewidth',3,'color',[0.93, 0.69, 0.13]); 

xlabel('Time (s)');
title('Puma 560 Joint #3');
grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight','bold',...,
    'Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

figure(4)
plot(u, p(4,:), 'linewidth',3,'color',[0, 0.45, 0.74]); hold on;
plot(u, v(4,:),'linewidth',3,'color',[0.85, 0.33, 0.10]); hold on;
plot(u, a(4,:),'linewidth',3,'color',[0.93, 0.69, 0.13]); 

xlabel('Time (s)');
title('Puma 560 Joint #4');
grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight','bold',...,
    'Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

figure(5)
plot(u, p(5,:), 'linewidth',3,'color',[0, 0.45, 0.74]); hold on;
plot(u, v(5,:),'linewidth',3,'color',[0.85, 0.33, 0.10]); hold on;
plot(u, a(5,:),'linewidth',3,'color',[0.93, 0.69, 0.13]); 

xlabel('Time (s)');
title('Puma 560 Joint #5');
grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight','bold',...,
    'Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

figure(6)
plot(u, p(6,:), 'linewidth',3,'color',[0, 0.45, 0.74]); hold on;
plot(u, v(6,:),'linewidth',3,'color',[0.85, 0.33, 0.10]); hold on;
plot(u, a(6,:),'linewidth',3,'color',[0.93, 0.69, 0.13]); 

xlabel('Time (s)');
title('Puma 560 Joint #6');
grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight','bold',...,
    'Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');