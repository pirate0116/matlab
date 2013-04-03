%% 找并画已知两点的中垂线的函数
%该函数只需输入两个端点的坐标和图像的宽和高，即可画出指导线。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [] = FindBisector (x1, y1, x2, y2, w, h)

xc=(x1+x2)/2;
yc=(y1+y2)/2;
plot(xc,yc,'.r','linewidth',2)
plot([x1,x2],[y1,y2],'-b')

k2 = (y2-y1)/(x2-x1);

k=-1/k2;

y_end = k*(w-xc)+yc;

if y_end<=h & y_end>=0
    if xc > w/2
       plot([xc,w],[yc,y_end],'-c')
    end
    if xc < w/2
        if yc > h/2
            x_end = (h-yc)/k+xc;
            plot([xc,x_end],[yc,h],'-c')
        end
        if yc<= h/2 %多加这个判断就是为了防止2&9点的中垂线方向异常
            x_end=(0-yc)/k+xc;
            if x_end < 0
                plot([xc,w],[yc,k*(w-xc)+yc],'-c')
            else                
                plot([xc,x_end],[yc,0],'-c')
            end
        end
    end
end

if y_end<0
    if yc <= h/2
       x_end = (-yc/k)+xc;
       line([xc,x_end],[yc,0],'color','c')
    end
    if yc > h/2
       x_end = (h-yc)/k+xc;
       line([xc,x_end],[yc,h],'color','c')
    end
end

if y_end>h
    if yc >= h/2
       x_end = (h-yc)/k+xc;
       plot([xc,x_end],[yc,h],'-c')
    end
    if yc < h/2
       x_end = (-yc)/k+xc;
       plot([xc,x_end],[yc,0],'-c')
    end     
end
end