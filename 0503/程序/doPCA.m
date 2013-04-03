%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by zhangfeng@ ustb 2010-5-19                                       %
%                                                                         %
% �������ݽ��н�ģ                                                         %
%                                                                         %
% ͨ�����б����򣬹���������ϵ��α�ģ�ͣ���״��                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
format compact;
ear = dir('L:\400\2D_ear_180\');
ear_num = size(ear,1);

%% ��������
A=[];
for k=3:92
   earSS = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_SS.mat']);
   SS = earSS.SS;
   SS = ChangeOrigPnt( SS ); %�ı�ԭ��
   SS = EarMarginNorm( SS ); %ͳһ�߶�
   A=[A,SS];
   disp(['�������' num2str(k-2) '����״������'])
end
size(A); %A��Ŀ�����
save('L:\400\3D_var_180\A','A');

% Aload = load('L:\400\3D_var_180\A');
% A = Aload.A; 

%% ��ƽ������ͼ

disp('��ƽ����');
meanvec = mean(A, 2); %ÿ��ȡƽ����Ҳ����ÿ����Ӧ���x,y,z�ֱ�ȡƽ��ֵ
mean_shape = reshape(meanvec, 3, size(meanvec,1)/3);
mean_shape = mean_shape'; %�õ����յ���״����n*3��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ������ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
set(gcf,'color','w')
plot3(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),'.r')
grid on
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%% �����ǻ���ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
tri=delaunay(mean_shape(:,1),mean_shape(:,2));
trisurf(tri,mean_shape(:,1),mean_shape(:,2),mean_shape(:,3))
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���⻬ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(3)
% xnodes=min(mean_shape(:,1)):.5:max(mean_shape(:,1));
% ynodes=min(mean_shape(:,2)):.5:max(mean_shape(:,2));
% [zg,xg,yg] = gridfit(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),xnodes,ynodes);
% surf(xg,yg,zg)
% set(gcf,'color','w')
% shading interp
% colormap(jet(256))
% camlight left %headlight
% lighting phong
% grid off

%% ������������PCA���塿
tic
format long % ���峤��ʾ
meanarray = repmat(meanvec, 1, size(A,2)); 
AA = A-meanarray; % �������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��Э������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
covA = AA'*AA;   %���SVD�ֽ�
sizeCOVA = size(covA)

%%%%%%%%%%%%%%%%%%%%%%%%%%% ������ֵ���������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Computing principle components��');
[V, D] = eig(covA);
sizeV = size(V)
sizeD = size(D)
U = AA*V*(D^(-1/2)); %SVD�ֽ�
D = D/size(A,2);  %��ԭ����ֵ
sizeU = size(U)
sizeD = size(D)

%%%%%%%%%%%%%%%%%%%%%%%%% ���ݷ������ѡ����Ԫ %%%%%%%%%%%%%%%%%%%%%%%%%%%
num_eig = NumPrincipleEig(D,0.999) %ѡ���������ĸ��� 
DD = fliplr(D);
DD = flipud(DD);
DD = diag(DD);
save('DD','DD')

%%%%%%%%%%%%%%%%%%%%%%%% ������Ԫ����ѡ���������� %%%%%%%%%%%%%%%%%%%%%%%%%%
UU = U(:,(size(U, 2) - num_eig + 1) : size(U, 2)); %����
UU = fliplr(UU); % �õ��Ӵ�С������,������ȡ�������������е���UU��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc

%% ѡ���α�ģ��ϵ������

D = fliplr(D);
D = flipud(D);
D = diag(D);% ��ȡ����ֵ������ģ������ɴ�С���е�����ֵ
coefficient = -3 * sqrt(D(1:num_eig));
size_coeff = size(coefficient)

%% �����α�ģ��

sizemeanshape = size(mean_shape)
%%%%%%%%%%%%%%%%%%%%%%% ������Ԫ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model = coefficient(1)*UU(:,1); % �����α�ģ�;���
% for i= 2:num_eig
%     model = model + coefficient(i)*UU(:,i);
% end
% model = reshape(model, 3, size(model,1)/3);
% model = model';
% model = model + mean_shape; %ƽ��ģ�͵�����Ԫ
%%%%%%%%%%%%%%%%%%%%%%% ��������Ԫ�ı仯Ч�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 1; % ѡ���N����Ԫ
ratio = 1; % ������ĳ���ϵ��
main_eig = reshape(UU(:,N), 3, size(UU,1)/3);
main_eig = main_eig';
model = mean_shape+ratio*coefficient(N)*main_eig; %������Ԫ

