 %%%%%code by zhangfeng @ ustb ear lab. 2010-5-16
 %%%本程序意在将一段线段n等细分
 %%%这里给入两点，进行32分
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 function [x, y] = TessellatedLine (xc, yc, x2, y2)
 % 这个是要划32层的，就是每个扇边上的点数为32,xc是线段的起始点
 
 t=0;
 x=[];
 y=[];
 num = 32; % 除去顶尖后有32层
 
 for i = 1:num
     t = t+1;
     x(t) = i*(x2-xc)/num+xc;
     y(t) = i*(y2-yc)/num+yc;
 end
 
 end
 
        