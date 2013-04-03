%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%一个三维坐标插值点的函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%code by Zhangfeng@ustb 2010-5-12
%%%%由于在三维点云阵列中，坐标的实际位置往往不在扫描点的位置上，这就需要我们运用
%%%%插值的方法处理，本函数依据boosting的思想，结合该点四邻域的情况进行投票，并最终确定
%%%%该点的三维深度。为防止临域的无效点，本方法还提出了多级扩展四临域的方法。

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  A B
%  C D

function [interpResult_x,interpResult_y,interpResult_z] = BoostingInterp(x, y, pic_h, P3D) %,axx,bxx,cxx,dxx

%x为二维像素的x坐标；y为二维像素的y，pic_w为图像的w,后经查明为高
hax = floor(x); hay = floor(y);
hbx = ceil(x); hby = floor(y);
hcx = floor(x); hcy = ceil(y);
hdx = ceil(x); hdy = ceil(y);

%numa = (hay-1)*pic_w + hax;%由对齐耳洞时的操作得知，这里的检索机制是错的
%numb = (hby-1)*pic_w + hbx;
%numc = (hcy-1)*pic_w + hcx;
%numd = (hdy-1)*pic_w + hdx;

numa = (hax-1)*pic_h + hay;
numb = (hbx-1)*pic_h + hby;
numc = (hcx-1)*pic_h + hcy;
numd = (hdx-1)*pic_h + hdy;

az = P3D(numa, 3); ax = P3D(numa, 1); ay = P3D(numa, 2);
bz = P3D(numb, 3); bx = P3D(numb, 1); by = P3D(numb, 2); 
cz = P3D(numc, 3); cx = P3D(numc, 1); cy = P3D(numc, 2);
dz = P3D(numd, 3); dx = P3D(numd, 1); dy = P3D(numd, 2);

if az == -999999
     [ax, ay, az] =  extendInterp(numa, pic_h, P3D);     
end
if bz == -999999
     [bx, by, bz] =  extendInterp(numb, pic_h, P3D);
end
if cz == -999999
     [cx, cy, cz] =  extendInterp(numc, pic_h, P3D);
end
if dz == -999999
     [dx, dy, dz] =  extendInterp(numd, pic_h, P3D);
end

b = x-hax; %由二维图像传进来的比例系数
a = y-hay;

%axx=az;
%bxx=bz;
%cxx=cz;
%dxx=dz;

interpResult_z = (1-b)*(a*cz+(1-a)*az)+b*(a*dz+(1-a)*bz);
interpResult_x = (1-b)*(a*cx+(1-a)*ax)+b*(a*dx+(1-a)*bx);
interpResult_y = (1-b)*(a*cy+(1-a)*ay)+b*(a*dy+(1-a)*by);
return;
end
%-------------------------------------------------------------------------%
% 3  2  1  4  5 
% 7  2  1  3  8  
% 6  4  *  4  6
% 8  3  1  2  7
% 5  4  1  2  3
% boosting 扩展临域插值

function [xx , yy , zz] = extendInterp(num, pic_h, P3D)

%%%扩展八临域操作

if (P3D(num-1, 3)~= -999999)&&(P3D(num+1, 3)~= -999999) %% 上下
    zz = (P3D(num-1, 3)+P3D(num+1, 3))/2;
    xx = (P3D(num-1, 1)+P3D(num+1, 1))/2;
    yy = (P3D(num-1, 2)+P3D(num+1, 2))/2;
    return;
end

if (P3D(num-pic_h-1, 3)~= -999999)&&(P3D(num+pic_h+1, 3)~= -999999) %% 左对角线
    zz = (P3D(num-pic_h-1, 3)+P3D(num+pic_h+1, 3))/2;
    xx = (P3D(num-pic_h-1, 1)+P3D(num+pic_h+1, 1))/2;
    yy = (P3D(num-pic_h-1, 2)+P3D(num+pic_h+1, 2))/2;
    return;
end

if (P3D(num-pic_h+1, 3)~= -999999)&&(P3D(num+pic_h-1, 3)~= -999999) %% 右对角线
    zz = (P3D(num-pic_h+1, 3)+P3D(num+pic_h-1, 3))/2;
    xx = (P3D(num-pic_h+1, 1)+P3D(num+pic_h-1, 1))/2;
    yy = (P3D(num-pic_h+1, 2)+P3D(num+pic_h-1, 2))/2;
    return;
end

