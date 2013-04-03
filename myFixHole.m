%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by Alex @ ustb 2013-3-18                                      %
%                                                                         %
% function: fill the hole in the original 3D face data                     %
%                                                                         %
% algorithm: x,y--average of the nearest neighbour                        %
%            z--cubic spline interpolation                                %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
tic
%face = dir('faceData3D');
%face_num = size(face,1);
%for index=1:face_num %�˴�Ϊѭ������������ͼ Ŀǰֻ����һ���˵�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              ��������                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%img = imread(['L:\400\2D_ear\' ear(index).name(1:9) '_ear.jpg']);
%[h,w,rgb] = size(img);
%P3D = load(['L:\400\3D_ear\' ear(index).name(1:9) '_ear.txt']);
%Z = P3D(:,3);
%X = P3D(:,1);
%Y = P3D(:,2);
% figure
% plot(1:size(Z,1),Z,'*b')
% hold on
faceBeforeFillHole = load (['faceData3D.mat']);
Z = faceBeforeFillHole(:,3);
X = faceBeforeFillHole(:,1);
Y = faceBeforeFillHole(:,2);
[h,w] = size(faceBeforeFillHole);
%%��ÿ��Ϊ��λ��ʼ����,����������ֵ��Z
for i=1:h      %���д���
    hole = []; %��ŵ㶴������
    holeZ = []; %��Ų�ֵ��ĵ�
    x_tmp = []; %�����Ч����
    y_tmp = []; %�����Ч��
    Yt = [];
    Xt = 1:w;
    for k=1:w
        Yt = [Yt,Z((k-1)*h+i)]; %Y�д����˸��е�����
    end
    for j=1:w
        if Yt(j) == -999999
            hole = [hole,j];
        else
            x_tmp = [x_tmp,Xt(j)];
            y_tmp = [y_tmp,Yt(j)];
        end
    end
    if isempty(x_tmp)
        %����ȫ��0��
        for k=1:w
            Z((k-1)*h+i) = 0; %Y�д����˸��е�����
        end
    else
        if ~isempty(hole)
            %                 x_tmp;
            %                 y_tmp;
            holeZ = spline(x_tmp,y_tmp,hole);
            for m=1:size(hole,2)
                Z((hole(m)-1)*h+i) = holeZ(m);
            end
        end
    end
end
% plot(1:size(Z,1),Z,'or')
% save('Z','Z');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            �����ƽ����Y                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:h      %���д���,���д���ʱ������ڷ�ֻ������Y
    Yline = [];
    Yhole = [];
    Ynohole = [];
    Ymax = 0;
    Ymaxind = 0;
    
    for k=1:w
        Yline = [Yline,Y((k-1)*h+i)];
    end
    for j=1:w
        if Yline(j) == -999999
            Yhole = [Yhole,j];
        else
            Ynohole = [Ynohole,j];
        end
    end
    
    if isempty(Ynohole)
        for k=1:w
            Y((k-1)*h+i) = 0;
        end
    else
        if ~isempty(Yhole)
            for iy=1:size(Yhole,2);
                ydis = [];
                for jy=1:size(Ynohole,2)
                    ydis = [ydis,abs(Yhole(iy)-Ynohole(jy))]; %���������������������㶴�������Ч��
                end
                [Ymax,Ymaxind] = min(ydis);
                k = Yhole(iy);
                Y((k-1)*h+i) = Yline(Ynohole(Ymaxind));
            end
        end
    end
end
% save('Y','Y')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            �����ƽ����X                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:w      %���д���,���д���ʱ������ڷ�ֻ������X
    Xline = [];
    Xhole = [];
    Xnohole = [];
    Xmax = 0;
    Xmaxind = 0;
    
    for k=1:h
        Xline = [Xline,X((i-1)*h+k)]; %��ȡ�˵�i��
    end
    for j=1:h
        if Xline(j) == -999999
            Xhole = [Xhole,j];
        else
            Xnohole = [Xnohole,j];
        end
    end
    
    if isempty(Xnohole)
        for k=1:h
            X((i-1)*h+k) = 0; %��ȡ�˵�i��
        end
    else
        if ~isempty(Xhole)
            for ix=1:size(Xhole,2);
                xdis = [];
                for jx=1:size(Xnohole,2)
                    xdis = [xdis,abs(Xhole(ix)-Xnohole(jx))]; %���������������������㶴�������Ч��
                end
                [Xmax,Xmaxind] = min(xdis);
                k = Xhole(ix);
                X((i-1)*h+k) = Xline(Xnohole(Xmaxind));
            end
        end
    end
end
% save('X','X')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           �����µ���ά����                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ear=dir('L:\Program Files\final_work\2D_data\');
% fid=fopen(['L:\Program Files\final_work\3D_data\' ear(3).name(1:9) 'ear_filled.txt'],'w');%д���ļ�·��

fid=fopen(['L:\400\3D_ear_holed\' ear(index).name(1:9) '_ear_holed.txt'],'w');%д���ļ�·��

for i=1:size(X,1)
    fprintf(fid,'%g\t',X(i));
    fprintf(fid,'%g\t',Y(i));
    fprintf(fid,'%g\n',Z(i));
end
fclose(fid);
display(['��' num2str(index) '�������ĵ㶴�޲���ϣ�'])
end
msgbox('����������ɲ�����','ע�⣺')
toc

























