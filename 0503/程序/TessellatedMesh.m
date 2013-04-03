 %%%%%code by zhangfeng @ ustb ear lab. 2010-5-16
 %%%���������ڽ��������ηָ����˶������������ϸ�֣�to Tessellate Mesh������
 %%%���������֪������������32�ȷ�Ϊ���
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 function [x, y] = TessellatedMesh (xl, yl, xr, yr)
 
 t=0;
 x=[];
 y=[];
 layer = 32; % ��ȥ�������32��
 for j = 2:layer 
     for i = 1:(j-1)
         t = t+1;
         x(t) = i*(xr(j)-xl(j))/j+xl(j);
         y(t) = i*(yr(j)-yl(j))/j+yl(j);
     end
 end
        
 end
 