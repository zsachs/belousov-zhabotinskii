% Zachariah Sachs
% CHEM 26701
% 3 June 2013

% Lotka Simulation

%!!!!This script requires the function 'Lodetka.m'
%This script includes:
% -Stuff printed 'LotkaSim.png'

%**************************************************************************
% Symbolic functions syms

%syms A(t) X(t) Y(t) P(t)

% Parameters k1=0.01, k2=0.02, k3=0.03 (a string can't interpret their
% stored values!)


%z=dsolve('DX(t)==0.01*A(t)-0.02*X(t)*Y(t)',X(0)==1.0,...          % Wrap up 
%         'DY(t)==0.02*X(t)*Y(t)-0.03*Y(t)',Y(0)==0.1,...
%         'DP(t)==0.03*Y(t)',P(0)==0.0);

% Get functions from the solution
%y1(t)=z.X
%y2(t)=z.Y
%y3(t)=z.P

% Plot
%t=linspace(1.,500.,500);

%plot(t,y1(t))
%hold on

%plot(t,y2(t),'r')
%plot(t,y3(t),'black')
%xlabel('time')
%ylabel('Concentration')

%hold off

%**************************************************************************
% TRY A DIFFERENT ODE SOLVER LIKE ode45

[T,Y]=ode45(@Lodetka,[0,1000],[2,1,0.2,0.001]);

lotsim=figure;
plot(T,Y(:,1),'-',T,Y(:,2),'-.',T,Y(:,3),'.',T,Y(:,4),'o');
title('Simulation of the Lotka Mechanism');
xlabel('Time (s)');
ylabel('Concentration (M)');
legend('[A(t)]','[X(t)]','[Y(t)]','[P(t)]');
print(lotsim,'-dpng','LotkaSim');
