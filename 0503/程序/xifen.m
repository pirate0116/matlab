%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% code by zhangfeng @ ustb ear-recognition lab                            %
%                                                                         %
% 上文程序已经完成了粗分且显示，下面进行细分，包括线细分和网细分              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
ear = dir('L:\400\2D_ear_355');
ear_num = size(ear,1);


for k = 267:ear_num
    
%     load('s.mat');
%     load('t.mat')
%     load('inner_ear_x.mat')
%     load('inner_ear_y.mat')
%     load('earhole.mat')
    earh = load(['L:\400\3D_var_355\' ear(k).name(1:9) '_earhole']);
    ears = load(['L:\400\3D_var_355\' ear(k).name(1:9) '_s']);
    eart = load(['L:\400\3D_var_355\' ear(k).name(1:9) '_t']);
    earinnerx = load(['L:\400\3D_var_355\' ear(k).name(1:9) '_inner_ear_x']);
    earinnery = load(['L:\400\3D_var_355\' ear(k).name(1:9) '_inner_ear_y']);
    
    earhole = earh.earhole;
    s = ears.s;
    t = eart.t;
    inner_ear_x = earinnerx.inner_ear_x;
    inner_ear_y = earinnery.inner_ear_y;
       
    %xc=(s(1)+s(2))/2; %求取中间点，即扇形中心
    %yc=(t(1)+t(2))/2;
    tic
    X=[earhole(1)];
    Y=[earhole(2)];
    
    %% 划分外耳16+2块区域
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳1+10;第一块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout1,yout1] = TessellatedLine(inner_ear_x(2), inner_ear_y(2), s(1), t(1)); % 线划分
    [xout10,yout10] = TessellatedLine(inner_ear_x(2), inner_ear_y(2), s(10), t(10)); % 线划分
    X=[X,xout1];
    Y=[Y,yout1];
    %tt=0;
    %for i=2:2:32
    %    tt=tt+1;
    %    xxc1(tt)=xc1(i);
    %    yyc1(tt)=yc1(i);
    %    xxc10(tt)=xc10(i);
    %    yyc10(tt)=yc10(i);
    %end
    [xo110,yo110] = TessellatedMesh(xout1, yout1, xout10, yout10); % 网格划分
    hold off
    figure(3) %这里要求上一步粗划分完后不要关闭figure(3)，这里要在其上作图
    plot(xo110,yo110,'.r')
    xo110_size = size(xo110);
    X=[X,xo110,xout10];
    Y=[Y,yo110,yout10];
%     sizeX=size(X)
    %pause
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳10+6;第二块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout6,yout6] = TessellatedLine(inner_ear_x(2), inner_ear_y(2), s(6), t(6)); % 线划分
    [xo106,yo106] = TessellatedMesh(xout10, yout10, xout6, yout6); % 网格划分
    hold on
    figure(3)
    plot(xo106,yo106,'.r')
    xo106_size = size(xo106);
    X=[X,xo106,xout6];
    Y=[Y,yo106,yout6];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳6+11;第三块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout11,yout11] = TessellatedLine(inner_ear_x(2), inner_ear_y(2), s(11), t(11)); % 线划分
    [xo611,yo611] = TessellatedMesh(xout6, yout6, xout11, yout11); % 网格划分
    hold on
    figure(3)
    plot(xo611,yo611,'.r')
    xo611_size = size(xo611);
    X=[X,xo611,xout11];
    Y=[Y,yo611,yout11];
    %plot(x611(10),y611(10),'og')
    %tri=delaunay(x611',y611');
    %trimesh(tri,x611',y611')
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳11+4;第四块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout11t,yout11t] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(11), t(11));
    [xout4,yout4] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(4), t(4)); % 线划分
    [xo114,yo114] = TessellatedMesh(xout11t, yout11t, xout4, yout4); % 网格划分
    hold on
    figure(3)
    plot(xo114,yo114,'.r')
    xo114_size = size(xo114);
    X=[X,xo114,xout4];
    Y=[Y,yo114,yout4];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳4+12;第五块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout12,yout12] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(12), t(12)); % 线划分
    [xo412,yo412] = TessellatedMesh(xout4, yout4, xout12, yout12); % 网格划分
    hold on
    figure(3)
    plot(xo412,yo412,'.r')
    xo412_size = size(xo412);
    X=[X,xo412,xout12];
    Y=[Y,yo412,yout12];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳12+7;第六块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout7,yout7] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(7), t(7)); % 线划分
    [xo127,yo127] = TessellatedMesh(xout12, yout12, xout7, yout7); % 网格划分
    hold on
    figure(3)
    plot(xo127,yo127,'.r')
    xo127_size = size(xo127);
    X=[X,xo127,xout7];
    Y=[Y,yo127,yout7];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳7+13;第七块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout13,yout13] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(13), t(13)); % 线划分
    [xo713,yo713] = TessellatedMesh(xout7, yout7, xout13, yout13); % 网格划分
    hold on
    figure(3)
    plot(xo713,yo713,'.r')
    xo713_size = size(xo713);
    X=[X,xo713,xout13];
    Y=[Y,yo713,yout13];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳13+3;第八块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout13t,yout13t] = TessellatedLine(inner_ear_x(4), inner_ear_y(4), s(13), t(13));
    [xout3,yout3] = TessellatedLine(inner_ear_x(4), inner_ear_y(4), s(3), t(3)); % 线划分
    [xo133,yo133] = TessellatedMesh(xout13t, yout13t, xout3, yout3); % 网格划分
    hold on
    figure(3)
    plot(xo133,yo133,'.r')
    xo133_size = size(xo133);
    X=[X,xo133,xout3];
    Y=[Y,yo133,yout3];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳3+14;第九块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout14,yout14] = TessellatedLine(inner_ear_x(4), inner_ear_y(4), s(14), t(14)); % 线划分
    [xo314,yo314] = TessellatedMesh(xout3, yout3, xout14, yout14); % 网格划分
    hold on
    figure(3)
    plot(xo314,yo314,'.r')
    xo314_size = size(xo314);
    X=[X,xo314,xout14];
    Y=[Y,yo314,yout14];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳14+8;第十块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout8,yout8] = TessellatedLine(inner_ear_x(4), inner_ear_y(4), s(8), t(8)); % 线划分
    [xo148,yo148] = TessellatedMesh(xout14, yout14, xout8, yout8); % 网格划分
    hold on
    figure(3)
    plot(xo148,yo148,'.r')
    xo148_size = size(xo148);
    X=[X,xo148,xout8];
    Y=[Y,yo148,yout8];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳8+15;第十一块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout8t,yout8t] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(8), t(8));
    [xout15,yout15] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(15), t(15)); % 线划分
    [xo815,yo815] = TessellatedMesh(xout8t, yout8t, xout15, yout15); % 网格划分
    hold on
    figure(3)
    plot(xo815,yo815,'.r')
    xo815_size = size(xo815);
    X=[X,xo815,xout15];
    Y=[Y,yo815,yout15];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳15+5;第十二块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout5,yout5] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(5), t(5)); % 线划分
    [xo155,yo155] = TessellatedMesh(xout15, yout15, xout5, yout5); % 网格划分
    hold on
    figure(3)
    plot(xo155,yo155,'.r')
    xo155_size = size(xo155);
    X=[X,xo155,xout5];
    Y=[Y,yo155,yout5];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳5+16;第十三块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout16,yout16] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(16), t(16)); % 线划分
    [xo516,yo516] = TessellatedMesh(xout5, yout5, xout16, yout16); % 网格划分
    hold on
    figure(3)
    plot(xo516,yo516,'.r')
    xo516_size = size(xo516);
    X=[X,xo516,xout16];
    Y=[Y,yo516,yout16];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳16+9;第十四块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout9,yout9] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(9), t(9)); % 线划分
    [xo169,yo169] = TessellatedMesh(xout16, yout16, xout9, yout9); % 网格划分
    hold on
    figure(3)
    plot(xo169,yo169,'.r')
    xo169_size = size(xo169);
    X=[X,xo169,xout9];
    Y=[Y,yo169,yout9];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳9+17;第十五块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout17,yout17] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(17), t(17)); % 线划分
    [xo917,yo917] = TessellatedMesh(xout9, yout9, xout17, yout17); % 网格划分
    hold on
    figure(3)
    plot(xo917,yo917,'.r')
    xo917_size = size(xo917);
    X=[X,xo917,xout17];
    Y=[Y,yo917,yout17];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳17+2;第十六块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xout2,yout2] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), s(2), t(2)); % 线划分
    [xo172,yo172] = TessellatedMesh(xout17, yout17, xout2, yout2); % 网格划分
    hold on
    figure(3)
    plot(xo172,yo172,'.r')
    xo172_size = size(xo172);
    X=[X,xo172,xout2];
    Y=[Y,yo172,yout2];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳外2+内1;第十七块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xi5i1,yi5i1] = TessellatedLine(inner_ear_x(5), inner_ear_y(5), inner_ear_x(1), inner_ear_y(1)); % 线划分
    [xo2i1,yo2i1] = TessellatedMesh(xout2, yout2, xi5i1, yi5i1); % 网格划分
    hold on
    figure(3)
    plot(xo2i1,yo2i1,'.r')
    xo2i1_size = size(xo2i1);
    X=[X,xo2i1];
    Y=[Y,yo2i1];
