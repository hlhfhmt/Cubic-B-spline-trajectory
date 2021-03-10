clear,clc,close all;
set(0,'defaultfigurecolor','w');

% via-points
Q = [30, -70, 94, -87, -130, 115, -155, 110, -42, -95, 20]';  
col = size(Q, 2);   % ���ݵ��ά��

%% ͬʱָ���ٶȺͼ��ٶ�

% �߽�������
% ctrlIndes = 1�� �ٶ�Ϊ��ı߽�����
% ctrlIndes = 2�� ��Ȼ�߽�����
% ctrlIndes = 3��ͬʱָ���ٶȺͼ��ٶ�Ϊ��

ctrlIndes = 1;  
alpha = 0.5; beta = 0.5;
if ctrlIndes == 3  % �����ٶ�-���ٶȱ߽�����
    q_add1 = alpha*Q(1,:)+(1-alpha)*Q(2,:);
    q_add2 = beta*Q(end,:)+(1-beta)*Q(end-1,:);
    Q = [Q(1,:);q_add1; Q(2:end-1,:);q_add2;Q(end,:)];
end

% B����������������
k = 3;                     % B��������
s = size(Q,1) -1;          % ���ݵ�ĩ�˶˺ţ� r
n = s + k -1;              % ���Ƶ�˺ţ�n
m = n + k + 1;             % �ڵ�������ĩ�˺ţ�m

U = para( s,Q,k, 3)*20;     % ����ڵ�����
d = controlPoints( U,Q, col, ctrlIndes);    % ׷�Ϸ������Ƶ�

f = spmak(U,d');              % B��������

% -------------------------position-------------------------------
d_f = fnder(f,1);
breaks1 = fnval(d_f,U(1+k:n+1+1));    % ���߶����ӵ�
figure(2)
fnplt(d_f,'b',3.3);
xlabel('$\boldmath{u}$','Interpreter','latex');
ylabel('$C^{(1)}(u)$','Interpreter','latex');

grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
    'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');
figure(1);
fnplt(f,'b',3); hold on;     % ����B��������

% �������߶εľ�����
breaks = fnval(f,U(1+k:n+1+1)); breaks(2) = []; breaks(end-1) = [];
uu = U(1+k:n+1+1); uu(2)=[]; uu(end-1)=[];
plot(uu,breaks,'bs','markersize',10,'linewidth',2);  % ���ƾ����ĵ�

xlabel('$\boldmath{u}$','Interpreter','latex');
ylabel('$C(u)$','Interpreter','latex');

grid on;
set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
    'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');

% -------------------------velocity-------------------------------
d_f = fnder(f,1);
breaks1 = fnval(d_f,U(1+k:n+1+1));    % ���߶����ӵ�
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