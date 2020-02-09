P = [1790 3929214;
    1800 5308483;
    1810 7239881;
    1820 9638453;
    1830 12866020;
    1840 17069453;
    1850 23191876;
    1860 31443321;
    1870 39818449;
    1880 50189209;
    1890 62947714;
    1900 76212168;
    1910 92228496;
    1920 106021537;
    1930 122775046;
    1940 132164569;
    1950 150697361;
    1960 179323175;
    1970 203302031;
    1980 226545805;
    1990 248709873;
    2000 281421906;
    2010 308745538];

%Malthusian Model
X = [P(:,2)];
X(size(P,1),:) = [];
Y_n1 = P(:,2); Y_n1(1,:) = [];
Y_n = P(:,2); Y_n(size(P,1),:) = [];
Y = Y_n1 - Y_n;

b = (inv(X'*X))*X'*Y;

Y_diff = X*b;

p0=3929214;
p_Malthusian(1)=p0;
for n = 1:(size(P,1)-1)
    p_Malthusian(n+1) = p_Malthusian(n)+Y_diff(n);
end

%Discrete Logistic Model
X = [P(:,2) (P(:,2)).^2];
X(size(P,1),:) = [];
Y_n1 = P(:,2); Y_n1(1,:) = [];
Y_n = P(:,2); Y_n(size(P,1),:) = [];
Y = Y_n1 - Y_n;

b = (inv(X'*X))*X'*Y;

Y_diff = X*b;

p0=3929214;
p_logistic(1)=p0;
for n = 1:(size(P,1)-1)
    p_logistic(n+1) = p_logistic(n)+Y_diff(n);
end

%Gompertz Model
X = [P(:,2) (P(:,2)).*log(P(:,2))];
X(size(P,1),:) = [];
Y_n1 = P(:,2); Y_n1(1,:) = [];
Y_n = P(:,2); Y_n(size(P,1),:) = [];
Y = Y_n1 - Y_n;

b = (inv(X'*X))*X'*Y;

Y_diff = X*b;

p0=3929214;
p_gompertz(1)=p0;
for n = 1:(size(P,1)-1)
    p_gompertz(n+1) = p_gompertz(n)+Y_diff(n);
end

%Beverton-Holt Model
X = [P(:,2) (P(:,2)).^2 (P(:,2)).^3 (P(:,2)).^4 (P(:,2)).^5];
X(size(P,1),:) = [];
Y_n1 = P(:,2); Y_n1(1,:) = [];
% Y_n = P(:,2); Y_n(size(P,1),:) = [];
Y = Y_n1; %- Y_n;

b = (inv(X'*X))*X'*Y;

Y_diff = X*b;

p0=3929214;
p_bev_holt(1)=p0;
for n = 1:(size(P,1)-1)
    p_bev_holt(n+1) = Y_diff(n);
end

%PLOTS
scatter(P(:,1),P(:,2),'DisplayName','Census Data'); hold on;
plot(P(:,1),p_Malthusian,'--*','DisplayName','Malthusian'); hold on;
plot(P(:,1),p_logistic,'--+','DisplayName','Discrete logistic'); hold on;
plot(P(:,1),p_gompertz,'--','DisplayName','Gompertz'); hold on;
plot(P(:,1),p_bev_holt,'DisplayName','Beverton Holt'); hold off;
legend('Location','northwest');
title('Comparison of the population growth models');
xlabel('Year');
ylabel('Population');
ax = gca;
ax.YAxis.Exponent = 0;