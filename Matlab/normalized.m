deg = 3; % degree of random polynomial
n = 10000; % number of iterations
 
a = -1; % random polynomial will have roots between a and a+b
b = 2;
 
clf
title('Roots after n iterations, normalized by average root');
hold on
 
p = poly(a*ones(1,deg)+b*rand(1,deg));   % creates a polynomial with random +ve roots to begin with
p1 = p;
 
for i=1:n
    p1 = p1 - [0, polyder(p1)];
    rs = sort(roots(p1))-ones(deg,1);
    p1 = poly(rs);
    m = mean(rs);
    if i>1000 % don't plot first few to avoid cluttering plot
        plot((rs+i)./(m+i), i*ones(1,deg),'b.','MarkerSize',5);
    end
end

line([1 1],[0 n],'Color','r'); % plot reference line at x=1

hold off