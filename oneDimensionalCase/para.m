function u = para( r,Q,k,paraValue )
% para：给定数据点的参数化
%---------------------------
% 输入：
% r: 数据点最大下标索引
% Q：数据点（待插值点）
% k: B样条次数
% paraValue：参数化方法
%---------------------------
% 输出：
% u：clamped 类型的节点向量
%---------------------------
 u = zeros(1, r + 1);
switch paraValue
    case 1   % 均匀参数法
        for i = 1:r
            u(i+1 ) = i;
        end
    case 2  % 累积弦长法
        for i = 0:r-1
            delta = norm(Q(i+1 +1,:)-Q(i+ 1,:));
            u(i+1 +1) = u(i+ 1) + delta;
        end
    case 3 % 向心参数法
        for i = 0:r-1
            delta = sqrt(norm(Q(i+1 +1,:)-Q(i+ 1,:)));
            u(i+1 +1) = u(i+ 1) + delta;
        end
    otherwise
end
        
u = u/u(r + 1);     % 节点规范化
u = [zeros(1,k) u ones(1,k)];



end

