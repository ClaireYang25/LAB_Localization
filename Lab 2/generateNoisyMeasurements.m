function [ rho ] = generateNoisyMeasurements(parameters,h,TYPE)

for a = 1:parameters.numberOfAP
    switch TYPE
        case 'TOA'
            rho(a) = h(a) + parameters.sigmaTOA*randn;
        case 'RSS'
            rho(a) = h(a) + parameters.sigmaRSS*randn;
        case 'AOA'
            rho(a) = h(a) + parameters.sigmaAOA*randn;
        case 'TDOA'
            rho(a) = h(a) + parameters.sigmaTDOA*randn;
    end
end

end