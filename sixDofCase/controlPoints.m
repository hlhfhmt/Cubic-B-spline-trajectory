function d = controlPoints( varargin)
% controlPoints: ������Ƶ�
% col:���ݵ��ά��
% boundaryCondition���߽�������־

u=varargin{1};
Q=varargin{2};
col=varargin{3};
boundaryCondition=varargin{4};

% if (boundaryCondition == 3)
%     q_add1 = (Q(1,:)+Q(2,:))/2;
%     q_add2 = (Q(end-1,:) + Q(end,:))/2;
%     Q = [Q(1,:);q_add1;Q(2:end-1,:);q_add2;Q(end,:)];
%     % B����������������
%     k = 3;                     % B��������
%     s = size(Q,1) -1;          % ���ݵ�ĩ�˶˺ţ� r
%     u = para( s,Q,k, 1);                % ����ڵ�����
% end
n = size(Q,1) -1 + 2;

flag = 0;
b = zeros(1, n-1); a = zeros(1, n-1); c = zeros(1, n-2); e = zeros(n-1,col);

% �߽�����
switch boundaryCondition
    case 1   % ��ʸ����
        if nargin == 4
            qv0 = zeros(1,col); qvn = zeros(1,col);
        else
            qv0 = varargin{5};  qvn = varargin{6};
        end
        b(1) = 1;
        e(1,:) = Q(0+ 1,:) + (u(4+ 1)-u(3+ 1))*qv0/3;
        b(n-1) = 1;
        e(n-1,:) = Q(n-2 +1,:) - (u(n+1 +1)-u(n+ 1))*qvn/3;
    case 2  % ���ɶ˵�߽�����
        c(1) = -(u(4 +1)-u(1+ 1));
        b(1) = u(5+ 1)+u(4+ 1)-u(2+ 1)-u(1+ 1);
        e(1,:) = (u(5+ 1)-u(2+ 1))*Q(0+ 1,:);
        a(n-1) = -(u(n+3 +1)-u(n+ 1));
        b(n-1) = u(n+3 +1)+u(n+2 +1)-u(n+ 1)-u(n-1 +1);
        e(n-1,:) = (u(n+2 +1)-u(n-1 +1))*Q(n-2 +1,:);
    case 3
%         qv0 = [0, 0]; qvn = [0,0];
         qv0 = zeros(1,col); qvn = zeros(1,col);
        b(1) = 1;
        e(1,:) = Q(0+ 1,:) + (u(4+ 1)-u(3+ 1))*qv0/3;
        b(n-1) = 1;
        e(n-1,:) = Q(n-2 +1,:) - (u(n+1 +1)-u(n+ 1))*qvn/3;
        
        b(2) = -(u(4 +1)-u(1+ 1));
        a(2) = u(5+ 1)+u(4+ 1)-u(2+ 1)-u(1+ 1);
        e(2,:) = (u(5+ 1)-u(2+ 1))*Q(0+ 1,:);
        b(n-2) = -(u(n+3 +1)-u(n+ 1));
        c(n-2) = u(n+3 +1)+u(n+2 +1)-u(n+ 1)-u(n-1 +1);
        e(n-2,:) = (u(n+2 +1)-u(n-1 +1))*Q(n-2 +1,:);
        flag = 1;
    case 4
        
        flag = 2;
    otherwise
end

