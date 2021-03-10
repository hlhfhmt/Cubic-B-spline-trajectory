function x=purse(varargin)
% 在这里，我使用了类似函数重载的方法来处理输入量，原则上，应该是输入三对角方程组的A和b,但由于三对角矩阵的特殊性，输入的A实际上只是使用到了三条对角线
% 因此，函数重载这种处理做法既可以对输入值为完整的A、b进行处理，又能对输入值为用三个数组表示的三对角线和b进行处理。
% 这里的a,b,c指的是A中的三对角线
% 例如：
% b=2*ones(1,5);
% a=-1*ones(1,4); %为了方便对应矩阵A，这里的a从a2开始输入，而a1自动取0填填充数组空位
% c=-1*ones(1,4);
% f=[1 0 0 0 0];  %这个f指的是的是Ax=b中的b
% x=purse(b,a,c,f)
%                               
% x =
%
%     0.8333    0.6667    0.5000    0.3333    0.1667
                                                                                                                                                                                     
% 再例如：
% A=[2 -1 0 0 0;
%   -1 2 -1 0 0;
%   0 -1 2 -1 0;
%   0 0 -1 2 -1;
%   0 0 0 -1 2;]
% f=[1 0 0 0 0];  %这个f指的是的是Ax=b中的b
% x=purse(A,f)
%
% x =
%
%     0.8333    0.6667    0.5000    0.3333    0.1667
narginchk(2,4);
if nargin==2
    A=varargin{1};
    f=varargin{2};
    n=size(f,1);
    
    % 预分配
%     b = zeros(1,n); c=zeros(1,n-1); a = zeros(1,n-1);
    
    % 生成A的对角线元素数组b
    for i=1:n
        j=i;
        b(i)=A(i,j);
    end
    % 生成A的上对角线元素数组c
    for i=1:n-1
        j=i+1;
        c(i)=A(i,j);
    end
    % 生成A的下对角线元素数组a
    for i=2:n
        j=i-1;
        a(i-1)=A(i,j);
    end
elseif nargin==3
    error('请输入A,b或者输入b,c,a,f')
else
    b=varargin{1};
    c=varargin{3};
    a=varargin{2};
    f=varargin{4};
    n=size(f,1);
end

% 追的过程
a=[0 a]; %注意到公式中的a是从a2开始，所以把a1=0填充数组空位。
beta=c(1)/b(1);
for i=2:n-1
    beta(i)=c(i)/(b(i)-a(i)*beta(i-1));
end
% y = zeros(1,n);
y(1,:)=f(1,:)/b(1);
for i=2:n
    y(i,:)=(f(i,:)-a(i)*y(i-1,:))/(b(i)-a(i)*beta(i-1));
end

% 赶的过程
x(n,:)=y(n,:);
for i=n-1:-1:1
    x(i,:)=y(i,:)-beta(i)*x(i+1,:);
end
end