if (P3D(num-pic_h, 3)~= -999999)&&(P3D(num+pic_h, 3)~= -999999) %% 左右
    zz = (P3D(num-pic_h, 3)+P3D(num+pic_h, 3))/2;
    xx = (P3D(num-pic_h, 1)+P3D(num+pic_h, 1))/2;
    yy = (P3D(num-pic_h, 2)+P3D(num+pic_h, 2))/2;
    return;
end

%%%扩展16临域操作

if (P3D(num-2, 3)~= -999999)&&(P3D(num+2, 3)~= -999999) %% 上下
    zz = (P3D(num-2, 3)+P3D(num+2, 3))/2;
    xx = (P3D(num-2, 1)+P3D(num+2, 1))/2;
    yy = (P3D(num-2, 2)+P3D(num+2, 2))/2;
    return;
end

if (P3D(num-pic_h-2, 3)~= -999999)&&(P3D(num+pic_h+2, 3)~= -999999) %% 上偏左对角线
    zz = (P3D(num-pic_h-2, 3)+P3D(num+pic_h+2, 3))/2;
    xx = (P3D(num-pic_h-2, 1)+P3D(num+pic_h+2, 1))/2;
    yy = (P3D(num-pic_h-2, 2)+P3D(num+pic_h+2, 2))/2;
    return;
end

if (P3D(num-2*pic_h-2, 3)~= -999999)&&(P3D(num+2*pic_h+2, 3)~= -999999) %% 左主对角
    zz = (P3D(num-2*pic_h-2, 3)+P3D(num+2*pic_h+2, 3))/2;
    xx = (P3D(num-2*pic_h-2, 1)+P3D(num+2*pic_h+2, 1))/2;
    yy = (P3D(num-2*pic_h-2, 2)+P3D(num+2*pic_h+2, 2))/2;
    return;
end

if (P3D(num-pic_h+2, 3)~= -999999)&&(P3D(num+pic_h-2, 3)~= -999999) %% 上偏右对角线
    zz = (P3D(num-pic_h+2, 3)+P3D(num+pic_h-2, 3))/2;
    xx = (P3D(num-pic_h+2, 1)+P3D(num+pic_h-2, 1))/2;
    yy = (P3D(num-pic_h+2, 2)+P3D(num+pic_h-2, 2))/2;
    return;
end

if (P3D(num-2*pic_h+2, 3)~= -999999)&&(P3D(num+2*pic_h-2, 3)~= -999999) %% 右对角线
    zz = (P3D(num-2*pic_h+2, 3)+P3D(num+2*pic_h-2, 3))/2;
    xx = (P3D(num-2*pic_h+2, 1)+P3D(num+2*pic_h-2, 1))/2;
    yy = (P3D(num-2*pic_h+2, 2)+P3D(num+2*pic_h-2, 2))/2;
    return;
end

if (P3D(num-2*pic_h, 3)~= -999999)&&(P3D(num+2*pic_h, 3)~= -999999) %% 左右
    zz = (P3D(num-2*pic_h, 3)+P3D(num+2*pic_h, 3))/2;
    xx = (P3D(num-2*pic_h, 1)+P3D(num+2*pic_h, 1))/2;
    yy = (P3D(num-2*pic_h, 2)+P3D(num+2*pic_h, 2))/2;
    return;
end

if (P3D(num-2*pic_h-1, 3)~= -999999)&&(P3D(num+2*pic_h+1, 3)~= -999999) %% 左偏上对角线
    zz = (P3D(num-2*pic_h-1, 3)+P3D(num+2*pic_h+1, 3))/2;
    xx = (P3D(num-2*pic_h-1, 1)+P3D(num+2*pic_h+1, 1))/2;
    yy = (P3D(num-2*pic_h-1, 2)+P3D(num+2*pic_h+1, 2))/2;
    return;
end

if (P3D(num-2*pic_h+1, 3)~= -999999)&&(P3D(num+2*pic_h-1, 3)~= -999999) %% 左偏下对角线
    zz = (P3D(num-2*pic_h+1, 3)+P3D(num+2*pic_h-1, 3))/2;
    xx = (P3D(num-2*pic_h+1, 1)+P3D(num+2*pic_h-1, 1))/2;
    yy = (P3D(num-2*pic_h+1, 2)+P3D(num+2*pic_h-1, 2))/2;
    return;
end

%%%对于极度边缘点，直接等于他旁边的点
%%%下面是等于他八临域的点
if  P3D(num+1, 3)~= -999999 %% 下
    zz = P3D(num+1, 3);
    xx = P3D(num+1, 1);
    yy = P3D(num+1, 2);
    return;
