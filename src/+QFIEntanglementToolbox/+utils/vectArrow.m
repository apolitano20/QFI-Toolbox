function vectArrow(p0_vec,p1_vec)
%VECTARROW 3-D vector plot.
%   vectArrow(p0_vec,p1_vec) plots a line vector with arrow pointing from point p0_vec
%   to point p1_vec. The function can plot both 2D and 3D vector with arrow
%   depending on the dimension of the input
%
%   Example:
%       3D vector
%       p0_vec = [1 2 3];   % Coordinate of the first point p0_vec
%       p1_vec = [4 5 6];   % Coordinate of the second point p1_vec
%       vectArrow(p0_vec,p1_vec)
%
%       2D vector
%       p0_vec = [1 2];     % Coordinate of the first point p0_vec
%       p1_vec = [4 5];     % Coordinate of the second point p1_vec
%       vectArrow(p0_vec,p1_vec)
%
% package: QFIEntanglementToolbox.utils

  if max(size(p0_vec))==3
      if max(size(p1_vec))==3
          x0 = p0_vec(1);
          y0 = p0_vec(2);
          z0 = p0_vec(3);
          x1 = p1_vec(1);
          y1 = p1_vec(2);
          z1 = p1_vec(3);
          plot3([x0;x1],[y0;y1],[z0;z1]);   % Draw a line between p0_vec and p1_vec
          
          p = p1_vec-p0_vec;
          alpha = 0.1;  % Size of arrow head relative to the length of the vector
          beta = 0.1;  % Width of the base of the arrow head relative to the length
          
          hU = [x1-alpha*(p(1)+beta*(p(2)+eps)); x1; x1-alpha*(p(1)-beta*(p(2)+eps))];
          hV = [y1-alpha*(p(2)-beta*(p(1)+eps)); y1; y1-alpha*(p(2)+beta*(p(1)+eps))];
          hW = [z1-alpha*p(3);z1;z1-alpha*p(3)];
          
          hold on
          plot3(hU(:),hV(:),hW(:))  % Plot arrow head
          grid on
          xlabel('x')
          ylabel('y')
          zlabel('z')
          hold off
      else
          error('p0_vec and p1_vec must have the same dimension')
      end
  elseif max(size(p0_vec))==2
      if max(size(p1_vec))==2
          x0 = p0_vec(1);
          y0 = p0_vec(2);
          x1 = p1_vec(1);
          y1 = p1_vec(2);
          plot([x0;x1],[y0;y1]);   % Draw a line between p0_vec and p1_vec
          
          p = p1_vec-p0_vec;
          alpha = 0.1;  % Size of arrow head relative to the length of the vector
          beta = 0.1;  % Width of the base of the arrow head relative to the length
          
          hU = [x1-alpha*(p(1)+beta*(p(2)+eps)); x1; x1-alpha*(p(1)-beta*(p(2)+eps))];
          hV = [y1-alpha*(p(2)-beta*(p(1)+eps)); y1; y1-alpha*(p(2)+beta*(p(1)+eps))];
          
          hold on
          plot(hU(:),hV(:))  % Plot arrow head
          grid on
          xlabel('x')
          ylabel('y')
          hold off
      else
          error('p0_vec and p1_vec must have the same dimension')
      end
  else
      error('this function only accepts 2D or 3D vector')
  end
