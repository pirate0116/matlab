%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% code by zhangfeng@ustb 2010
%
% 改变原点的程序，为了防止噪声的干扰，将原点由耳洞移动到校准轴的中点
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SSnew] = ChangeOrigPnt( SS )
   num = size(SS,1)/3;
   SSt = reshape(SS, 3, num);
   SSt = SSt';
   SStt = [];
   for ii = 1:num
       ptx =  SSt(ii,1) - SSt(1,1);
       pty =  SSt(ii,2) - SSt(1,2);
       ptz =  SSt(ii,3) - SSt(10993,3);
       SStt = [SStt;ptx;pty;ptz];
   end
   SSnew = SStt;
end 