%     sizeX=size(X)
    %size(X)
    %save X;
    %save Y;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳外1+内1;第十八块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xi2i1,yi2i1] = TessellatedLine(inner_ear_x(2), inner_ear_y(2), inner_ear_x(1), inner_ear_y(1)); % 线划分
    [xo1i1,yo1i1] = TessellatedMesh(xout1, yout1, xi2i1, yi2i1); % 网格划分
    hold on
    figure(3)
    plot(xo1i1,yo1i1,'.r')
    xo1i1_size = size(xo1i1);
    X=[X,xo1i1];
    Y=[Y,yo1i1];
%     sizeX=size(X)
    %% 划分内耳外延的三块
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳外11+内3;第一块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xine3,yine3] = TessellatedLine(inner_ear_x(2), inner_ear_y(2), inner_ear_x(3), inner_ear_y(3)); % 线划分
    %[xoute11,youte11] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(11), t(11));
    [xe1,ye1] = TessellatedMesh(xout11, yout11, xine3, yine3); % 网格划分
    hold on
    figure(3)
    plot(xe1,ye1,'.g')
    xe1_size = size(xe1);
    X=[X,xe1];
    Y=[Y,ye1];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳外13+内3;第一块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xine34,yine34] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), inner_ear_x(4), inner_ear_y(4)); % 线划分
    %[xout13,yout13] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(13), t(13));
    %[xoute11,youte11] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(11), t(11));
    [xe2,ye2] = TessellatedMesh(xout13, yout13, xine34, yine34); % 网格划分
    hold on
    figure(3)
    plot(xe2,ye2,'.g')
    xe2_size = size(xe2);
    X=[X,xe2];
    Y=[Y,ye2];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 划分外耳外8+内5;第一块 %%%%%%%%%%%%%%%%%%%%%%%%%%
    [xine5,yine5] = TessellatedLine(inner_ear_x(4), inner_ear_y(4), inner_ear_x(5), inner_ear_y(5)); % 线划分
    %[xoute11,youte11] = TessellatedLine(inner_ear_x(3), inner_ear_y(3), s(11), t(11));
    [xe3,ye3] = TessellatedMesh(xout8, yout8, xine5, yine5); % 网格划分
    hold on
    figure(3)
    plot(xe3,ye3,'.g')
    xe3_size = size(xe3);
    X=[X,xe3];
    Y=[Y,ye3];
