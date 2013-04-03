 %%%%%code by zhangfeng @ ustb ear lab. 2010-5-16
 %%%本程序意在将初步扇形分割后的人耳区域进行网格细分（to Tessellate Mesh），经
 %%%初步计算得知，三角形三边32等分为最佳
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 function [x, y] = TessellatedMesh (xl, yl, xr, yr)
 
 t=0;
 x=[];
 y=[];
 layer = 32; % 除去顶尖后有32层
 for j = 2:layer 
     for i = 1:(j-1)
         t = t+1;
         x(t) = i*(xr(j)-xl(j))/j+xl(j);
         y(t) = i*(yr(j)-yl(j))/j+yl(j);
     end
 end
        
 end
 