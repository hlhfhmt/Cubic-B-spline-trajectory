function u = para( r,Q,k,paraValue )
% para���������ݵ�Ĳ�����
%---------------------------
% ���룺
% r: ���ݵ�����±�����
% Q�����ݵ㣨����ֵ�㣩
% k: B��������
% paraValue������������
%---------------------------
% �����
% u��clamped ���͵Ľڵ�����
%---------------------------
 u = zeros(1, r + 1);
switch paraValue
    case 1   % ���Ȳ�����
        for i = 1:r
            u(i+1 ) = i;
        end
    case 2  % �ۻ��ҳ���
        for i = 0:r-1
            delta = norm(Q(i+1 +1,:)-Q(i+ 1,:));
            u(i+1 +1) = u(i+ 1) + delta;
        end
    case 3 % ���Ĳ�����
        for i = 0:r-1
            delta = sqrt(norm(Q(i+1 +1,:)-Q(i+ 1,:)));
            u(i+1 +1) = u(i+ 1) + delta;
        end
    otherwise
end
        
u = u/u(r + 1);     % �ڵ�淶��
u = [zeros(1,k) u ones(1,k)];



end