% �������ԽǾ���Ԫ�أ��ڶ��е�n-2�У����ο���P305
if flag == 0
    for i = 2:n-2
        da = u(i+3 +1) - u(i+ 1);
        dc = u(i+4 +1) - u(i+1 +1);
        a(i) = ((u(i+3 +1) - u(i+2 +1))^2)/(da); % ������
        c(i) = ((u(i+2 +1) - u(i+1 +1))^2)/(dc); % ������
        % �Խ���Ԫ��
        b(i) = (u(i+3 +1)-u(i+2 +1))*(u(i+2 +1)-u(i +1))/da + ...
            (u(i+2 +1)-u(i+1 +1))*(u(i+4 +1)-u(i+2 +1))/dc;
        e(i,:) = Q(i-1 +1,:)*(u(i+3 +1)-u(i+1 +1));
    end
    
    a(1) = [];          % a�ӵڶ��ʼ
    d=purse(b,a,c,e);   % ׷�Ϸ�������Ƶ�
    d = [Q(1,:);d;Q(end,:)];   % ��������˵㣨Ҫ�����˵㣩
    
elseif flag == 1
    for i = 3:n-3
        da = u(i+3 +1) - u(i+ 1);
        dc = u(i+4 +1) - u(i+1 +1);
        a(i) = ((u(i+3 +1) - u(i+2 +1))^2)/(da); % ������
        c(i) = ((u(i+2 +1) - u(i+1 +1))^2)/(dc); % ������
        % �Խ���Ԫ��
        b(i) = (u(i+3 +1)-u(i+2 +1))*(u(i+2 +1)-u(i +1))/da + ...
            (u(i+2 +1)-u(i+1 +1))*(u(i+4 +1)-u(i+2 +1))/dc;
        e(i,:) = Q(i-1 +1,:)*(u(i+3 +1)-u(i+1 +1));
    end
    
    a(1) = [];          % a�ӵڶ��ʼ
    d=purse(b,a,c,e);   % ׷�Ϸ�������Ƶ�
    d = [Q(1,:);d;Q(end,:)];   % ��������˵㣨Ҫ�����˵㣩
else
    for i = 2:n-2
        da = u(i+3 +1) - u(i+ 1);
        dc = u(i+4 +1) - u(i+1 +1);
        a(i) = ((u(i+3 +1) - u(i+2 +1))^2)/(da); % ������
        c(i) = ((u(i+2 +1) - u(i+1 +1))^2)/(dc); % ������
        % �Խ���Ԫ��
        b(i) = (u(i+3 +1)-u(i+2 +1))*(u(i+2 +1)-u(i +1))/da + ...
            (u(i+2 +1)-u(i+1 +1))*(u(i+4 +1)-u(i+2 +1))/dc;
        e(i,:) = Q(i-1 +1,:)*(u(i+3 +1)-u(i+1 +1));
    end
    
    A = zeros(n-3, n-1);
    for j = 1:n-3
        A(j, j + 0) =  a(j +1 );
        A(j, j + 1) =  b(j+1);
        A(j, j + 2) =  c(j +1 );
    end
    A = [zeros(2,n-1);A;zeros(2,n-1)];
    e = [zeros(1,col);e;zeros(1,col)];
    
    qv0 = [0, 0]; qvn = [0,0];
    e(1,:) = Q(0+ 1,:) + (u(4+ 1)-u(3+ 1))*qv0/3;
    e(n,:) = Q(n-2 +1,:) - (u(n+1 +1)-u(n+ 1))*qvn/3;
    e(2,:) = (u(5+ 1)-u(2+ 1))*Q(0+ 1,:);
    e(n+1,:) = (u(n+2 +1)-u(n-1 +1))*Q(n-2 +1,:);
    
    
    b_1 = 1;
    b_n = 1;
    A(1,1) = b_1; A(n,n-1) = b_n; 
    
  
    A(2,2) = u(5+ 1)+u(4+ 1)-u(2+ 1)-u(1+ 1);
    A(2,3) = -(u(4 +1)-u(1+ 1));
    A(n+1,n-2) = -(u(n+3 +1)-u(n+ 1));
    A(n+1,n-1) = u(n+3 +1)+u(n+2 +1)-u(n+ 1)-u(n-1 +1);
    d = inv(A'*A)*A'*e;
    d = [Q(1,:);d;Q(end,:)];   % ��������˵㣨Ҫ�����˵㣩
    
end

end

