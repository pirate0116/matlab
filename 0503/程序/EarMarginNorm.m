%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% code by zhangfeng @ ustb                                                %
%                                                                         %
% 此函数意在将各个样本耳的尺度归一化。这里的EarMargin是指人耳的长             %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SSnew] = EarMarginNorm(SS)

num = size(SS,1)/3;
SSt = reshape(SS, 3, num);
SSt = SSt';
SStt = [];
SSy = SSt(:,2);
SSymax = max(SSy);
SSymin = min(SSy);
EarMargin = abs(SSymax-SSymin);
ScaleRatio = 60/EarMargin; 
for ii = 1:num
    ptx =  SSt(ii,1)*ScaleRatio;
    pty =  SSt(ii,2)*ScaleRatio;
    ptz =  SSt(ii,3)*ScaleRatio;
    SStt = [SStt;ptx;pty;ptz];
end
SSnew = SStt;

end

