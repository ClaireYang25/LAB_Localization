function [R] = buildCovarianceMatrix( parameters , TYPE )

switch TYPE
    case 'TOA'
        R = diag(repmat(parameters.sigmaTOA.^2,1,parameters.numberOfAP));
    case 'AOA'
        R = diag(repmat(parameters.sigmaAOA.^2,1,parameters.numberOfAP));
    case 'RSS'
        R = diag(repmat(parameters.sigmaRSS.^2,1,parameters.numberOfAP));
    case 'TDOA'
        R = diag(repmat(parameters.sigmaTDOA.^2,1,parameters.numberOfAP));
end

end