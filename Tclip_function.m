function [count, list] = tclip(a,b,c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   The function tclip analyzes the intersection of the solutions set
%   of ax+by=c with the "solid" triangle with vertices (0,0), (0,1), (1,0).
%
%   The return value count is
%        -2 if the solution set of ax+by=c is empty,
%        -1 if the solution set of ax+by=c is the plane,
%         0 if the line fails to intersect the triangle,
%         1 if the line intersects the triangle in one point,
%         2 if the line intersects the triangle in infinitely many points.
%
%   The return value list is
%         an empty list of 2-component column vectors if count<= 0
%         a 2-component column vector with the coordinates of intersection
%             if count==1,
%         a 2x2 array (list of two 2-component column vectors) with the
%             endpoints of the intersection if count==2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    count = 0;           % default return value  
    list = zeros(2,0);   % default return value (empty list)

    %%%%%%%%%%%%%%%%%%%%%%%% CASE 0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if a==0 && b==0      % CASE 0:  solution set not a line

        if c == 0        % solution set is the plane
            count = -1;
        else             % solution set is empty
            count = -2; 
        end
               
        return

    end
    
    %%%%%%%%%%%%%%%%%%%%%%%% CASE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if a==0 && b~=0      % CASE 1:  horizontal line

        y = c/b;

        if 0<=y 
            if y<1       % infinite intersection
                count = 2;
                list = [0 1-y; y y];     % endpoints (0,y) and (1-y,y)   
            elseif y==1  % singleton intersection
                count = 1;
                list = [0; 1];
            end
        end

        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%% CASE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if a~=0 && b==0       % CASE 2:  vertical line

        % INSERT CODE needed to handle the case of a vertical line
        x = c/a
        if x>0 && x<1 % doesn't intersect infinetely or only once
            count = 2;
            list = [x x; 0 1-x]; % endpoints - x axis and 1-x
        elseif x==1 % right endpoint
            count = 1;
            list = [1;0];
        elseif x==0
            count = 2;
            list = [0 0; 0 1];
        end
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%% CASE 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if a-b == 0 && a~=0         % CASE 3:  line parallel to hypotenuse

        % INSERT CODE needed to handle the case of a line parallel to the hypotenuse
        intercept = c/a;
        if intercept==1 % intersects entire hyptenuse
            count = 2;
            list = [0 1;1 0];
        elseif intercept>0 && intercept <1 %intersects at 2 points
            count = 2;
            list = [0 intercept;intercept 0];
        elseif intercept==0 % line y = x - intersect at origin
            count = 1;
            list = [0;0];
        else % no intersection
            count = 0;
        end
        return
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%% CASE 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if a~=0 && b~=0 && a-b~=0   %  CASE 4:   generic line
        
        % check intersection with the y-axis (x=0)

        y = c/b;

        if 0<=y && y<1    % Note: (0,0) is on left side but (0,1) is not
            count = count + 1;
            list(:,count) = [0; y];
        end

        % check intersection with the x-axis (y=0)

        %%%% INSERT CODE to process the intersection with the x-axis.
        x = c/a;
        if x>0 && x<1
            count = count+1;
            list(:,count) = [x;0];
        end

        % check intersection with the hypotenuse (x+y=1)
        
        %%%% INSERT CODE to process the intersection with the hypotenuse.
        xh = (c-b)/(a-b);
        yh = 1-xh;
        if xh>=0 && xh<1 && yh>=0 && yh<=1
            count = count+1;
            list(:,count) = [xh;yh];
        end

        if count == 1
            list = list(:,1);
        end
        return
    end
end

 
