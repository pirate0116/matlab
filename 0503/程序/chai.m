%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  code by zhangfeng@ustb 2010-6-10                                       %
%                                                                         %
% 此程序用于提取2D的稀疏点，并实现人耳的三维稀疏重建                          %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
format compact
ear = dir('L:\400\2D_ear_180');
ear_num = size(ear,1);

%% 找到2D的特征点,这里的2D特征点用库中已经划分好的

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 测试样本 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 93:ear_num; %选取样本的编号（3--ear_num）
    testX = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_X.mat']);
    testY = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_Y.mat']);
    testSS = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_SS.mat']);
    X = testX.X;
    Y = testY.Y;
    SS = testSS.SS; 
    SS = ChangeOrigPnt( SS );
    SS = EarMarginNorm( SS );
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 下载3DEMM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ear_meanvec = load('L:\400\3D_var_180\meanvec');
    ear_mean_shape = load('L:\400\3D_var_180\mean_shape');
    ear_UU = load('L:\400\3D_var_180\UU');
    meanvec = ear_meanvec.meanvec;
    mean_shape = ear_mean_shape.mean_shape;
    UU = ear_UU.UU;
    UU = UU(:,1:11);
    
    %% 2D的特征点翻转
    
    Y=-Y;
    %plot(X,Y,'.b')
    %axis equal
    
    %% 2D点的校正
    
    X = X';
    Y = Y';
    P2D = [X,Y];
    V = [X(8481),Y(8481)] - [X(33),Y(33)];
    theta = acos(V(2)/sqrt(V(1)^2+V(2)^2));
    
    P2D = R2d(P2D,theta);
    figure(1)
    hold off
    plot(P2D(:,1),P2D(:,2),'.b')
    hold on
    plot(P2D(8481,1),P2D(8481,2),'or')
    plot(P2D(33,1),P2D(33,2),'or')
    title('从目标二维图片中提取的特征点');
    axis equal
    
    %% 抽取稀疏特征点
    
    sp_l = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        plot(P2D(i,1),P2D(i,2),'oy')
        sp_l = [sp_l;P2D(i,1);P2D(i,2)]; % 从输入的二维图片提取的二维稀疏向量，列向量（x,y,x,y）
        %pause
    end
    %     size(sp_l)
    disp(['--------------------------' num2str(1) '------------------------------'])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%% 大循环迭代的起点 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% 迭代求解位移系数和尺度系数
    
    figure(2);
    hold off
    plot3(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),'.g')
    title('训练所得的平均模型');
    hold on
    sp_3d = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        sp_3d = [sp_3d;mean_shape(i,1);mean_shape(i,2)]; % 从三维平均模型提取的二维稀疏向量，列向量（x,y,x,y）
        % plot3(mean_shape(i,1),mean_shape(i,2),mean_shape(i,3),'or');
        % pause
    end
    
    %sp_l(1)
    %[s1,tx1,ty1] = solve('sp_l(1)=s1*sp_3d(1)+tx1','sp_l(2)=s1*sp_3d(2)+tx1','sp_l(33*2-1)=s1*sp_3d(33*2-1)+tx1','s1,tx1,ty1')
    %[s2,tx2,ty2] = solve('sp_l(33*2)=s2*sp_3d(33*2)+ty2','sp_l(8481*2-1)=s2*sp_3d(8481*2-1)+tx2','sp_l(8481*2)=s2*sp_3d(8481*2)+tx2','s2,tx2,ty2')
    %上述方程不好解，只好用原点先求出位移分量，然后进入循环迭代
    
    tx = sp_l(1) - sp_3d(1);
    ty = sp_l(2) - sp_3d(2);
    o_s = 0;
    
    errx_save = [];
    erry_save = [];
    errs_save = [];
    
    for i=1:10 %迭代10次终止循环
        sumup = 0;
        sumdown = 0;
        
        for j = 1:23
            tempd = (sp_3d(j*2-1))^2+(sp_3d(j*2))^2;
            sumdown = sumdown + tempd;
            
            tempu = (sp_l(j*2-1)-tx)*sp_3d(j*2-1)+(sp_l(j*2)-ty)*sp_3d(j*2);
            sumup = sumup + tempu;
        end
        s = sumup/sumdown;
        errs = abs((s-o_s)/o_s);
        errs_save = [errs_save,errs];
        o_tx = tx;
        o_ty = ty;
        
        sumx = 0;
        sumy = 0;
        for m = 1:23
            tempx = sp_l(m*2-1)-s*sp_3d(m*2-1); % x
            sumx = sumx + tempx;
            
            tempy = sp_l(m*2)-s*sp_3d(m*2); % y
            sumy = sumy + tempy;
        end
        tx = sumx/23;
        ty = sumy/23;
        o_s = s;
        
        errx = abs((tx-o_tx)/o_tx);
        erry = abs((ty-o_ty)/o_ty);
        errx_save = [errx_save,errx];
        erry_save = [erry_save,erry];
        %err = (errs+errx+erry)/3;
        display(['第' int2str(i) '次迭代！'])
        display(['误差为:' num2str(errx) ';' num2str(erry) ';' num2str(errs) '!'])
        
        if errx<=0.003 && erry<=0.003 && errs<=0.003
            display('误差已收敛到0.3%以内，跳出循环！')
            break;
        end
        t=1:i+1;
        tt=2:i+1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% 绘制系数收敛图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3)
    hold off
    plot(t,errx_save,'-+r',t,erry_save,'-*b','linewidth',2)
    hold on
    plot(tt,errs_save(tt),'-vg','linewidth',2)
    legend('位移因子tx误差','位移因子ty误差','尺度因子s误差')
    title('位移和尺度因子收敛曲线')
    
    %%%%%%%%%%%%%%%%%%%%% 开始计算变换后的二维图片坐标 %%%%%%%%%%%%%%%%%%%%%%%%%%
    T = [];
    for i=1:23
        T = [T;tx;ty];
    end
    sp_l_S = (sp_l - T)/s; %尺度和位移调整后的稀疏二维点列
    
    %%%%%%%%%%%%%%%%%%%%% 用来验证在二维方向上的准确性 %%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(4)
    hold off
    sp_l_S_pic = reshape(sp_l_S,2,23);
    sp_l_t = reshape(sp_l,2,23);
    subplot(1,2,1)
    plot(sp_l_t(1,:),sp_l_t(2,:),'*r');
    title('尺度和位移调整之前的关键点')
    subplot(1,2,2)
    plot(sp_l_S_pic(1,:),sp_l_S_pic(2,:),'*r');
    title('尺度和位移调整之后的关键点')
    axis equal;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% 抽取稀疏的特征向量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sp_UU = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        sp_UU = [sp_UU;UU(i*3-2,:);UU(i*3-1,:)];
    end
    %     size(sp_UU)
    %     size(sp_l_S)
    
    %%%%%%%%%%%%%%%%%%%%%%%%% 最小二乘计算系数向量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     alpha = inv((sp_UU)'*sp_UU)*(sp_UU)'*(sp_l_S - sp_3d); % inv() is slow and inaccurate
    alpha = (((sp_UU)'*sp_UU)\(sp_UU)')*(sp_l_S - sp_3d);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 用来叠加主元 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sp_3d_meanxyz = [];
    sp_UU_xyz = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        sp_UU_xyz = [sp_UU_xyz;UU(i*3-2,:);UU(i*3-1,:);UU(i*3,:)]; %稀疏的主元
        sp_3d_meanxyz = [sp_3d_meanxyz;mean_shape(i,1);mean_shape(i,2);mean_shape(i,3)];%稀疏的平均向量
    end
    
    n = size(sp_UU_xyz,2);
    sp_shape = alpha(1)*sp_UU_xyz(:,1);
    for i = 2:n
        sp_shape = sp_shape + alpha(i)*sp_UU_xyz(:,i);
    end
    sp_shape = sp_shape + sp_3d_meanxyz;  %主元叠加平均向量
    %     size(sp_shape)
    
    %%%%%%%%%%%%%%%%%%%% 来显示系数三维点变形后的空间位置 %%%%%%%%%%%%%%%%%%%%%%%
    figure(5)
    hold off
    sp_shape = reshape(sp_shape,3,23);% sp_shape是稀疏主元叠加上稀疏点后的变形情况
    plot3(sp_shape(1,:),sp_shape(2,:),sp_shape(3,:),'*r')
    axis equal
    hold on
    for i = 1:23
        plot3(sp_shape(1,i),sp_shape(2,i),sp_shape(3,i),'ob')
        %pause
    end
    title('稀疏点变形后的情况')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% 大循环迭代的终点 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%% 依据计算的系数向量作稠密图 %%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(6)
    hold off
    shape = alpha(1)*UU(:,1);
    n = size(UU,2);
    for i = 2:n
        shape = shape + alpha(i)*UU(:,i);
    end
    shape = shape + meanvec;
    shape = EarMarginNorm( shape );
    m = size(UU,1);
    shape3 = reshape(shape,3,m/3);
    plot3(shape3(1,:),shape3(2,:),shape3(3,:),'.r')
    hold on
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        plot3(shape3(1,i),shape3(2,i),shape3(3,i),'ob')
    end
    title('稠密模型变形后的情况')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% 计算重建误差 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    sum_dis = 0;
    dis_err = [];
    for i=1:(m/3)
        x_dis = (shape(i*3-2)-SS(i*3-2))^2;
        y_dis = (shape(i*3-1)-SS(i*3-1))^2;
        z_dis = (shape(i*3)-SS(i*3))^2;
        dis_err = [dis_err, sqrt(x_dis + y_dis + z_dis)];
        sum_dis = sum_dis + sqrt(x_dis + y_dis + z_dis);
    end
    
    dis = sum_dis/(m/3)  %27号的平均欧氏距离是2.92794062003176mm,对3号的是5.77184984250415mm
    figure(7)
    j = 1:(m/3);
    hold off
    bar(dis_err)
    title('重建误差直方图')
    
    
    shape3 = shape3';
    %%%%%%%%%%%%%%%%%%%%%%%% 显示形变模型的光滑图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % figure(8)
    % shape3 = shape3';
    % size(shape3)
    % xnodes=min(shape3(:,1)):.5:max(shape3(:,1));
    % ynodes=min(shape3(:,2)):.5:max(shape3(:,2));
    % [zg,xg,yg] = gridfit(shape3(:,1),shape3(:,2),shape3(:,3),xnodes,ynodes);
    % surf(xg,yg,zg)
    % set(gcf,'color','w')
    % shading interp
    % colormap(jet(256))
    % camlight left %headlight
    % lighting phong
    % grid off
    
%         %%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的网格图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         figure(9)
%         hold off 
% %         shape3 = shape3';
%         tri=delaunay(shape3(:,1),shape3(:,2));
%         trimesh(tri,shape3(:,1),shape3(:,2),shape3(:,3))
%         shading interp
%         colormap(jet(256))
%         camlight left
%         lighting phong
%         set(gcf,'color','w')
%         title('重建后人耳的三角化网格图')
%     
%         %%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的曲面图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         figure(10)
%         hold off
%         tri=delaunay(shape3(:,1),shape3(:,2));
%         trisurf(tri,shape3(:,1),shape3(:,2),shape3(:,3))
%         shading interp
%         colormap(jet(256))
%         camlight left
%         lighting phong
%         set(gcf,'color','w')
%         title('重建后人耳的曲面图')
%     
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%% 显示原始的人耳 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         nnn = size(SS,1);
% %         SS = ChangeOrigPnt( SS );
% %         SS = EarMarginNorm( SS );
%         SSS = reshape(SS,3,nnn/3);
%         SSS = SSS';
%         figure(11)
%         hold off
%         tri=delaunay(SSS(:,1),SSS(:,2));
%         trisurf(tri,SSS(:,1),SSS(:,2),SSS(:,3))
%         shading interp
%         colormap(jet(256))
%         camlight left
%         lighting phong
%         set(gcf,'color','w')
%         title('原始人耳的曲面图')
    
    
    
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%% 迭代求解系数向量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for ii = 1:9 %迭代求解系数向量
        disp(['--------------------------' num2str(ii+1) '------------------------------'])
        display(['进入系数向量第' num2str(ii+1) '次大循环：']);
        %————抽取合成模型的稀疏投影阵——————%
        sp_3d_pingjun = [];
        sp_3d = [];
        for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
            sp_3d = [sp_3d;shape3(i,1);shape3(i,2)];
            sp_3d_pingjun = [sp_3d_pingjun;mean_shape(i,1);mean_shape(i,2)];
        end
        %————计算平移和旋转矩阵————%
        tx = sp_l(1) - sp_3d(1);
        ty = sp_l(2) - sp_3d(2);
        o_s = 0;
        
        errx_save = []; 
        erry_save = []; 
        errs_save = [];
        
        for i=1:10 %迭代10次终止循环
            sumup = 0;
            sumdown = 0;
            
            for j = 1:23
                tempd = (sp_3d(j*2-1))^2+(sp_3d(j*2))^2;
                sumdown = sumdown + tempd;
                
                tempu = (sp_l(j*2-1)-tx)*sp_3d(j*2-1)+(sp_l(j*2)-ty)*sp_3d(j*2);
                sumup = sumup + tempu;
            end
            s = sumup/sumdown;
            errs = abs((s-o_s)/o_s);
            errs_save = [errs_save,errs];
            o_tx = tx;
            o_ty = ty;
            
            sumx = 0;
            sumy = 0;
            for m = 1:23
                tempx = sp_l(m*2-1)-s*sp_3d(m*2-1);
                sumx = sumx + tempx;
                
                tempy = sp_l(m*2)-s*sp_3d(m*2);
                sumy = sumy + tempy;
            end
            tx = sumx/23;
            ty = sumy/23;
            o_s = s;
            
            errx = abs((tx-o_tx)/o_tx);
            erry = abs((ty-o_ty)/o_ty);
            errx_save = [errx_save,errx];
            erry_save = [erry_save,erry];
            %err = (errs+errx+erry)/3;
            display(['第' int2str(i) '次迭代！'])
            display(['误差为:' num2str(errx) ';' num2str(erry) ';' num2str(errs) '!'])
            
            if errx<=0.003 && erry<=0.003 && errs<=0.003
                display('误差已收敛到0.3%以内，跳出循环！')
                break;
            end
            t=1:i+1;
            tt=2:i+1;
        end
        
        figure(7)
        hold off
        plot(t,errx_save,'-+r',t,erry_save,'-*b','linewidth',2)
        hold on
        plot(tt,errs_save(tt),'-vg','linewidth',2)
        legend('位移因子tx误差','位移因子ty误差','尺度因子s误差')
        title('位移和尺度因子收敛曲线')
        
        %————计算变换后的二维图片坐标————%
        T = [];
        for i=1:23
            T = [T;tx;ty];
        end
        sp_l_S = (sp_l - T)/s; %尺度和位移调整后的稀疏二维点列
        
        %———— 最小二乘计算系数向量 ————%
        alpha_pre = alpha;
        %     size(sp_UU)
        %     size(sp_l_S)
        %     size(sp_3d_pingjun)
        %     alpha = inv((sp_UU)'*sp_UU)*(sp_UU)'*(sp_l_S - sp_3d_pingjun);
        alpha = (((sp_UU)'*sp_UU)\(sp_UU)')*(sp_l_S - sp_3d_pingjun);
        nn = size(alpha,1);
        err_alpha = 0;
        for i = 1:nn
            err_alpha = err_alpha + abs((alpha(i) - alpha_pre(i))/alpha_pre(i));
        end
        err_alpha = err_alpha/nn;
        display(['系数向量迭代误差为：' num2str(err_alpha) '!']);
        figure(8)
        hold off
        sizett = size(alpha_pre,1);
        t=1:sizett;
        plot(t,alpha_pre,'-*r',t,alpha,'-vb')
        %     if err_alpha <= 0.01
        %         display('系数向量已收敛，迭代停止！')
        %         break;
        %     end
        
        %———— 依据计算的系数向量作稠密图 ————%
        figure((ii-1)*4+12)
        shape = alpha(1)*UU(:,1);
        n = size(UU,2);
        for i = 2:n
            shape = shape + alpha(i)*UU(:,i);
        end
        shape = shape + meanvec;
        m = size(UU,1)
        shape3 = reshape(shape,3,m/3);
        plot3(shape3(1,:),shape3(2,:),shape3(3,:),'.r')
        hold on
        for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
            plot3(shape3(1,i),shape3(2,i),shape3(3,i),'ob')
        end
        %———— 计算重建误差 ————%
        sum_dis = 0;
        dis_err = [];
        for i=1:(m/3)
            x_dis = (shape(i*3-2)-SS(i*3-2))^2;
            y_dis = (shape(i*3-1)-SS(i*3-1))^2;
            z_dis = (shape(i*3)-SS(i*3))^2;
            dis_err = [dis_err, sqrt(x_dis + y_dis + z_dis)];
            sum_dis = sum_dis + sqrt(x_dis + y_dis + z_dis);
        end
        
        
        dis = sum_dis/(m/3)
        figure((ii-1)*4+13)
        j = 1:(m/3);
        bar(dis_err)
        title('重建误差直方图')
        shape3 = shape3';
        
        if err_alpha <= 0.02
            display('系数向量已收敛到2%以内，迭代停止！')
            break;
        end
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 保存重建结果 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    save(['L:\400\90I\' num2str(k) '_shape'],'shape')
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的网格图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(9)
%     hold off
% %     shape3 = shape3';
%     tri=delaunay(shape3(:,1),shape3(:,2));
%     trimesh(tri,shape3(:,1),shape3(:,2),shape3(:,3))
%     shading interp
%     colormap(jet(256))
%     camlight left
%     lighting phong
%     set(gcf,'color','w')
%     title('重建后人耳的三角化网格图')
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的曲面图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(10)
%     hold off
%     tri=delaunay(shape3(:,1),shape3(:,2));
%     trisurf(tri,shape3(:,1),shape3(:,2),shape3(:,3))
%     shading interp
%     colormap(jet(256))
%     camlight left
%     lighting phong
%     set(gcf,'color','w')
%     title('重建后人耳的曲面图')
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%% 显示原始的人耳 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     nnn = size(SS,1);
% %     SS = ChangeOrigPnt( SS );
% %     SS = EarMarginNorm( SS );
%     SSS = reshape(SS,3,nnn/3);
%     SSS = SSS';
%     figure(11)
%     hold off
%     tri=delaunay(SSS(:,1),SSS(:,2));
%     trisurf(tri,SSS(:,1),SSS(:,2),SSS(:,3))
%     shading interp
%     colormap(jet(256))
%     camlight left
%     lighting phong
%     set(gcf,'color','w')
%     title('原始人耳的曲面图')
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     pause
end
