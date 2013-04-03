
%%%%%%code by zhangfeng ustb-ear-recognition-lab @USTB  2010-5-11
%%%%该程序用于找出耳洞，并把所有的三维数据坐标归一化到该点%%%%%
%%%%中间在选择耳洞时，为了防止点到的耳洞是无效点，采取了横向震荡的策略%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
ear=dir('L:\400\2D_ear\');
num_ear=size(ear,1);
for k=3:num_ear
    %% 选耳洞
    % fid=imread(['C:\Documents and Settings\Administrator\桌面\2D人耳改\' ear(k).name]);
    fid=imread(['L:\400\2D_ear\' ear(k).name(1:9) '_ear.jpg']);
    % figure((k-2)*2-1)
    figure(1)
    imshow(fid);
    % title(ear(k).name)
    title([ear(k).name(1:9) ' -- ' num2str(k-2)])
    [h,w,rgb]=size(fid);
    % ear(k).name
    hold on
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 左上角的点 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x1, y1]=ginput(1); %选取人耳耳洞
    plot(x1,y1,'.r','linewidth',2);
    x1=round(x1);
    y1=round(y1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 右下角的点 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x2, y2]=ginput(1); %选取人耳耳洞
    plot(x2,y2,'.r','linewidth',2);
    x2=round(x2);
    y2=round(y2);
    %%%%%%%%%%%%%%%%%%%%%%%%% 画出耳洞选择区域 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    line([x1 x1],[y1 y2],'Color','b');
    line([x1 x2],[y1 y1],'Color','b');
    line([x1 x2],[y2 y2],'Color','b');
    line([x2 x2],[y1 y2],'Color','b');
    %%%%%%%%%%%%%%%%%%%%%%%%% 挑出区域中的二维点 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    earhole_area = [];
    % for i=1:((x2-x1+1)*(y2-y1+1))_
    for m=x1:x2
        for n=y1:y2
            num=(m-1)*h+n;
            earhole_area = [earhole_area,num];
        end
    end
    % end
    hold off
    
    
    %% 读入原始三维数据,确定最终的耳洞点并归一化坐标原点
    % fid1=load(['C:\Documents and Settings\Administrator\桌面\3D人耳改\' ear(k).name(1:9) 'ear.txt'],'r');%读入文件路径
    fid1=load(['L:\400\3D_ear_smoothed\' ear(k).name(1:9) 'ear_smoothed.txt'],'r');
    [a,b]=size(fid1);
    X = fid1(:,1);
    Y = fid1(:,2);
    Z = fid1(:,3);
    
    [earholeZ,earholeInd] = min(Z(earhole_area));
    earhole_num = earhole_area(earholeInd); %在总人耳中的点数
    earhole_x = ceil(earholeInd/(y2-y1+1))+(x1-1);
    earhole_y = mod(earholeInd,(y2-y1+1))+(y1-1);
    earhole = [earhole_x,earhole_y];
    save(['L:\400\3D_var\' ear(k).name(1:9) '_earhole'],'earhole')
    % save(['新划分后的训练数据\' num2str(k) '\earhole']) % 把耳洞的二维坐标存起来
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%  删去这一部分  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % if X(num)==-999999 %横向震荡搜寻策略防止点出的耳洞是无效点。               %
    %     display('开荡')                                                     %
    %     num=num-1                                                           %
    %     if X(num)==-999999                                                  %
    %         num=num+2                                                       %
    %         if X(num)==-999999                                              %
    %             num=num-3                                                   %
    %             if X(num)==-999999                                          %
    %                  num=num+4                                              %
    %             end                                                         %
    %         end                                                             %
    %     end                                                                 %
    % end                                                                     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    holeX=X(earhole_num);
    holeY=Y(earhole_num);
    holeZ=Z(earhole_num);
    % X1_formal=X(1);
    % Y1_formal=Y(1);
    % Z1_formal=Z(1);
    for i=1:a
        %     if X(i)~=-999999 % && Y(i)~=-999999
        X(i) = X(i)-holeX;
        Y(i) = Y(i)-holeY;
        Z(i) = Z(i)-holeZ; %第一次忘记统一Z了，酿成大错
        %     end
    end
    % X1_end=X(1)
    % Y1_end=Y(1)
    % Z1_end=Z(1)
    cha=X-fid1(:,1);
    sizecha=size(cha);
    %% 显示坐标移动后的人耳有效点
    t=0;
    valid=[];
    for i=1:a
        if X(i)~=-999999
            t=t+1;
            valid(t)=i;
        end
    end
    XX=X(valid);
    YY=Y(valid);
    ZZ=Z(valid);
    % figure((k-2)*2)
    figure(2)
    plot3(XX,YY,ZZ,'.r')
    hold on
    plot3(X(earhole_num),Y(earhole_num),Z(earhole_num),'*b','linewidth',4) %显示耳洞的位置
    grid on
    hold off
    set(gcf,'color','w')
    %% 保存新的坐标，还是按n*3的形式
    % fid2=fopen(['C:\Documents and Settings\Administrator\桌面\3D调整坐标后的人耳改\' ear(k).name(1:9) 'hole.txt'],'w');%写入文件路径
    fid2=fopen(['L:\400\3D_earhole\' ear(k).name(1:9) '_earholed.txt'],'w');%写入文件路径
    for i=1:a
        fprintf(fid2,'%g\t',X(i));
        fprintf(fid2,'%g\t',Y(i));
        fprintf(fid2,'%g\n',Z(i));
    end
    fclose(fid2);
    display(['第' num2str(k-2) '个样本完毕！'])
end



