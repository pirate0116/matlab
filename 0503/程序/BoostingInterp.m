%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%һ����ά�����ֵ��ĺ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%code by Zhangfeng@ustb 2010-5-12
%%%%��������ά���������У������ʵ��λ����������ɨ����λ���ϣ������Ҫ��������
%%%%��ֵ�ķ�����������������boosting��˼�룬��ϸõ���������������ͶƱ��������ȷ��
%%%%�õ����ά��ȡ�Ϊ��ֹ�������Ч�㣬������������˶༶��չ������ķ�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  A B
%  C D

function [interpResult_x,interpResult_y,interpResult_z] = BoostingInterp(x, y, pic_h, P3D) %,axx,bxx,cxx,dxx

%xΪ��ά���ص�x���ꣻyΪ��ά���ص�y��pic_wΪͼ���w,�󾭲���Ϊ��
hax = floor(x); hay = floor(y);
hbx = ceil(x); hby = floor(y);
hcx = floor(x); hcy = ceil(y);
hdx = ceil(x); hdy = ceil(y);

%numa = (hay-1)*pic_w + hax;%�ɶ������ʱ�Ĳ�����֪������ļ��������Ǵ��
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

b = x-hax; %�ɶ�άͼ�񴫽����ı���ϵ��
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
% boosting ��չ�����ֵ

function [xx , yy , zz] = extendInterp(num, pic_h, P3D)

%%%��չ���������

if (P3D(num-1, 3)~= -999999)&&(P3D(num+1, 3)~= -999999) %% ����
    zz = (P3D(num-1, 3)+P3D(num+1, 3))/2;
    xx = (P3D(num-1, 1)+P3D(num+1, 1))/2;
    yy = (P3D(num-1, 2)+P3D(num+1, 2))/2;
    return;
end

if (P3D(num-pic_h-1, 3)~= -999999)&&(P3D(num+pic_h+1, 3)~= -999999) %% ��Խ���
    zz = (P3D(num-pic_h-1, 3)+P3D(num+pic_h+1, 3))/2;
    xx = (P3D(num-pic_h-1, 1)+P3D(num+pic_h+1, 1))/2;
    yy = (P3D(num-pic_h-1, 2)+P3D(num+pic_h+1, 2))/2;
    return;
end

if (P3D(num-pic_h+1, 3)~= -999999)&&(P3D(num+pic_h-1, 3)~= -999999) %% �ҶԽ���
    zz = (P3D(num-pic_h+1, 3)+P3D(num+pic_h-1, 3))/2;
    xx = (P3D(num-pic_h+1, 1)+P3D(num+pic_h-1, 1))/2;
    yy = (P3D(num-pic_h+1, 2)+P3D(num+pic_h-1, 2))/2;
    return;
end

if (P3D(num-pic_h, 3)~= -999999)&&(P3D(num+pic_h, 3)~= -999999) %% ����
    zz = (P3D(num-pic_h, 3)+P3D(num+pic_h, 3))/2;
    xx = (P3D(num-pic_h, 1)+P3D(num+pic_h, 1))/2;
    yy = (P3D(num-pic_h, 2)+P3D(num+pic_h, 2))/2;
    return;
end

%%%��չ16�������

if (P3D(num-2, 3)~= -999999)&&(P3D(num+2, 3)~= -999999) %% ����
    zz = (P3D(num-2, 3)+P3D(num+2, 3))/2;
    xx = (P3D(num-2, 1)+P3D(num+2, 1))/2;
    yy = (P3D(num-2, 2)+P3D(num+2, 2))/2;
    return;
end

if (P3D(num-pic_h-2, 3)~= -999999)&&(P3D(num+pic_h+2, 3)~= -999999) %% ��ƫ��Խ���
    zz = (P3D(num-pic_h-2, 3)+P3D(num+pic_h+2, 3))/2;
    xx = (P3D(num-pic_h-2, 1)+P3D(num+pic_h+2, 1))/2;
    yy = (P3D(num-pic_h-2, 2)+P3D(num+pic_h+2, 2))/2;
    return;
