function gplot3(A, xyz)
%GPLOT3 Plot graph, as in "graph theory".
%   GPLOT3(A,xyz) plots the graph specified by A and xyz. A graph, G, is
%   a set of nodes numbered from 1 to n, and a set of connections, or
%   edges, between them.  
%
%   In order to plot G, two matrices are needed. The adjacency matrix,
%   A, has a(i,j) nonzero if and only if node i is connected to node
%   j.  The coordinates array, xyz, is an n-by-3 matrix with the
%   position for node i in the i-th row, xyz(i,:) = [x(i) y(i) z(i)].
%   
%   GPLOT3(A,xy,LineSpec) uses line type and color specified in the
%   string LineSpec. See PLOT for possibilities.
%   
%   See also GPLOT.
%
% Auth: Joshua Pickard
% Date: Nov 11, 2022

X = xyz(:, 1);
Y = xyz(:, 2);
Z = xyz(:, 3);

% Plot node positions
scatter3(X,Y,Z,'filled','o'); hold on;

[I, J] = find(A ~= 0);

if nargin < 3
    lc = '';
end
[lsty, csty, msty] = gplotGetRightLineStyle(gca,lc);
for c=1:length(I)
    v = xyz([I(c) J(c)], :);
    plot3(v(:,1),v(:,2),v(:,3),'LineStyle',lsty,'Color',csty,'Marker',msty)
end


function [lsty, csty, msty] = gplotGetRightLineStyle(ax, lc)
%  gplotGetRightLineStyle
%    Helper function which correctly sets the color, line style, and marker
%    style when plotting the data above.  This style makes sure that the
%    plot is as conformant as possible to gplot from previous versions of
%    MATLAB, even when the coordinates array is not a floating point type.
co = get(ax,'ColorOrder');
lo = get(ax,'LineStyleOrder');
holdstyle = getappdata(gca,'PlotHoldStyle');
if isempty(holdstyle)
    holdstyle = 0;
end
lind = getappdata(gca,'PlotLineStyleIndex');
if isempty(lind) || holdstyle ~= 1
    lind = 1;
end
cind = getappdata(gca,'PlotColorIndex');
if isempty(cind) || holdstyle ~= 1
    cind = 1;
end
nlsty = lo(lind);
ncsty = co(cind,:);
nmsty = 'none';
%  Get the linespec requested by the user.
[lsty,csty,msty] = colstyle(lc);
if isempty(lsty)
    lsty = nlsty;
end
if isempty(csty)
    csty = ncsty;
end
if isempty(msty)
    msty = nmsty;
end
