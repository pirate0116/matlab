%%%%code by zhanfeng
%%%%�ú���������������ֵ���������������Ԫ�ĸ���
%%%%�������Ԫ����
%%%%���룺D��������ֵ�ĶԽ�������ֵ�Ӵ�С���β������Խ����ϣ�
%%%%      rankTolerance������������ֵ


function NumofPrincipleEig = NumPrincipleEig(D, rankTolerance)

a = fliplr(D);
a = flipud(a);
aa = diag(a);
s=size(aa,1);

for n=1:s
    rito=sum(aa(1:n))/sum(aa(1:s));
    if rito > rankTolerance
        NumofPrincipleEig = n;
        return %ֱ�ӽ���������
    end
end
display('���棺�����ʶ������û���ҵ����ʵĸ���������')
end