end

if (P3D(num-2*pic_h-2, 3)~= -999999)&&(P3D(num+2*pic_h+2, 3)~= -999999) %% �����Խ�
    zz = (P3D(num-2*pic_h-2, 3)+P3D(num+2*pic_h+2, 3))/2;
    xx = (P3D(num-2*pic_h-2, 1)+P3D(num+2*pic_h+2, 1))/2;
    yy = (P3D(num-2*pic_h-2, 2)+P3D(num+2*pic_h+2, 2))/2;
    return;
end

if (P3D(num-pic_h+2, 3)~= -999999)&&(P3D(num+pic_h-2, 3)~= -999999) %% ��ƫ�ҶԽ���
    zz = (P3D(num-pic_h+2, 3)+P3D(num+pic_h-2, 3))/2;
    xx = (P3D(num-pic_h+2, 1)+P3D(num+pic_h-2, 1))/2;
    yy = (P3D(num-pic_h+2, 2)+P3D(num+pic_h-2, 2))/2;
    return;
end

if (P3D(num-2*pic_h+2, 3)~= -999999)&&(P3D(num+2*pic_h-2, 3)~= -999999) %% �ҶԽ���
    zz = (P3D(num-2*pic_h+2, 3)+P3D(num+2*pic_h-2, 3))/2;
    xx = (P3D(num-2*pic_h+2, 1)+P3D(num+2*pic_h-2, 1))/2;
    yy = (P3D(num-2*pic_h+2, 2)+P3D(num+2*pic_h-2, 2))/2;
    return;
end

if (P3D(num-2*pic_h, 3)~= -999999)&&(P3D(num+2*pic_h, 3)~= -999999) %% ����
    zz = (P3D(num-2*pic_h, 3)+P3D(num+2*pic_h, 3))/2;
    xx = (P3D(num-2*pic_h, 1)+P3D(num+2*pic_h, 1))/2;
    yy = (P3D(num-2*pic_h, 2)+P3D(num+2*pic_h, 2))/2;
    return;
end

if (P3D(num-2*pic_h-1, 3)~= -999999)&&(P3D(num+2*pic_h+1, 3)~= -999999) %% ��ƫ�϶Խ���
    zz = (P3D(num-2*pic_h-1, 3)+P3D(num+2*pic_h+1, 3))/2;
    xx = (P3D(num-2*pic_h-1, 1)+P3D(num+2*pic_h+1, 1))/2;
    yy = (P3D(num-2*pic_h-1, 2)+P3D(num+2*pic_h+1, 2))/2;
    return;
end

if (P3D(num-2*pic_h+1, 3)~= -999999)&&(P3D(num+2*pic_h-1, 3)~= -999999) %% ��ƫ�¶Խ���
    zz = (P3D(num-2*pic_h+1, 3)+P3D(num+2*pic_h-1, 3))/2;
    xx = (P3D(num-2*pic_h+1, 1)+P3D(num+2*pic_h-1, 1))/2;
    yy = (P3D(num-2*pic_h+1, 2)+P3D(num+2*pic_h-1, 2))/2;
    return;
end

%%%���ڼ��ȱ�Ե�㣬ֱ�ӵ������Աߵĵ�
%%%�����ǵ�����������ĵ�
if  P3D(num+1, 3)~= -999999 %% ��
    zz = P3D(num+1, 3);
    xx = P3D(num+1, 1);
    yy = P3D(num+1, 2);
    return;
end

if P3D(num-pic_h+1, 3)~= -999999 %% ����
    zz = P3D(num-pic_h+1, 3);
    xx = P3D(num-pic_h+1, 1);
    yy = P3D(num-pic_h+1, 2);
    return;
end

if P3D(num+pic_h+1, 3)~= -999999 %% ����
    zz = P3D(num+pic_h+1, 3);
    xx = P3D(num+pic_h+1, 1);
    yy = P3D(num+pic_h+1, 2);
    return;
