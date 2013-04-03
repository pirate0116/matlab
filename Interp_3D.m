%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by zhangfeng @ustb 2010-5-17                                       %
%                                                                         %
% �˳���������ɶ�ȡ����ϸ�ֺ��X��Y��Ȼ���������ά�ռ��x,y,z��ֵ����       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ear = dir('L:\400\2D_ear_346');
ear_num = size(ear,1);

for k = 3:ear_num
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    earX = load(['L:\400\3D_var_346\' ear(k).name(1:9) '_X']);
    earY = load(['L:\400\3D_var_346\' ear(k).name(1:9) '_Y']);
    X = earX.X;
    Y = earY.Y;
    
    num=size(X,2);
    
    XT=[];
    YT=[];
    ZT=[];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%                                                   %%%%%%%%%%
    %figure(1)
    %imshow(img)
    %hold on
    %plot(X,Y,'.b')
    %for i=1:num
    %  [XT(i),YT(i),ZT(i)] = BoostingInterp(X(i), Y(i), h, P3D);
    %end
    
    %[XT,YT,ZT] = BoostingInterp(X(1), Y(1), h, P3D);
    %X1=X(1)
    %Y1=Y(1)
    %num_XT=size(XT)
    %num_YT=size(YT)
    %num_ZT=size(ZT)
    %figure(2)
    %hold on
    %plot(XT,YT,'or') %��Ȧ��ʾ��ֵ��������
    %plot(x,y,'oc') %��ɫ��Ȧ��ʾӦ�õĲ�ֵ������
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%     ear=dir('L:\Program Files\final_work\2D_data\');
%     num_ear=size(ear,1);
    
%     fid=imread('L:\Program Files\final_work\2D_data\05066d001ear.jpg');
    %fid=imread(['C:\Documents and Settings\Administrator\����\2D�˶�\' 05066d001ear.name]);
    %[w,h,rgb]=size(fid);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fid = imread(['L:\400\2D_ear_346\'  ear(k).name]);
    [h,w,rgb]=size(fid);
    figure(1)
    hold off
    title([num2str(k-2) '--' ear(k).name(1:9)])
    imshow(fid);
    title(ear(k).name)
    hold on
    plot(X(1),Y(1),'*r','linewidth',1);
    P3D = load(['L:\400\3D_ear_rotated\' ear(k).name(1:9) '_ear_rotated.txt']);
    [m,n]=size(P3D);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % valid=[];
    % t=0;
    % for i=1:m
    %     if P3D(i,1)~=-999999
    %         t=t+1;
    %         valid(t)=i;
    %     end
    % end
    % P3D_v=P3D(valid,:); %ѡȡ��Ч��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    P3D_v = P3D; %������ѡȡ��Ч��Ĳ��������������ԭ����ֱ�Ӹ�����Ч����
    [size_v,ss] = size(P3D_v);
    figure(2)
    hold off 
    set(gcf,'color','w')
    axis equal
    P3D_v(:,1);
    plot3(P3D_v(:,1),P3D_v(:,2),P3D_v(:,3),'.g')
    title([num2str(k-2) '--' ear(k).name(1:9)])
    grid on
    hold on
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%                       ���в�ֵ�ͱ�Ե����                           %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic
    for i=1:num
        [XT(i),YT(i),ZT(i)] = BoostingInterp(X(i), Y(i), h, P3D);
    end
    ZT = ModifyEdge( ZT ); %���б�Ե����
    toc
    
    % ��ʾ��ֵ���Ч��
    plot3(XT,YT,ZT,'.r')
    % plot3(XT(10062-31-31-31-33+499:10062-31-31-31-33+505),YT(10062-31-31-31-33+499:10062-31-31-31-33+505),ZT(10062-31-31-31-33+499:10062-31-31-31-33+505),'ob')
    % plot3(XT(9535-31-31-33+499:9535-31-31-33+505),YT(9535-31-31-33+499:9535-31-31-33+505),ZT(9535-31-31-33+499:9535-31-31-33+505),'ob')
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%                       ������״��һ���ĳ���                          %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %��ʵ�ʵ���������ˣ����ʵ����״���Ļ��Ͳ������������һ���ˡ�
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3)
    hold off
    plot3(XT,YT,ZT,'.b')
%     hold on
%     plot3(XT(9939),YT(9939),ZT(9939),'or') %for test
    title([num2str(k-2) '--' ear(k).name(1:9)])
    
    save(['L:\400\3D_var_346\' ear(k).name(1:9) '_XT'],'XT');
    save(['L:\400\3D_var_346\' ear(k).name(1:9) '_YT'],'YT');
    save(['L:\400\3D_var_346\' ear(k).name(1:9) '_ZT'],'ZT');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%                      delaunay���ǻ��ֲ���ʾ                        %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(4)
    tri=delaunay(XT,YT);
    trisurf(tri,XT,YT,ZT)
    shading interp
    colormap(jet(256))
    camlight left
    lighting phong
    set(gcf,'color','w')
    grid off
    title([num2str(k-2) '--' ear(k).name(1:9)])
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%% START %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % i=0;
    % Interval = 496+32;
    % j = 357;
    % plot3(XT(j),YT(j),ZT(j),'og');
    % plot3(XT(j-24+i*Interval),YT(j-24+i*Interval),ZT(j-24+i*Interval),'or')
    % plot3(XT(j-2*24+1+Interval+i*Interval),YT(j-2*24+1+Interval+i*Interval),ZT(j-2*24+1+Interval+i*Interval),'or')
    % indd = 466+1+32+496+32;
    % plot3(XT(indd),YT(indd),ZT(indd),'oc');
    % j = 384;
    % plot3(XT(j+i*Interval),YT(j+i*Interval),ZT(j+i*Interval),'og');
    % plot3(XT(j-2*25+Interval+i*Interval),YT(j-2*25+Interval+i*Interval),ZT(j-2*25+Interval+i*Interval),'or')
    % plot3(XT(j-2*25+1+Interval+i*Interval),YT(j-2*25+1+Interval+i*Interval),ZT(j-2*25+1+Interval+i*Interval),'or')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  end  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    N = size(XT,2);
    S=[]; %������״����
    for i=1:N
        S=[S,XT(i),YT(i),ZT(i)]; %�洢��״����
    end
    SS=S'; %����״����ת��Ϊ������
    size_of_SS = size(SS,1);  %for test
    disp(['SS longth is: ' num2str(size_of_SS)])
    save(['L:\400\3D_var_346\' ear(k).name(1:9) '_SS'],'SS');
        
    % plot3(SS(1),SS(2),SS(3),'ob','linewidth',3)
    % plot3(XT(1),YT(1),ZT(1),'*y','linewidth',2)
    disp(['��ȡ�˵�' num2str(k-2) '���˶�����״������']);
    
    pause
end

msgbox('�����˶���������״������ȡ����ɣ�','note')