end

if P3D(num-pic_h+1, 3)~= -999999 %% 左下
    zz = P3D(num-pic_h+1, 3);
    xx = P3D(num-pic_h+1, 1);
    yy = P3D(num-pic_h+1, 2);
    return;
end

if P3D(num+pic_h+1, 3)~= -999999 %% 右下
    zz = P3D(num+pic_h+1, 3);
    xx = P3D(num+pic_h+1, 1);
    yy = P3D(num+pic_h+1, 2);
    return;
end

if P3D(num-pic_h, 3)~= -999999 %% 左
    zz = P3D(num-pic_h, 3);
    xx = P3D(num-pic_h, 1);
    yy = P3D(num-pic_h, 2);
    return;
end

if P3D(num+pic_h, 3)~= -999999 %% 右
    zz = P3D(num+pic_h, 3);
    xx = P3D(num+pic_h, 1);
    yy = P3D(num+pic_h, 2);
    return;
end

if  P3D(num-1, 3)~= -999999 %% 上
    zz = P3D(num-1, 3);
    xx = P3D(num-1, 1);
    yy = P3D(num-1, 2);
    return;
end

if P3D(num-pic_h-1, 3)~= -999999 %% 左上
    zz = P3D(num-pic_h-1, 3);
    xx = P3D(num-pic_h-1, 1);
    yy = P3D(num-pic_h-1, 2);
    return;
end

if P3D(num+pic_h+1, 3)~= -999999 %% 右上
    zz = P3D(num+pic_h+1, 3);
    xx = P3D(num+pic_h+1, 1);
    yy = P3D(num+pic_h+1, 2);
    return;
%else
%    display('你猜对了，他是超越了我们的能力范围')
end

%      *
% 1 12 13 14 15
% 8          11
% 7    *     10    
% 6          9
% 1 2  3  4  5 
%      *

%%%下面是等于他十六临域的点
if  P3D(num+2, 3)~= -999999 %% 下下
    zz = P3D(num+2, 3);
    xx = P3D(num+2, 1);
    yy = P3D(num+2, 2);
    return;
end

if P3D(num-2, 3)~= -999999 %% 上上
    zz = P3D(num-2, 3);
    xx = P3D(num-2, 1);
    yy = P3D(num-2, 2);
    return;
end

if P3D(num+pic_h+2, 3)~= -999999 %% 右下下
    zz = P3D(num+pic_h+2, 3);
    xx = P3D(num+pic_h+2, 1);
    yy = P3D(num+pic_h+2, 2);
    return;
end

if P3D(num-pic_h+2, 3)~= -999999 %% 左下下
    zz = P3D(num-pic_h+2, 3);
    xx = P3D(num-pic_h+2, 1);
    yy = P3D(num-pic_h+2, 2);
    return;
end

if P3D(num+pic_h-2, 3)~= -999999 %% 右上上
    zz = P3D(num+pic_h-2, 3);
    xx = P3D(num+pic_h-2, 1);
    yy = P3D(num+pic_h-2, 2);
    return;
end

if  P3D(num-pic_h-2, 3)~= -999999 %% 左上上
    zz = P3D(num-pic_h-2, 3);
    xx = P3D(num-pic_h-2, 1);
    yy = P3D(num-pic_h-2, 2);
    return;
end
% 十字极度扩展临域
kk=3;
if P3D(num+kk, 3)~= -999999 %% 下下下
    zz = P3D(num+kk, 3);
    xx = P3D(num+kk, 1);
    yy = P3D(num+kk, 2);
    return;
end

if P3D(num-kk, 3)~= -999999 %% 上上上
    zz = P3D(num-kk, 3);
    xx = P3D(num-kk, 1);
    yy = P3D(num-kk, 2);
    return;
end

if P3D(num-kk*pic_h, 3)~= -999999 %% 左左左
    zz = P3D(num-kk*pic_h, 3);
    xx = P3D(num-kk*pic_h, 1);
    yy = P3D(num-kk*pic_h, 2);
    return;
end
if P3D(num+kk*pic_h, 3)~= -999999 %% 右右右
    zz = P3D(num+kk*pic_h, 3);
    xx = P3D(num+kk*pic_h, 1);
    yy = P3D(num+kk*pic_h, 2);
    return;
else
    display('错误原因：无效点越界！！')
end

end








