function [Cmean,Cgaussian,Dir1,Dir2,Lambda1,Lambda2,Ne,N]=patchcurvature2(FV,neighbs)
% This function calculates the principal curvature directions and values
% of a triangulated mesh. //计算三角网格主曲率方向/值
%
% The function first rotates the data so the normal of the current
% vertex becomes [-1 0 0], so we can describe the data by XY instead of
% XYZ.
%
% Secondly it fits a least-squares quadratic patch to the local 
% neighborhood of a vertex "f(x,y) = ax^2 + by^2 + cxy + dx + ey + f". 
% 顶点局部邻域的最小二乘修补
% Then the eigenvectors and eigenvalues of the hessian are used to
% calculate the principal, mean and gaussian curvature.
% hessian的特征值和特征向量用来计算主曲率、平均曲率和高斯曲率
%
% [Cmean,Cgaussian,Dir1,Dir2,Lambda1,Lambda2]=patchcurvature(FV,usethird)
%
% inputs, 输入
%   FV : 三角网格
%   FV : A triangulated mesh (see Patch) 
%   usethird : 三阶邻域顶点的曲率拟合（真/假）
%   usethird : Use third order neighbour vertices for the curvature
%              fit, making it smoother but less local. true/ false (default)
%   
%
%%%%  neighbs: 2 表示曲率拟合使用邻域顶点的2环
%%%%  neighbs: 2 stand for using the 2 rings of neighbour vertices for the
%%%%            curvature fit.
%%%%            3 stand for 3 rings, and so on.  
%%%%            Default is 2.
%
% outputs,输出
%   Cmean : Mean Curvature 平均曲率
%   Cgaussian : Gaussian Curvature 高斯曲率
%   Dir1 : XYZ Direction of first Principal component 第一个主元的xyz方向
%   Dir2 : XYZ Direction of second Principal component 第二个主元的xyz方向
%   Lambda1 : value of first Principal component 第一个主元值
%   Lambda2 : value of second Principal component 第二个主元值
%
% Example, Jaw
%   load('testdata.mat');
%
%   [Cmean,Cgaussian,Dir1,Dir2,Lambda1,Lambda2]=patchcurvature(FV,true);
%
%   figure, title('Principal A');
%     p1=FV.vertices-2*Dir1; p2=FV.vertices+2*Dir1;       
%     plot3([p1(:,1) p2(:,1)]',[p1(:,2) p2(:,2)]',[p1(:,3) p2(:,3)]','g-');
%     axis equal; view(3) 
%   figure, title('Principal B');
%     p1=FV.vertices-2*Dir2; p2=FV.vertices+2*Dir2;       
%     plot3([p1(:,1) p2(:,1)]',[p1(:,2) p2(:,2)]',[p1(:,3) p2(:,3)]','r-');
%     axis equal; view(3)
%
%
% Example, Cylinder
%   load('testdata2.mat');
%
%   [Cmean,Cgaussian,Dir1,Dir2,Lambda1,Lambda2]=patchcurvature(FV);
%
%   figure,
%   subplot(2,2,1), title('Mean Curvature');
%     C=Cmean;
%     patch(FV,'FaceColor','interp','FaceVertexCData',C,'edgecolor','none');
%     axis equal; view(3)
%   subplot(2,2,2), title('Gaussian Curvature');
%     C=Cgaussian;
%     patch(FV,'FaceColor','interp','FaceVertexCData',C,'edgecolor','none');
%     axis equal; view(3)
%   subplot(2,2,3), title('Principal A');
%     p1=FV.vertices-2*Dir1; p2=FV.vertices+2*Dir1;       
%     plot3([p1(:,1) p2(:,1)]',[p1(:,2) p2(:,2)]',[p1(:,3) p2(:,3)]','g-');
%     axis equal; view(3) 
%   subplot(2,2,4), title('Principal B');
%     p1=FV.vertices-2*Dir2; p2=FV.vertices+2*Dir2;       
%     plot3([p1(:,1) p2(:,1)]',[p1(:,2) p2(:,2)]',[p1(:,3) p2(:,3)]','r-');
%     axis equal; view(3)
%     
%
% Function is written by D.Kroon University of Twente (August 2011)    

% Check inputs
% if(nargin<2), usethird=false; end
if(nargin<2), neighbs=2; end

% ----------add---2013.4.7---------------
% ----------三维网格-----------------------
TRI = delaunay(XX,YY);FV = struct('faces',TRI,'vertices',[XX,YY,ZZ]);
% ---------end----------------------------

% Number of vertices //顶点个数（自己设置）
nv=size(FV.vertices,1);

% Calculate vertices normals //计算顶点法线
N=patchnormals(FV);

% Calculate Rotation matrices for the normals//法线旋转矩阵
M= zeros(3,3,nv);
Minv= zeros(3,3,nv);
for i=1:nv, 
    [M(:,:,i),Minv(:,:,i)]=VectorRotationMatrix(N(i,:));
end

% Get neighbours of all vertices //获得所有顶点的邻域
Ne=vertex_neighbours(FV);

% Loop through all vertices //遍历所有顶点
Lambda1=zeros(nv,1);
Lambda2=zeros(nv,1);
Dir1=zeros(nv,3);
Dir2=zeros(nv,3);

for i=1:nv
   % Get first and second ring neighbours. //获取第一环和第二环邻域
   switch neighbs
       case 1
           Nce=unique(Ne{i});
       case 2
           Nce=unique([Ne{Ne{i}}]);
       case 3
           Nce=unique([Ne{[Ne{Ne{i}}]}]);
       case 4
           Nce=unique([Ne{[Ne{[Ne{Ne{i}}]}]}]);
       case 5
           Nce=unique([Ne{[Ne{[Ne{[Ne{Ne{i}}]}]}]}]);
           
   end
%    if(~usethird)
%        Nce=unique([Ne{Ne{i}}]);
%    else
%        % Get first, second and third ring neighbours
%        Nce=unique([Ne{[Ne{Ne{i}}]}]);
%    end
   
   Ve=FV.vertices(Nce,:);

   % Rotate to make normal [0 0 -1]      -----[-1 0 0]
   We=Ve*Minv(:,:,i);
%    f=We(:,1); x=We(:,2); y=We(:,3); 
f=We(:,3); x=We(:,1); y=We(:,2); 
   
   % Fit patch  //拟合
   % f(x,y) = ax^2 + by^2 + cxy + dx + ey + f
   FM=[x(:).^2 y(:).^2 x(:).*y(:) x(:) y(:) ones(numel(x),1)];
   abcdef=FM\f(:);
   a=abcdef(1); b=abcdef(2); c=abcdef(3);
   
   % Make Hessian matrix //构造海赛矩阵
   % H =  [2*a c;c 2*b];
   Dxx = 2*a; Dxy=c; Dyy=2*b;
   
   [Lambda1(i),Lambda2(i),I1,I2]=eig2(Dxx,Dxy,Dyy); %求特征值
   dir1=[0 I1(1) I1(2)]*M(:,:,i); 
   dir2=[0 I2(1) I2(2)]*M(:,:,i);
   Dir1(i,:)=dir1/sqrt(dir1(1)^2+dir1(2)^2+dir1(3)^2);
   Dir2(i,:)=dir2/sqrt(dir2(1)^2+dir2(2)^2+dir2(3)^2);
end

Cmean=(Lambda1+Lambda2)/2;
Cgaussian=Lambda1.*Lambda2;

% --------------------------------------------------------
% --------------------------------------------------------
% --------------------------------------------------------
% --------------------------------------------------------
% -------------------------分割线--------------------------
%%%%%%%%----------子函数开始----------------%%%%%%%%%%%%%%%%
function [Lambda1,Lambda2,I1,I2]=eig2(Dxx,Dxy,Dyy)%求特征值
% | Dxx  Dxy |
% |          |
% | Dxy  Dyy |

% Compute the eigenvectors //求特征向量
tmp = sqrt((Dxx - Dyy).^2 + 4*Dxy.^2);
v2x = 2*Dxy; v2y = Dyy - Dxx + tmp;

% Normalize 归一化
mag = sqrt(v2x.^2 + v2y.^2); i = (mag ~= 0);
v2x(i) = v2x(i)./mag(i);
v2y(i) = v2y(i)./mag(i);

% The eigenvectors are orthogonal //特征向量正交
v1x = -v2y; v1y = v2x;

% Compute the eigenvalues //求特征值
mu1 = abs(0.5*(Dxx + Dyy + tmp));
mu2 = abs(0.5*(Dxx + Dyy - tmp));
% mu1 = 0.5*(Dxx + Dyy + tmp);
% mu2 = 0.5*(Dxx + Dyy - tmp);

% Sort eigen values by absolute value
% abs(Lambda1)<abs(Lambda2)//特征值按绝对值大小排序
if(abs(mu1)<abs(mu2))
    Lambda1=mu1;
    Lambda2=mu2;
    I1=[v1x v1y];
    I2=[v2x v2y];
else
    Lambda1=mu2;
    Lambda2=mu1;
    I1=[v2x v2y];
    I2=[v1x v1y];
end


function N=patchnormals(FV)
% This function PATCHNORMALS calculates the normals of a triangulated
% mesh. PATCHNORMALS calls the patchnormal_double.c mex function which 
% first calculates the normals of all faces, and after that calculates 
% the vertice normals from the face normals weighted by the angles 
% of the faces.
% 计算一个三角网格的法线。
% 该函数调用 patchnormal_double.c（第一次计算所有人脸的法线）
% 计算人脸角度为权值的面部法线中的顶点法线
[Nx,Ny,Nz]=patchnormals_double(double(FV.faces(:,1)),double(FV.faces(:,2)),double(FV.faces(:,3)),double(FV.vertices(:,1)),double(FV.vertices(:,2)),double(FV.vertices(:,3)));
N=zeros(length(Nx),3);
N(:,1)=Nx; N(:,2)=Ny; N(:,3)=Nz;



function [Nx,Ny,Nz]=patchnormals_double(Fa,Fb,Fc,Vx,Vy,Vz)
%
%  [Nx,Ny,Nz]=patchnormals_double(Fa,Fb,Fc,Vx,Vy,Vz)
%

FV.vertices=zeros(length(Vx),3);
FV.vertices(:,1)=Vx;
FV.vertices(:,2)=Vy;
FV.vertices(:,3)=Vz;

% Get all edge vectors //获得所有边界向量
e1=FV.vertices(Fa,:)-FV.vertices(Fb,:);
e2=FV.vertices(Fb,:)-FV.vertices(Fc,:);
e3=FV.vertices(Fc,:)-FV.vertices(Fa,:);

% Normalize edge vectors //归一化边界向量
e1_norm=e1./repmat(sqrt(e1(:,1).^2+e1(:,2).^2+e1(:,3).^2),1,3); 
e2_norm=e2./repmat(sqrt(e2(:,1).^2+e2(:,2).^2+e2(:,3).^2),1,3); 
e3_norm=e3./repmat(sqrt(e3(:,1).^2+e3(:,2).^2+e3(:,3).^2),1,3);

% Calculate Angle of face seen from vertices  //人脸角度？？？
Angle =  [acos(dot(e1_norm',-e3_norm'));acos(dot(e2_norm',-e1_norm'));acos(dot(e3_norm',-e2_norm'))]';

% Calculate normal of face //面部法线
 Normal=cross(e1,e3); %叉积向量

% Calculate Vertice Normals //计算顶点法线
VerticeNormals=zeros([size(FV.vertices,1) 3]);
for i=1:size(Fa,1),
    VerticeNormals(Fa(i),:)=VerticeNormals(Fa(i),:)+Normal(i,:)*Angle(i,1);
    VerticeNormals(Fb(i),:)=VerticeNormals(Fb(i),:)+Normal(i,:)*Angle(i,2);
    VerticeNormals(Fc(i),:)=VerticeNormals(Fc(i),:)+Normal(i,:)*Angle(i,3);
end

V_norm=sqrt(VerticeNormals(:,1).^2+VerticeNormals(:,2).^2+VerticeNormals(:,3).^2)+eps;
VerticeNormals=VerticeNormals./repmat(V_norm,1,3);
Nx=VerticeNormals(:,1);
Ny=VerticeNormals(:,2);
Nz=VerticeNormals(:,3);

    
    

function [M,Minv]=VectorRotationMatrix(v)
% [M,Minv]=VectorRotationMatrix(v,k)
v=(v(:)')/sqrt(sum(v.^2));
k=rand(1,3);
l = [k(2).*v(3)-k(3).*v(2), k(3).*v(1)-k(1).*v(3), k(1).*v(2)-k(2).*v(1)]; l=l/sqrt(sum(l.^2));
k = [l(2).*v(3)-l(3).*v(2), l(3).*v(1)-l(1).*v(3), l(1).*v(2)-l(2).*v(1)]; k=k/sqrt(sum(k.^2));
% Minv=[v(:) l(:) k(:)];
Minv=[l(:) k(:) v(:)];
M=inv(Minv);

function Ne=vertex_neighbours(FV)
% 搜索每个顶点的所有邻域
% This function VERTEX_NEIGHBOURS will search in a face list for all 
% the neigbours of each vertex. 
% 
% Ne=vertex_neighbours(FV)
%
Ne=vertex_neighbours_double(FV.faces(:,1),FV.faces(:,2),FV.faces(:,3),FV.vertices(:,1),FV.vertices(:,2),FV.vertices(:,3));

function Ne=vertex_neighbours_double(Fa,Fb,Fc,Vx,Vy,Vz)

F=[Fa Fb Fc];
V=[Vx Vy Vz];

% Neighbourh cell array //邻域cell数组
Ne=cell(1,size(V,1)); %定义一个空数组

% Loop through all faces //遍历所有face 13631面片
for i=1:length(F)
    % Add the neighbors of each vertice of a face
    % to his neighbors list. //在邻域表中加入每个顶点的邻域？？？
    Ne{F(i,1)}=[Ne{F(i,1)} [F(i,2) F(i,3)]];
    Ne{F(i,2)}=[Ne{F(i,2)} [F(i,3) F(i,1)]];
    Ne{F(i,3)}=[Ne{F(i,3)} [F(i,1) F(i,2)]];
end

% Loop through all neighbor arrays and sort them (Rotation same as faces)
% // 遍历所有邻域数组，排序
for i=1:size(V,1)
 
    Pneighf=Ne{i};
    if(isempty(Pneighf))
        Pneig=[];
    else
        start=1;
        for index1=1:2:length(Pneighf)
            found=false;
            for index2=2:2:length(Pneighf),
                if(Pneighf(index1)==Pneighf(index2))
                    found=true; break
                end
            end
            if(~found)
                start=index1; break
            end
        end
        Pneig=[];
        Pneig(1)=Pneighf(start);
        Pneig(2)=Pneighf(start+1);
        
        % Add the neighbours with respect to original rotation
        for j=2+double(found):(length(Pneighf)/2)
            found = false;
            for index=1:2:length(Pneighf),
                if(Pneighf(index)==Pneig(end))
                    if(sum(Pneig==Pneighf(index+1))==0)
                        found =true;
                        Pneig=[Pneig Pneighf(index+1)];
                    end
                end
            end
            if(~found) % This only happens with weird edge vertices
                for index=1:2:length(Pneighf),
                    if(sum(Pneig==Pneighf(index))==0)
                        Pneig=[Pneig Pneighf(index)];
                        if(sum(Pneig==Pneighf(index+1))==0)
                            Pneig=[Pneig Pneighf(index+1)];
                        end
                    end
                end
            end
        end
        % Add forgotten neigbours
        if(length(Pneig)<length(Pneighf))
            for j=1:length(Pneighf)
                if(sum(Pneig==Pneighf(j))==0)
                    Pneig=[Pneig Pneighf(j)];
                end
            end
        end
    end
    Ne{i}=Pneig;
end





