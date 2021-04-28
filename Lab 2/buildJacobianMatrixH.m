function [ H ] = buildJacobianMatrixH(parameters,UE,AP,TYPE)

%% compute the distance between UE and APs
distanceUEAP = sqrt(sum([UE-AP].^2,2)); 

%% evaluate direction cosine
directionCosineX = (UE(1)-AP(:,1))./distanceUEAP;
directionCosineY = (UE(2)-AP(:,2))./distanceUEAP;

%% build H
H = zeros(parameters.numberOfAP,2);
for a = 1:parameters.numberOfAP
    switch TYPE
        case 'TOA'
            H(a,:) = [directionCosineX(a),directionCosineY(a)];
        case 'AOA'
            H(a,:) = [-directionCosineY(a)/distanceUEAP(a),...
                       directionCosineX(a)/distanceUEAP(a)];
    end
end

end