%     sizeX=size(X)
    %% 划分内耳5块
    %%%%%%%%%%%%%%%%%%%%%%%%划分内耳1+2，第一块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xin1,yin1] = TessellatedLine(earhole(1), earhole(2), inner_ear_x(1), inner_ear_y(1)); % 线划分
    [xin2,yin2] = TessellatedLine(earhole(1), earhole(2), inner_ear_x(2), inner_ear_y(2)); % 线划分
    %X=[X,xout1];
    %Y=[Y,yout1];
    X=[X,xin1];
    Y=[Y,yin1];
    
    [xi12,yi12] = TessellatedMesh(xin1, yin1, xin2, yin2); % 网格划分
    hold on
    figure(3) %这里要求上一步粗划分完后不要关闭figure(3)，这里要在其上作图
    plot(xi12,yi12,'.y')
    xi12_size = size(xi12);
    X=[X,xi12,xin2];
    Y=[Y,yi12,yin2];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%划分内耳2+3，第二块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xin3,yin3] = TessellatedLine(earhole(1), earhole(2), inner_ear_x(3), inner_ear_y(3)); % 线划分
    [xi23,yi23] = TessellatedMesh(xin2, yin2, xin3, yin3); % 网格划分
    hold on
    figure(3) %这里要求上一步粗划分完后不要关闭figure(3)，这里要在其上作图
    plot(xi23,yi23,'.y')
    xi23_size = size(xi23);
    X=[X,xi23,xin3];
    Y=[Y,yi23,yin3];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%划分内耳3+4，第三块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xin4,yin4] = TessellatedLine(earhole(1), earhole(2), inner_ear_x(4), inner_ear_y(4)); % 线划分
    [xi34,yi34] = TessellatedMesh(xin3, yin3, xin4, yin4); % 网格划分
    hold on
    figure(3) %这里要求上一步粗划分完后不要关闭figure(3)，这里要在其上作图
    plot(xi34,yi34,'.y')
    xi34_size = size(xi34);
    X=[X,xi34,xin4];
    Y=[Y,yi34,yin4];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%划分内耳4+5，第四块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [xin5,yin5] = TessellatedLine(earhole(1), earhole(2), inner_ear_x(5), inner_ear_y(5)); % 线划分
    [xi45,yi45] = TessellatedMesh(xin4, yin4, xin5, yin5); % 网格划分
    hold on
    figure(3) %这里要求上一步粗划分完后不要关闭figure(3)，这里要在其上作图
    plot(xi45,yi45,'.y')
    xi45_size = size(xi45);
    X=[X,xi45,xin5];
    Y=[Y,yi45,yin5];
%     sizeX=size(X)
    %%%%%%%%%%%%%%%%%%%%%%%%划分内耳5+1，第五块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [xi51,yi51] = TessellatedMesh(xin5, yin5, xin1, yin1); % 网格划分
    hold on
    figure(3) %这里要求上一步粗划分完后不要关闭figure(3)，这里要在其上作图
    plot(xi51,yi51,'.y')
    xi51_size = size(xi51);
    X=[X,xi51];
    Y=[Y,yi51];
    toc
   
%     save('X','X');
%     save('Y','Y');
    save(['L:\400\3D_var_355\' ear(k).name(1:9) '_X'],'X');
    save(['L:\400\3D_var_355\' ear(k).name(1:9) '_Y'],'Y');
    
%     size_X = size(X)
    
    %end
    %  测试稀疏矩阵的位置
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105]
        plot(X(i),Y(i),'ob')
        text(X(i)-3,Y(i)-3,num2str(i));
    end
    title([num2str(k-2) '--' ear(k).name(1:9)])
    disp(['完成了第' num2str(k-2) '个人耳网格细划分！']);
    pause
end

msgbox('所有人耳样本的细划分完成！','note')




