
%%%%%%code by zhangfeng ustb-ear-recognition-lab @USTB  2010-5-11
%%%%�ó��������ҳ��������������е���ά���������һ�����õ�%%%%%
%%%%�м���ѡ�����ʱ��Ϊ�˷�ֹ�㵽�Ķ�������Ч�㣬��ȡ�˺����𵴵Ĳ���%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
clc;
ear=dir('L:\400\2D_ear\');
num_ear=size(ear,1);
for k=3:num_ear
    %% ѡ����
    % fid=imread(['C:\Documents and Settings\Administrator\����\2D�˶���\' ear(k).name]);
    fid=imread(['L:\400\2D_ear\' ear(k).name(1:9) '_ear.jpg']);
    % figure((k-2)*2-1)
    figure(1)
    imshow(fid);
    % title(ear(k).name)
    title([ear(k).name(1:9) ' -- ' num2str(k-2)])
    [h,w,rgb]=size(fid);
    % ear(k).name
    hold on
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ���Ͻǵĵ� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x1, y1]=ginput(1); %ѡȡ�˶�����
    plot(x1,y1,'.r','linewidth',2);
    x1=round(x1);
    y1=round(y1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% ���½ǵĵ� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x2, y2]=ginput(1); %ѡȡ�˶�����
    plot(x2,y2,'.r','linewidth',2);
    x2=round(x2);
    y2=round(y2);
    %%%%%%%%%%%%%%%%%%%%%%%%% ��������ѡ������ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    line([x1 x1],[y1 y2],'Color','b');
    line([x1 x2],[y1 y1],'Color','b');
    line([x1 x2],[y2 y2],'Color','b');
    line([x2 x2],[y1 y2],'Color','b');
    %%%%%%%%%%%%%%%%%%%%%%%%% ���������еĶ�ά�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    
    
    %% ����ԭʼ��ά����,ȷ�����յĶ����㲢��һ������ԭ��
    % fid1=load(['C:\Documents and Settings\Administrator\����\3D�˶���\' ear(k).name(1:9) 'ear.txt'],'r');%�����ļ�·��
    fid1=load(['L:\400\3D_ear_smoothed\' ear(k).name(1:9) 'ear_smoothed.txt'],'r');
    [a,b]=size(fid1);
    X = fid1(:,1);
    Y = fid1(:,2);
    Z = fid1(:,3);
    
    [earholeZ,earholeInd] = min(Z(earhole_area));
    earhole_num = earhole_area(earholeInd); %�����˶��еĵ���
    earhole_x = ceil(earholeInd/(y2-y1+1))+(x1-1);
    earhole_y = mod(earholeInd,(y2-y1+1))+(y1-1);
    earhole = [earhole_x,earhole_y];
    save(['L:\400\3D_var\' ear(k).name(1:9) '_earhole'],'earhole')
    % save(['�»��ֺ��ѵ������\' num2str(k) '\earhole']) % �Ѷ����Ķ�ά���������
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%  ɾȥ��һ����  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % if X(num)==-999999 %��������Ѱ���Է�ֹ����Ķ�������Ч�㡣               %
    %     display('����')                                                     %
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
        Z(i) = Z(i)-holeZ; %��һ������ͳһZ�ˣ���ɴ��
        %     end
    end
    % X1_end=X(1)
    % Y1_end=Y(1)
    % Z1_end=Z(1)
    cha=X-fid1(:,1);
    sizecha=size(cha);
    %% ��ʾ�����ƶ�����˶���Ч��
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
    plot3(X(earhole_num),Y(earhole_num),Z(earhole_num),'*b','linewidth',4) %��ʾ������λ��
    grid on
    hold off
    set(gcf,'color','w')
    %% �����µ����꣬���ǰ�n*3����ʽ
    % fid2=fopen(['C:\Documents and Settings\Administrator\����\3D�����������˶���\' ear(k).name(1:9) 'hole.txt'],'w');%д���ļ�·��
    fid2=fopen(['L:\400\3D_earhole\' ear(k).name(1:9) '_earholed.txt'],'w');%д���ļ�·��
    for i=1:a
        fprintf(fid2,'%g\t',X(i));
        fprintf(fid2,'%g\t',Y(i));
        fprintf(fid2,'%g\n',Z(i));
    end
    fclose(fid2);
    display(['��' num2str(k-2) '��������ϣ�'])
end



