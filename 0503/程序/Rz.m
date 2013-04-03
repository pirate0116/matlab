function [XYZ] = Rz(XYZ,g,units)

% Rz: Rotate 3D Cartesian coordinates around the Z axis
%
% Author:    Feng Zhang @ ustb
% Useage:   [XYZ] = Rz(XYZ,gamma,units)
%
% XYZ is a [3,N] or [N,3] matrix of 3D Cartesian coordinates
%
% 'gamma' - angle of rotation about the Z axis
% 'units' - angle is either 'degrees' or 'radians'
%           the default is gamma in radians
% 
% If input XYZ = eye(3), the XYZ returned is
% the rotation matrix.
% 
% See also Rx Ry
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~exist('units','var'), units = 'radians'; end

% convert degrees to radians
if isequal(units,'degrees'),
    g = g*pi/180;  % 转化为弧度制
end

Rz = [ cos(g) -sin(g) 0;  sin(g) cos(g) 0;  0 0 1 ];

if isequal(size(XYZ,1),3),
    XYZ = Rz * XYZ;
else
    XYZ = XYZ';
    if isequal(size(XYZ,1),3),
        XYZ = [Rz * XYZ]';
    else
        error('Rz: Input XYZ must be [N,3] or [3,N] matrix.\n');
    end
end

return