%%%%%%%%%%%%%%%%%%%%%%%% ��ʾ�α�ģ�͵ĵ���ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hold on
figure(3)
set(gcf,'color','w')
%plot3(main_eig(:,1),main_eig(:,2),main_eig(:,3),'.r') %��ʾ��Ԫ
plot3(model(:,1),model(:,2),model(:,3),'.r') %��ʾ���յ�ģ��
% hold on
%plot3(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),'.c')
grid on 
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%%%% �����ǻ���ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
tri=delaunay(model(:,1),model(:,2));
trisurf(tri,model(:,1),model(:,2),model(:,3))
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')
%%%%%%%%%%%%%%%%%%%%%%%% ��ʾ�α�ģ�͵Ĺ⻬ͼ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(6)
% xnodes=min(model(:,1)):.5:max(model(:,1));
% ynodes=min(model(:,2)):.5:max(model(:,2));
% [zg,xg,yg] = gridfit(model(:,1),model(:,2),model(:,3),xnodes,ynodes);
% surf(xg,yg,zg)
% set(gcf,'color','w')
% shading interp
% colormap(jet(256))
% camlight left %headlight
% lighting phong
% grid off
%%%%%%%%%%%%%%%%%%%%%%% ����������ģ���ϵ�ͶӰֵ %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% load('�»��ֺ��ѵ������(����ת)\27\SS.mat'); 
% f27 = SS;
% sizef = size(f27)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %�õ����յ���״����
% delta_f27 = f27 - meanvec;
% sizeUU = size(UU')
% sizedelta_f27 = size(delta_f27)
% alpha27 = UU'*delta_f27
% 
% load('�»��ֺ��ѵ������(����ת)\4\SS.mat'); 
% f4 = SS;
% sizef = size(f4)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %�õ����յ���״����
% delta_f4 = f4 - meanvec;
% sizeUU = size(UU')
% sizedelta_f4= size(delta_f4)
% alpha4 = UU'*delta_f4
% 
% load('�»��ֺ��ѵ������(����ת)\3\SS.mat'); 
% f3 = SS;
% sizef = size(f3)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %�õ����յ���״����
% delta_f3 = f3 - meanvec;
% sizeUU = size(UU')
% sizedelta_f3= size(delta_f3)
% alpha3 = UU'*delta_f3
% 
% load('�»��ֺ��ѵ������(����ת)\11\SS.mat'); 
% f11 = SS;
% sizef = size(f11)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %�õ����յ���״����
% delta_f11 = f11 - meanvec;
% sizeUU = size(UU')
% sizedelta_f11= size(delta_f11)
% alpha11 = UU'*delta_f11
% 
% load('�»��ֺ��ѵ������(����ת)\13\SS.mat'); 
% f13 = SS;
% sizef = size(f13)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %�õ����յ���״����
% delta_f13 = f13 - meanvec;
% sizeUU = size(UU')
% sizedelta_f13= size(delta_f13)
% alpha13 = UU'*delta_f13
% 
% 
% figure(7)
% t=1:num_eig;
% plot(t,coefficient,'-+r',t,alpha27,'-*b',t,alpha4,'-oc',t,alpha3,':x',t,alpha11,':og',t,alpha13,'-vm','linewidth',2)
% legend('ģ��ϵ��Ϊ��','27������ͶӰ','4������ͶӰ','3������ͶӰ','11������ͶӰ','13������ͶӰ')
% title('�α�ģ��ϵ�������о�')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% �洢�������� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save ('L:\400\3D_var_180\meanvec','meanvec')   %  �洢ƽ��ģ�ͣ�������
save ('L:\400\3D_var_180\mean_shape','mean_shape')  % �洢ƽ��ģ�ͣ�n��3��
save ('L:\400\3D_var_180\UU','UU') % �洢����������3*n��250-1��





















