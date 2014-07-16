deg = 5; % degree of random polynomial
n = 5000; % number of iterations
means = 1:n; % will record mean of the differences between roots at each iteration
gapsrange = 1:n;
 
a = -50; % random polynomial will have roots between a and a+b
b = 100;
 
lambda = 1; % constant for lambda - D operator

H = @(n) sum(1./(1:n));
 
clf
subplot(2,2,[1 2]);
title('Roots after n iterations, adjusted for drift');
hold on

subplot(2,2,4);
title('(Gaps between roots)/(average gap)');
hold on
 
p = poly(a*ones(1,deg)+b*rand(1,deg));   % creates a polynomial with random +ve roots to begin with
p1 = p;
 
for i=1:n
    subplot(2,2,[1 2]);
    p1 = lambda*p1 - [0, polyder(p1)];
    rs = sort(roots(p1))-ones(deg,1);
    p1 = poly(rs);
    ds = diff(rs);
    gapsrange(i) = range(ds);
    means(i) = mean(ds);
    plot(rs, i*ones(1,deg),'b.','MarkerSize',5);
    if ~mod(i,n/20)
        plot(max(rs) + 1/(1-sum(1./ds))-1,i+1,'k+','MarkerSize',5);
        plot(max(rs) + 1/(1-H(deg-1)/mean(ds))-1,i+1,'ko','MarkerSize',5);
        subplot(2,2,4);
        plot(1:deg-1,ds/mean(ds));
    end
end

subplot(2,2,3);
title('(Mean root difference after n iterations) - (predicted value)');
hold on
%plot(means)
const = 2*H(deg-1)/(deg-1);
m = mean(diff(sort(roots(p)))); % mean root difference of original polynomial
y = zeros(1,n);
y(1) = m + const/m;
for i=2:n
    y(i) = y(i-1) + const/y(i-1);
end
%del = (m/const)^2;
plot(means - y,'k-')

nds = [nds [ds/mean(ds); zeros(12-deg,1)]];

% for i=1:10
%     col = nds(:,i);
%     inds = find(col);
%     [m,n] = size(inds);
%     plot((inds-ones(m,n))/(m-1),col(inds))
% end

clf
plot(gapsrange)

hold off