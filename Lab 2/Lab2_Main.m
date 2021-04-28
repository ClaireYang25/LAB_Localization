clear all, clc, close all
set(0,'DefaultTextFontSize',22)
set(0,'DefaultLineLineWidth',2);
set(0,'DefaultTextInterpreter','latex')
set(0,'DefaultAxesFontSize',16)

%% 1. Define the localization scenario
% scenario settings
parameters.xmin = -100; parameters.ymin = -100;
parameters.xmax =  100; parameters.ymax =  100;

% position of the Access Points
parameters.numberOfAP = 4; % it can be 2, 3, 4 or 6
[ AP ] = generatePositionOfAP(parameters);

% position of the UE
UE = [10,10];

% plot
% plotScenario(parameters,AP,UE)


%% 2. Generate noisy measurements 
TYPE = 'TOA'; 
% TYPE = 'AOA';

% build observation vector/matrix
h = measurementModel( parameters , UE , AP , TYPE );

% generate noisy measurements
parameters.sigmaTOA = 5; %m
parameters.sigmaAOA = deg2rad(5); %deg
parameters.sigmaTDOA = 5; %m
parameters.sigmaRSS = 5; %m

rho = generateNoisyMeasurements( parameters , h , TYPE );

%% 3. build covariance matrix
R = buildCovarianceMatrix( parameters , TYPE );

%% 4. build matrix H
H = buildJacobianMatrixH( parameters , UE , AP , TYPE );

%% 5. calculate and plot the CRB ellipse
calculateEllipse( parameters , H , R , UE , AP , TYPE , 3 );

%% extra funny things
%% 1
close all
%remove fig=figure() from function "plotEllipse"
for i=1:7
    UE = [(rand-0.5)*2*parameters.xmax,(rand-0.5)*2*parameters.ymax];
    TYPE = 'TOA';
    H = buildJacobianMatrixH( parameters , UE , AP , TYPE );
    parameters.sigmaTOA = randi(10);
    R = buildCovarianceMatrix( parameters , TYPE );
    HDOP(i) = sqrt(trace(inv(H'*inv(R)*H)));
    calculateEllipse(parameters,H,R,UE,AP,TYPE,3);
    pause(2)
end

%% 2 
%remove patch from function "plotEllipse"
close all
parameters.sigmaTOA = 10;
vecY = -100:8:100;
for i=1:length(vecY)
    UE = [0,vecY(i)];
    TYPE = 'AOA';
    H = buildJacobianMatrixH( parameters , UE , AP , TYPE );
    R = buildCovarianceMatrix( parameters , TYPE );
    HDOP(i) = sqrt(trace(inv(H'*inv(R)*H)));
    calculateEllipse(parameters,H,R,UE,AP,TYPE,3);
    pause(2)
end