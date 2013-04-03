%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by zhangfeng@ustb 2010-5-13                                       %
%                                                                        %
% function: ����һ��ָ���������˶���������ĳ���                            %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     set parameters and path                         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% k= 4 ; %( �� o �� )��ע���ˣ���������ȷ��������ļ����,���ҵô�3��ʼ����
threshold=0.6; % �ڴ˴����ñ�Ե������ֵ
ear=dir('L:\400\2D_ear\');
ear_num = size(ear,1);

for k=372:ear_num
    img=imread(['L:\400\2D_ear\' ear(k).name]);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%                  show pictures for our selection                    %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(1)
    imshow(img);
    figure(2)
    i1=rgb2gray(img);
    bw1=edge(i1,'canny',threshold); %��Ե��⣬������Ϊ�˸��õ��ҳ���Ե��
    hold off
    imshow(img); %% ��������ȡ����׵����ͣ����Բ�ɫͼ��Ϊ�ף�������img;���Ա�Եͼ��Ϊ�ף�������bw1
    title(ear(k).name);
    [h,w,rgb]=size(bw1);
    hold on
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%                           begin making grid                         %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% �������17��
    s=[];t=[];
    [x,y]=ginput(2);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ㣬�ɵõĵ���������
    y=round(y);
    s=[s;x];t=[t;y];
    plot(x(1),y(1),'.r')
    text(x(1)-5,y(1),int2str(1),'color','y');
    plot(x(2),y(2),'.r')
    text(x(2)-5,y(2),int2str(2),'color','y');
    FindBisector(x(1),y(1),x(2),y(2),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(3),'color','y');
    plot(x,y,'.r')
    FindBisector(s(1),t(1),s(3),t(3),w, h)
    FindBisector(s(2),t(2),s(3),t(3),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(4),'color','y');
    plot(x,y,'.r')
    FindBisector(s(1),t(1),s(4),t(4),w, h)
    FindBisector(s(4),t(4),s(3),t(3),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(5),'color','y');
    plot(x,y,'.r')
    FindBisector(s(2),t(2),s(5),t(5),w, h)
    FindBisector(s(3),t(3),s(5),t(5),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(6),'color','y');
    plot(x,y,'.r')
    FindBisector(s(1),t(1),s(6),t(6),w, h)
    FindBisector(s(4),t(4),s(6),t(6),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(7),'color','y');
    plot(x,y,'.r')
    FindBisector(s(3),t(3),s(7),t(7),w, h)
    FindBisector(s(4),t(4),s(7),t(7),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(8),'color','y');
    plot(x,y,'.r')
    FindBisector(s(3),t(3),s(8),t(8),w, h)
    FindBisector(s(5),t(5),s(8),t(8),w, h)
    
    [x,y]=ginput(1);
    x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
    y=round(y);
    s=[s;x];t=[t;y];
    text(x(1)-5,y(1),int2str(9),'color','y');
    plot(x,y,'.r')
    FindBisector(s(2),t(2),s(9),t(9),w, h)
    FindBisector(s(5),t(5),s(9),t(9),w, h)
    
    for i=10:17
        [x,y]=ginput(1);
        x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ�
        y=round(y);
        s=[s;x];t=[t;y];
        text(x(1)+3,y(1),int2str(i),'color','y');
        plot(x,y,'.r')
    end
    
    
    
    figure(3)
    hold off
    imshow(img);
    hold on
    plot(s,t,'og');
    plot(s,t,'.r');
    
    plot([s(1),s(2)],[t(1),t(2)],'-c','linewidth',1)
    sc=(s(1)+s(2))/2;
    tc=(t(1)+t(2))/2;
    plot(sc,tc,'og');
    plot(sc,tc,'.r');
    
    %for i=3:17
    %    plot([sc,s(i)],[tc,t(i)],'-c','linewidth',1)
    %end
    
    for i=1:17
        text(s(i)+3,t(i),int2str(i),'color','y');
    end
    
    plot([s(1),s(10)],[t(1),t(10)],'-c')
    plot([s(10),s(6)],[t(10),t(6)],'-c')
    plot([s(6),s(11)],[t(6),t(11)],'-c')
    plot([s(11),s(4)],[t(11),t(4)],'-c')
    plot([s(4),s(12)],[t(4),t(12)],'-c')
    plot([s(12),s(7)],[t(12),t(7)],'-c')
    plot([s(7),s(13)],[t(7),t(13)],'-c')
    plot([s(13),s(3)],[t(13),t(3)],'-c')
    plot([s(3),s(14)],[t(3),t(14)],'-c')
    plot([s(14),s(8)],[t(14),t(8)],'-c')
    plot([s(8),s(15)],[t(8),t(15)],'-c')
    plot([s(15),s(5)],[t(15),t(5)],'-c')
    plot([s(5),s(16)],[t(5),t(16)],'-c')
    plot([s(16),s(9)],[t(16),t(9)],'-c')
    plot([s(9),s(17)],[t(9),t(17)],'-c')
    plot([s(17),s(2)],[t(17),t(2)],'-c')
    title(ear(k).name);
    
    toc
    save(['L:\400\3D_var\' ear(k).name(1:9) '_s'],'s')
    save(['L:\400\3D_var\' ear(k).name(1:9) '_t'],'t')
%     save('s','s')
%     save('t','t')
    % save(['L:\Program Files\final_work\' num2str(k) '\s'])
    % save(['�»��ֺ��ѵ������(����ת)\' num2str(k) '\t'])
    % ttemp = t
    % size(t) %���ﵹ�ǻ���
    %------------------------------------------------------------------------%
    %% ��ʼѡ���ڶ����
    
    %load earhole
    % load(['�»��ֺ��ѵ������(����ת)\' num2str(k) '\earhole']) %
    
%     load('earhole')
    earh = load(['L:\400\3D_var\' ear(k).name(1:9) '_earhole']); % type: struct
    earhole = earh.earhole;
     
    plot(earhole(1),earhole(2),'.r') %��ʾ������λ��
    
    % t = ttemp
    % size(t) %���ﵹ�ǻ���
    
    inner_ear_x = [sc];
    inner_ear_y = [tc];
    plot(inner_ear_x(1),inner_ear_y(1),'.r')
    text(inner_ear_x(1)-5,inner_ear_y(1),int2str(1),'color','g');
    
    for i = 2:5
        [x,y]=ginput(1);
        x=round(x); %���������ڷŴ�ֱ��ʵĴ�ͼ�½��вɵ㣬�ɵõĵ���������
        y=round(y);
        inner_ear_x=[inner_ear_x;x];
        inner_ear_y=[inner_ear_y;y];
        plot(inner_ear_x(i),inner_ear_y(i),'.r')
        text(inner_ear_x(i)-5,inner_ear_y(i),int2str(i),'color','g');
    end
    
    %save inner_ear_x
    %save inner_ear_y
    % save(['�»��ֺ��ѵ������(����ת)\' num2str(k) '\inner_ear_x'])
    % save(['�»��ֺ��ѵ������(����ת)\' num2str(k) '\inner_ear_y'])
%     save('inner_ear_x','inner_ear_x');
%     save('inner_ear_y','inner_ear_y');
    
    save(['L:\400\3D_var\' ear(k).name(1:9) '_inner_ear_x'],'inner_ear_x');
    save(['L:\400\3D_var\' ear(k).name(1:9) '_inner_ear_y'],'inner_ear_y');

    % ttest=t
    % size(t) %t��Ȼû��
    %% ��ʼ��������
    %�ڶ�
    plot([earhole(1),inner_ear_x(1)],[earhole(2),inner_ear_y(1)],'-c')
    plot([earhole(1),inner_ear_x(2)],[earhole(2),inner_ear_y(2)],'-c')
    plot([earhole(1),inner_ear_x(3)],[earhole(2),inner_ear_y(3)],'-c')
    plot([earhole(1),inner_ear_x(4)],[earhole(2),inner_ear_y(4)],'-c')
    plot([earhole(1),inner_ear_x(5)],[earhole(2),inner_ear_y(5)],'-c')
    
    plot([inner_ear_x(1),inner_ear_x(2)],[inner_ear_y(1),inner_ear_y(2)],'-c')
    plot([inner_ear_x(2),inner_ear_x(3)],[inner_ear_y(2),inner_ear_y(3)],'-c')
    plot([inner_ear_x(3),inner_ear_x(4)],[inner_ear_y(3),inner_ear_y(4)],'-c')
    plot([inner_ear_x(4),inner_ear_x(5)],[inner_ear_y(4),inner_ear_y(5)],'-c')
    plot([inner_ear_x(5),inner_ear_x(1)],[inner_ear_y(5),inner_ear_y(1)],'-c')
    
    % plot(s(1),t(1),'*')
    % stest=s
    % ttest=t
    % size(t) %t��Ȼû��
    %���
    plot([inner_ear_x(2),s(1)],[inner_ear_y(2),t(1)],'-c')
    plot([inner_ear_x(2),s(10)],[inner_ear_y(2),t(10)],'-c')
    plot([inner_ear_x(2),s(6)],[inner_ear_y(2),t(6)],'-c')
    plot([inner_ear_x(2),s(11)],[inner_ear_y(2),t(11)],'-c')
    
    plot([inner_ear_x(3),s(11)],[inner_ear_y(3),t(11)],'-c')
    plot([inner_ear_x(3),s(4)],[inner_ear_y(3),t(4)],'-c')
    plot([inner_ear_x(3),s(12)],[inner_ear_y(3),t(12)],'-c')
    plot([inner_ear_x(3),s(7)],[inner_ear_y(3),t(7)],'-c')
    plot([inner_ear_x(3),s(13)],[inner_ear_y(3),t(13)],'-c')
    
    plot([inner_ear_x(4),s(13)],[inner_ear_y(4),t(13)],'-c')
    plot([inner_ear_x(4),s(3)],[inner_ear_y(4),t(3)],'-c')
    plot([inner_ear_x(4),s(14)],[inner_ear_y(4),t(14)],'-c')
    plot([inner_ear_x(4),s(8)],[inner_ear_y(4),t(8)],'-c')
    
    plot([inner_ear_x(5),s(8)],[inner_ear_y(5),t(8)],'-c')
    plot([inner_ear_x(5),s(15)],[inner_ear_y(5),t(15)],'-c')
    plot([inner_ear_x(5),s(5)],[inner_ear_y(5),t(5)],'-c')
    plot([inner_ear_x(5),s(16)],[inner_ear_y(5),t(16)],'-c')
    plot([inner_ear_x(5),s(9)],[inner_ear_y(5),t(9)],'-c')
    plot([inner_ear_x(5),s(17)],[inner_ear_y(5),t(17)],'-c')
    plot([inner_ear_x(5),s(2)],[inner_ear_y(5),t(2)],'-c')
    
    %% ��ת��ά����
    
    % ������ת�Ƕ�
    V = [s(2),t(2)] - [s(1),t(1)];
    theta =  acos(-V(2)/sqrt(V(1)^2+V(2)^2));
    % VA = [V,0];VB = [-1,0,0];
    % cross_value = cross(VA,VB)
    if s(2)<s(1)
        theta = -theta;
    end
    
    % ��ת��ά����
    % P3D=load(['C:\Documents and Settings\Administrator\����\3D�����������˶���\' ear(k).name(1:9) 'hole.txt'],'r');%�����ļ�·��
%     P3D=load('L:\Program Files\final_work\3D_data\05066d001ear_holed.txt','r');%�����ļ�·��
    P3D=load(['L:\400\3D_earhole\' ear(k).name(1:9) '_earholed.txt'],'r');%�����ļ�·��
    %%%%%%%%%%%%%%%%%%%%%%%%%% check the earhole %%%%%%%%%%%%%%%%%%%%%%%%%%
    indd = (earhole(1)-1)*h+w;
    disp('show the earhole:')
    P3D(indd,1)
    P3D(indd,2)
    P3D(indd,3)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [m,n]=size(P3D);
    figure(4)
    plot3(P3D(:,1),P3D(:,2),P3D(:,3),'g.')%��תǰ������
    hold on
    if s(2)~=s(1)
        for i=1:m
            %     if P3D(i,1)~=-999999
            P3D(i,:) = Rz(P3D(i,:),theta);
            %     end
        end
    end
    
    %��ʾ��ת�������
    
    % valid=[];
    % t=0;
    % for i=1:m
    %     if P3D(i,1)~=-999999
    %         t=t+1;
    %         valid(t)=i;
    %     end
    % end
    % P3D_v = P3D(valid,:);
    % plot3(P3D_v(:,1),P3D_v(:,2),P3D_v(:,3),'r.')
    plot3(P3D(:,1),P3D(:,2),P3D(:,3),'r.')
    
    %������ת�������
    fid2=fopen(['L:\400\3D_ear_rotated\' ear(k).name(1:9) '_ear_rotated.txt'],'w');%д���ļ�·��
    for i=1:m
        fprintf(fid2,'%g\t',P3D(i,1));
        fprintf(fid2,'%g\t',P3D(i,2));
        fprintf(fid2,'%g\n',P3D(i,3));
    end
    fclose(fid2);
    
    disp(['����˵�' num2str(k-2) '���˶�����ֻ��֣�']);
    
end

msgbox('note','�����˶������Ĵֻ�����ɣ�')