end

if P3D(num-pic_h, 3)~= -999999 %% ��
    zz = P3D(num-pic_h, 3);
    xx = P3D(num-pic_h, 1);
    yy = P3D(num-pic_h, 2);
    return;
end

if P3D(num+pic_h, 3)~= -999999 %% ��
    zz = P3D(num+pic_h, 3);
    xx = P3D(num+pic_h, 1);
    yy = P3D(num+pic_h, 2);
    return;
end

if  P3D(num-1, 3)~= -999999 %% ��
    zz = P3D(num-1, 3);
    xx = P3D(num-1, 1);
    yy = P3D(num-1, 2);
    return;
end

if P3D(num-pic_h-1, 3)~= -999999 %% ����
    zz = P3D(num-pic_h-1, 3);
    xx = P3D(num-pic_h-1, 1);
    yy = P3D(num-pic_h-1, 2);
    return;
end

if P3D(num+pic_h+1, 3)~= -999999 %% ����
    zz = P3D(num+pic_h+1, 3);
    xx = P3D(num+pic_h+1, 1);
    yy = P3D(num+pic_h+1, 2);
    return;
%else
%    display('��¶��ˣ����ǳ�Խ�����ǵ�������Χ')
end

%      *
% 1 12 13 14 15
% 8          11
% 7    *     10    
% 6          9
% 1 2  3  4  5 
%      *

%%%�����ǵ�����ʮ������ĵ�
if  P3D(num+2, 3)~= -999999 %% ����
    zz = P3D(num+2, 3);
    xx = P3D(num+2, 1);
    yy = P3D(num+2, 2);
    return;
end

if P3D(num-2, 3)~= -999999 %% ����
    zz = P3D(num-2, 3);
    xx = P3D(num-2, 1);
    yy = P3D(num-2, 2);
    return;
end

if P3D(num+pic_h+2, 3)~= -999999 %% ������
    zz = P3D(num+pic_h+2, 3);
    xx = P3D(num+pic_h+2, 1);
    yy = P3D(num+pic_h+2, 2);
    return;
end

if P3D(num-pic_h+2, 3)~= -999999 %% ������
    zz = P3D(num-pic_h+2, 3);
    xx = P3D(num-pic_h+2, 1);
    yy = P3D(num-pic_h+2, 2);
    return;
end

if P3D(num+pic_h-2, 3)~= -999999 %% ������
    zz = P3D(num+pic_h-2, 3);
    xx = P3D(num+pic_h-2, 1);
    yy = P3D(num+pic_h-2, 2);
    return;
end

if  P3D(num-pic_h-2, 3)~= -999999 %% ������
    zz = P3D(num-pic_h-2, 3);
    xx = P3D(num-pic_h-2, 1);
    yy = P3D(num-pic_h-2, 2);
    return;
end
% ʮ�ּ�����չ����
kk=3;
if P3D(num+kk, 3)~= -999999 %% ������
    zz = P3D(num+kk, 3);
    xx = P3D(num+kk, 1);
    yy = P3D(num+kk, 2);
    return;
end

if P3D(num-kk, 3)~= -999999 %% ������
    zz = P3D(num-kk, 3);
    xx = P3D(num-kk, 1);
    yy = P3D(num-kk, 2);
    return;
end

if P3D(num-kk*pic_h, 3)~= -999999 %% ������
    zz = P3D(num-kk*pic_h, 3);
    xx = P3D(num-kk*pic_h, 1);
    yy = P3D(num-kk*pic_h, 2);
    return;
end
if P3D(num+kk*pic_h, 3)~= -999999 %% ������
    zz = P3D(num+kk*pic_h, 3);
    xx = P3D(num+kk*pic_h, 1);
    yy = P3D(num+kk*pic_h, 2);
    return;
else
    display('����ԭ����Ч��Խ�磡��')
end

end








