%%%%code by zhanfeng
%%%%该函数用于依据特征值方差贡献率来定义主元的个数
%%%%输出：主元个数
%%%%输入：D——特征值的对角阵（特征值从大到小依次布在主对角线上）
%%%%      rankTolerance——贡献率阈值


function NumofPrincipleEig = NumPrincipleEig(D, rankTolerance)

a = fliplr(D);
a = flipud(a);
aa = diag(a);
s=size(aa,1);

for n=1:s
    rito=sum(aa(1:n))/sum(aa(1:s));
    if rito > rankTolerance
        NumofPrincipleEig = n;
        return %直接结束函数了
    end
end
display('警告：贡献率定义过大，没有找到合适的个数！！！')
end
