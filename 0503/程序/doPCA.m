%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code by zhangfeng@ ustb 2010-5-19                                       %
%                                                                         %
% 整理数据进行建模                                                         %
%                                                                         %
% 通过运行本程序，构造线性组合的形变模型（形状）                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
format compact;
ear = dir('L:\400\2D_ear_180\');
ear_num = size(ear,1);

%% 读入数据
A=[];
for k=3:92
   earSS = load(['L:\400\3D_var_180\' ear(k).name(1:9) '_SS.mat']);
   SS = earSS.SS;
   SS = ChangeOrigPnt( SS ); %改变原点
   SS = EarMarginNorm( SS ); %统一尺度
   A=[A,SS];
   disp(['已吸入第' num2str(k-2) '个形状向量！'])
end
size(A); %A是目标矩阵
save('L:\400\3D_var_180\A','A');

% Aload = load('L:\400\3D_var_180\A');
% A = Aload.A; 

%% 求平均并作图

disp('求平均：');
meanvec = mean(A, 2); %每行取平均，也即是每个对应点的x,y,z分别取平均值
mean_shape = reshape(meanvec, 3, size(meanvec,1)/3);
mean_shape = mean_shape'; %得到最终的形状向量n*3列

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 做点云图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
set(gcf,'color','w')
plot3(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),'.r')
grid on
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
tri=delaunay(mean_shape(:,1),mean_shape(:,2));
trisurf(tri,mean_shape(:,1),mean_shape(:,2),mean_shape(:,3))
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 做光滑图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%% 求特征向量【PCA主体】
tic
format long % 定义长显示
meanarray = repmat(meanvec, 1, size(A,2)); 
AA = A-meanarray; % 求差向量

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 求协方差矩阵 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
covA = AA'*AA;   %添加SVD分解
sizeCOVA = size(covA)

%%%%%%%%%%%%%%%%%%%%%%%%%%% 求特征值和特征向量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Computing principle components：');
[V, D] = eig(covA);
sizeV = size(V)
sizeD = size(D)
U = AA*V*(D^(-1/2)); %SVD分解
D = D/size(A,2);  %还原特征值
sizeU = size(U)
sizeD = size(D)

%%%%%%%%%%%%%%%%%%%%%%%%% 依据方差贡献率选择主元 %%%%%%%%%%%%%%%%%%%%%%%%%%%
num_eig = NumPrincipleEig(D,0.999) %选择主分量的个数 
DD = fliplr(D);
DD = flipud(DD);
DD = diag(DD);
save('DD','DD')

%%%%%%%%%%%%%%%%%%%%%%%% 依据主元个数选择特征向量 %%%%%%%%%%%%%%%%%%%%%%%%%%
UU = U(:,(size(U, 2) - num_eig + 1) : size(U, 2)); %定义
UU = fliplr(UU); % 得到从大到小的排列,最终提取的特征向量排列到了UU中

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc

%% 选择形变模型系数向量

D = fliplr(D);
D = flipud(D);
D = diag(D);% 提取特征值，这里的Ｄ里是由大到小排列的特征值
coefficient = -3 * sqrt(D(1:num_eig));
size_coeff = size(coefficient)

%% 构建形变模型

sizemeanshape = size(mean_shape)
%%%%%%%%%%%%%%%%%%%%%%% 叠加主元 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model = coefficient(1)*UU(:,1); % 定义形变模型矩阵
% for i= 2:num_eig
%     model = model + coefficient(i)*UU(:,i);
% end
% model = reshape(model, 3, size(model,1)/3);
% model = model';
% model = model + mean_shape; %平均模型叠加主元
%%%%%%%%%%%%%%%%%%%%%%% 看单个主元的变化效果 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 1; % 选择第N个主元
ratio = 1; % 西格玛的常数系数
main_eig = reshape(UU(:,N), 3, size(UU,1)/3);
main_eig = main_eig';
model = mean_shape+ratio*coefficient(N)*main_eig; %叠加主元

%%%%%%%%%%%%%%%%%%%%%%%% 显示形变模型的点云图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hold on
figure(3)
set(gcf,'color','w')
%plot3(main_eig(:,1),main_eig(:,2),main_eig(:,3),'.r') %显示主元
plot3(model(:,1),model(:,2),model(:,3),'.r') %显示最终的模型
% hold on
%plot3(mean_shape(:,1),mean_shape(:,2),mean_shape(:,3),'.c')
grid on 
axis equal
%%%%%%%%%%%%%%%%%%%%%%%%%%% 做三角化的图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
tri=delaunay(model(:,1),model(:,2));
trisurf(tri,model(:,1),model(:,2),model(:,3))
shading interp
colormap(jet(256))
camlight left
lighting phong
set(gcf,'color','w')
%%%%%%%%%%%%%%%%%%%%%%%% 显示形变模型的光滑图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%% 计算样本在模型上的投影值 %%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% load('新划分后的训练数据(已旋转)\27\SS.mat'); 
% f27 = SS;
% sizef = size(f27)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %得到最终的形状向量
% delta_f27 = f27 - meanvec;
% sizeUU = size(UU')
% sizedelta_f27 = size(delta_f27)
% alpha27 = UU'*delta_f27
% 
% load('新划分后的训练数据(已旋转)\4\SS.mat'); 
% f4 = SS;
% sizef = size(f4)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %得到最终的形状向量
% delta_f4 = f4 - meanvec;
% sizeUU = size(UU')
% sizedelta_f4= size(delta_f4)
% alpha4 = UU'*delta_f4
% 
% load('新划分后的训练数据(已旋转)\3\SS.mat'); 
% f3 = SS;
% sizef = size(f3)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %得到最终的形状向量
% delta_f3 = f3 - meanvec;
% sizeUU = size(UU')
% sizedelta_f3= size(delta_f3)
% alpha3 = UU'*delta_f3
% 
% load('新划分后的训练数据(已旋转)\11\SS.mat'); 
% f11 = SS;
% sizef = size(f11)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %得到最终的形状向量
% delta_f11 = f11 - meanvec;
% sizeUU = size(UU')
% sizedelta_f11= size(delta_f11)
% alpha11 = UU'*delta_f11
% 
% load('新划分后的训练数据(已旋转)\13\SS.mat'); 
% f13 = SS;
% sizef = size(f13)
% %f = reshape(f_long, 3, size(f_long,1)/3);
% %f = f'; %得到最终的形状向量
% delta_f13 = f13 - meanvec;
% sizeUU = size(UU')
% sizedelta_f13= size(delta_f13)
% alpha13 = UU'*delta_f13
% 
% 
% figure(7)
% t=1:num_eig;
% plot(t,coefficient,'-+r',t,alpha27,'-*b',t,alpha4,'-oc',t,alpha3,':x',t,alpha11,':og',t,alpha13,'-vm','linewidth',2)
% legend('模型系数为σ','27号样本投影','4号样本投影','3号样本投影','11号样本投影','13号样本投影')
% title('形变模型系数向量研究')

%%%%%%%%%%%%%%%%%%%%%%%%%%%% 存储各个变量 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save ('L:\400\3D_var_180\meanvec','meanvec')   %  存储平均模型，列向量
save ('L:\400\3D_var_180\mean_shape','mean_shape')  % 存储平均模型，n行3列
save ('L:\400\3D_var_180\UU','UU') % 存储特征向量，3*n行250-1列





















