clear,clc,close all;
set(0,'defaultfigurecolor','w');

% via-points
Q = [30, -70, 94, -87, -130, 115, -155, 110, -42, -95, 20]';  
col = size(Q, 2);   % 数据点的维数

%% 同时指定速度和加速度

% 边界条件：
% ctrlIndes = 1： 速度为零的边界条件
% ctrlIndes = 2： 自然边界条件
% ctrlIndes = 3：同时指定速度和加速度为零

ctrlIndes = 1;  
alpha = 0.5; beta = 0.5;
if ctrlIndes == 3  % 采用速度-加速度边界条件
    q_add1 = alpha*Q(1,:)+(1-alpha)*Q(2,:);
    q_add2 = beta*Q(end,:)+(1-beta)*Q(end-1,:);
    Q = [Q(1,:);q_add1; Q(2:end-1,:);q_add2;Q(end,:)];
end

% B样条基本参数计算
k = 3;                     % B样条次数
s = size(Q,1) -1;          % 数据点末端端号： r
n = s + k -1;              % 控制点端号：n
m = n + k + 1;             % 节点向量的末端号：m

U = para( s,Q,k, 3)*20;     % 计算节点向量
d = controlPoints( U,Q, col, ctrlIndes);    % 追赶法求解控制点

f = spmak(U,d');              % B样条曲线

% -------------------------position-------------------------------
d_f = fnder(f,1);
breaks1 = fnval(d_f,U(1+k:n+1+1));    % 曲线段连接点
figure(2)
fnplt(d_f,'b',3.3);
xlabel('$\boldmath{u}$','Interpreter','latex');
ylabel('$C^{(1)}(u)$','Interpreter','latex');

grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
    'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');
figure(1);
fnplt(f,'b',3); hold on;     % 绘制B样条曲线

% 计算曲线段的经过点
breaks = fnval(f,U(1+k:n+1+1)); breaks(2) = []; breaks(end-1) = [];
uu = U(1+k:n+1+1); uu(2)=[]; uu(end-1)=[];
plot(uu,breaks,'bs','markersize',10,'linewidth',2);  % 绘制经过的点

xlabel('$\boldmath{u}$','Interpreter','latex');
ylabel('$C(u)$','Interpreter','latex');

grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
    'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

% -------------------------velocity-------------------------------
d_f = fnder(f,1);
breaks1 = fnval(d_f,U(1+k:n+1+1));    % 曲线段连接点
figure(2)
fnplt(d_f,'b',3.3);
xlabel('$\boldmath{u}$','Interpreter','latex');
ylabel('$C^{(1)}(u)$','Interpreter','latex');

grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
    'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

% -----------------------------acceleration-------------------------------
dd_f = fnder(d_f,1);

figure(3)
fnplt(dd_f,'b',3.3);
xlabel('$\boldmath{u}$','Interpreter','latex');
ylabel('$C^{(2)}(u)$','Interpreter','latex');

grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
    'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');