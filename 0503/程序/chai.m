%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  code by zhangfeng@ustb 2010-6-10                                       %
%                                                                         %
% �˳���������ȡ2D��ϡ��㣬��ʵ���˶�����άϡ���ؽ�                          %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
format compact
ear = dir('L:\400\2D_ear_180');
ear_num = size(ear,1);

%% �ҵ�2D��������,�����2D�������ÿ����Ѿ����ֺõ�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% �������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 93:ear_num; %ѡȡ�����ı�ţ�3--ear_num��
    testX = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_X.mat']);
    testY = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_Y.mat']);
    testSS = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_SS.mat']);
    X = testX.X;
    Y = testY.Y;
    SS = testSS.SS; 
    SS = ChangeOrigPnt( SS );
    SS = EarMarginNorm( SS );
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ����3DEMM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ear_meanvec = load('L:\400\3D_var_180\meanvec');
    ear_mean_shape = load('L:\400\3D_var_180\mean_shape');
    ear_UU = load('L:\400\3D_var_180\UU');
    meanvec = ear_meanvec.meanvec;
    mean_shape = ear_mean_shape.mean_shape;
    UU = ear_UU.UU;
    UU = UU(:,1:11);
    
    %% 2D�������㷭ת
    
    Y=-Y;
    %plot(X,Y,'.b')
    %axis equal
    
    %% 2D���У��
    
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
    title('��Ŀ���άͼƬ����ȡ��������');
    axis equal
    
    %% ��ȡϡ��������
    
    sp_l = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        plot(P2D(i,1),P2D(i,2),'oy')
        sp_l = [sp_l;P2D(i,1);P2D(i,2)]; % ������Ķ�άͼƬ��ȡ�Ķ�άϡ����������������x,y,x,y��
        %pause
    end
    %     size(sp_l)
    disp(['--------------------------' num2str(1) '------------------------------'])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%% ��ѭ����������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% �������λ��ϵ���ͳ߶�ϵ��
    
    figure(2);
    hold off
    plot3(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),'.g')
    title('ѵ�����õ�ƽ��ģ��');
    hold on
    sp_3d = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        sp_3d = [sp_3d;mean_shape(i,1);mean_shape(i,2)]; % ����άƽ��ģ����ȡ�Ķ�άϡ����������������x,y,x,y��
        % plot3(mean_shape(i,1),mean_shape(i,2),mean_shape(i,3),'or');
        % pause
    end
    
    %sp_l(1)
    %[s1,tx1,ty1] = solve('sp_l(1)=s1*sp_3d(1)+tx1','sp_l(2)=s1*sp_3d(2)+tx1','sp_l(33*2-1)=s1*sp_3d(33*2-1)+tx1','s1,tx1,ty1')
    %[s2,tx2,ty2] = solve('sp_l(33*2)=s2*sp_3d(33*2)+ty2','sp_l(8481*2-1)=s2*sp_3d(8481*2-1)+tx2','sp_l(8481*2)=s2*sp_3d(8481*2)+tx2','s2,tx2,ty2')
    %�������̲��ý⣬ֻ����ԭ�������λ�Ʒ�����Ȼ�����ѭ������
    
    tx = sp_l(1) - sp_3d(1);
    ty = sp_l(2) - sp_3d(2);
    o_s = 0;
    
    errx_save = [];
    erry_save = [];
    errs_save = [];
    
    for i=1:10 %����10����ֹѭ��
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
        display(['��' int2str(i) '�ε�����'])
        display(['���Ϊ:' num2str(errx) ';' num2str(erry) ';' num2str(errs) '!'])
        
        if errx<=0.003 && erry<=0.003 && errs<=0.003
            display('�����������0.3%���ڣ�����ѭ����')
            break;
        end
        t=1:i+1;
        tt=2:i+1;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% ����ϵ������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3)
    hold off
    plot(t,errx_save,'-+r',t,erry_save,'-*b','linewidth',2)
    hold on
    plot(tt,errs_save(tt),'-vg','linewidth',2)
    legend('λ������tx���','λ������ty���','�߶�����s���')
    title('λ�ƺͳ߶�������������')
    
    %%%%%%%%%%%%%%%%%%%%% ��ʼ����任��Ķ�άͼƬ���� %%%%%%%%%%%%%%%%%%%%%%%%%%
    T = [];
    for i=1:23
        T = [T;tx;ty];
    end
    sp_l_S = (sp_l - T)/s; %�߶Ⱥ�λ�Ƶ������ϡ���ά����
    
    %%%%%%%%%%%%%%%%%%%%% ������֤�ڶ�ά�����ϵ�׼ȷ�� %%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(4)
    hold off
    sp_l_S_pic = reshape(sp_l_S,2,23);
    sp_l_t = reshape(sp_l,2,23);
    subplot(1,2,1)
    plot(sp_l_t(1,:),sp_l_t(2,:),'*r');
    title('�߶Ⱥ�λ�Ƶ���֮ǰ�Ĺؼ���')
    subplot(1,2,2)
    plot(sp_l_S_pic(1,:),sp_l_S_pic(2,:),'*r');
    title('�߶Ⱥ�λ�Ƶ���֮��Ĺؼ���')
    axis equal;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% ��ȡϡ����������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sp_UU = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        sp_UU = [sp_UU;UU(i*3-2,:);UU(i*3-1,:)];
    end
    %     size(sp_UU)
    %     size(sp_l_S)
    
    %%%%%%%%%%%%%%%%%%%%%%%%% ��С���˼���ϵ������ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     alpha = inv((sp_UU)'*sp_UU)*(sp_UU)'*(sp_l_S - sp_3d); % inv() is slow and inaccurate
    alpha = (((sp_UU)'*sp_UU)\(sp_UU)')*(sp_l_S - sp_3d);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ����������Ԫ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sp_3d_meanxyz = [];
    sp_UU_xyz = [];
    for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
        sp_UU_xyz = [sp_UU_xyz;UU(i*3-2,:);UU(i*3-1,:);UU(i*3,:)]; %ϡ�����Ԫ
        sp_3d_meanxyz = [sp_3d_meanxyz;mean_shape(i,1);mean_shape(i,2);mean_shape(i,3)];%ϡ���ƽ������
    end
    
    n = size(sp_UU_xyz,2);
    sp_shape = alpha(1)*sp_UU_xyz(:,1);
    for i = 2:n
        sp_shape = sp_shape + alpha(i)*sp_UU_xyz(:,i);
    end
    sp_shape = sp_shape + sp_3d_meanxyz;  %��Ԫ����ƽ������
    %     size(sp_shape)
    
    %%%%%%%%%%%%%%%%%%%% ����ʾϵ����ά����κ�Ŀռ�λ�� %%%%%%%%%%%%%%%%%%%%%%%
    figure(5)
    hold off
    sp_shape = reshape(sp_shape,3,23);% sp_shape��ϡ����Ԫ������ϡ����ı������
    plot3(sp_shape(1,:),sp_shape(2,:),sp_shape(3,:),'*r')
    axis equal
    hold on
    for i = 1:23
        plot3(sp_shape(1,i),sp_shape(2,i),sp_shape(3,i),'ob')
        %pause
    end
    title('ϡ�����κ�����')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% ��ѭ���������յ� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%% ���ݼ����ϵ������������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%
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
    title('����ģ�ͱ��κ�����')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% �����ؽ���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    sum_dis = 0;
    dis_err = [];
    for i=1:(m/3)
        x_dis = (shape(i*3-2)-SS(i*3-2))^2;
        y_dis = (shape(i*3-1)-SS(i*3-1))^2;
        z_dis = (shape(i*3)-SS(i*3))^2;
        dis_err = [dis_err, sqrt(x_dis + y_dis + z_dis)];
        sum_dis = sum_dis + sqrt(x_dis + y_dis + z_dis);
    end
    
    dis = sum_dis/(m/3)  %27�ŵ�ƽ��ŷ�Ͼ�����2.92794062003176mm,��3�ŵ���5.77184984250415mm
    figure(7)
    j = 1:(m/3);
    hold off
    bar(dis_err)
    title('�ؽ����ֱ��ͼ')
    
    
    shape3 = shape3';
    %%%%%%%%%%%%%%%%%%%%%%%% ��ʾ�α�ģ�͵Ĺ⻬ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    
%         %%%%%%%%%%%%%%%%%%%%%%%%%%% �����ǻ�������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%         title('�ؽ����˶������ǻ�����ͼ')
%     
%         %%%%%%%%%%%%%%%%%%%%%%%%%%% �����ǻ�������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         figure(10)
%         hold off
%         tri=delaunay(shape3(:,1),shape3(:,2));
%         trisurf(tri,shape3(:,1),shape3(:,2),shape3(:,3))
%         shading interp
%         colormap(jet(256))
%         camlight left
%         lighting phong
%         set(gcf,'color','w')
%         title('�ؽ����˶�������ͼ')
%     
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ʾԭʼ���˶� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%         title('ԭʼ�˶�������ͼ')
    
    
    
    
    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%% �������ϵ������ %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for ii = 1:9 %�������ϵ������
        disp(['--------------------------' num2str(ii+1) '------------------------------'])
        display(['����ϵ��������' num2str(ii+1) '�δ�ѭ����']);
        %����������ȡ�ϳ�ģ�͵�ϡ��ͶӰ�󡪡���������%
        sp_3d_pingjun = [];
        sp_3d = [];
        for i = [1 33 561 1089 1617 2145 2673 3201 3729 4257 4785 5313 5841 6369 6897 7425 7953 8481 10993 11521 12049 12577 13105];
            sp_3d = [sp_3d;shape3(i,1);shape3(i,2)];
            sp_3d_pingjun = [sp_3d_pingjun;mean_shape(i,1);mean_shape(i,2)];
        end
        %������������ƽ�ƺ���ת���󡪡�����%
        tx = sp_l(1) - sp_3d(1);
        ty = sp_l(2) - sp_3d(2);
        o_s = 0;
        
        errx_save = []; 
        erry_save = []; 
        errs_save = [];
        
        for i=1:10 %����10����ֹѭ��
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
            display(['��' int2str(i) '�ε�����'])
            display(['���Ϊ:' num2str(errx) ';' num2str(erry) ';' num2str(errs) '!'])
            
            if errx<=0.003 && erry<=0.003 && errs<=0.003
                display('�����������0.3%���ڣ�����ѭ����')
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
        legend('λ������tx���','λ������ty���','�߶�����s���')
        title('λ�ƺͳ߶�������������')
        
        %������������任��Ķ�άͼƬ���ꡪ������%
        T = [];
        for i=1:23
            T = [T;tx;ty];
        end
        sp_l_S = (sp_l - T)/s; %�߶Ⱥ�λ�Ƶ������ϡ���ά����
        
        %�������� ��С���˼���ϵ������ ��������%
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
        display(['ϵ�������������Ϊ��' num2str(err_alpha) '!']);
        figure(8)
        hold off
        sizett = size(alpha_pre,1);
        t=1:sizett;
        plot(t,alpha_pre,'-*r',t,alpha,'-vb')
        %     if err_alpha <= 0.01
        %         display('ϵ������������������ֹͣ��')
        %         break;
        %     end
        
        %�������� ���ݼ����ϵ������������ͼ ��������%
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
        %�������� �����ؽ���� ��������%
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
        title('�ؽ����ֱ��ͼ')
        shape3 = shape3';
        
        if err_alpha <= 0.02
            display('ϵ��������������2%���ڣ�����ֹͣ��')
            break;
        end
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% �����ؽ���� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    save(['L:\400\90I\' num2str(k) '_shape'],'shape')
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%% �����ǻ�������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%     title('�ؽ����˶������ǻ�����ͼ')
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%% �����ǻ�������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     figure(10)
%     hold off
%     tri=delaunay(shape3(:,1),shape3(:,2));
%     trisurf(tri,shape3(:,1),shape3(:,2),shape3(:,3))
%     shading interp
%     colormap(jet(256))
%     camlight left
%     lighting phong
%     set(gcf,'color','w')
%     title('�ؽ����˶�������ͼ')
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ʾԭʼ���˶� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%     title('ԭʼ�˶�������ͼ')
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     pause
end
