function [uHat,numberOfPerformedIterations] = iterativeNLS(parameters,AP,TYPE,Q,rho)

% NLS starting point - initial guess
uHatInit = [(rand-0.5)*parameters.xmax,(rand-0.5)*parameters.ymax];
%uHatInit = [33,33];
uHat = zeros(parameters.NiterMax,2);

for iter=1:parameters.NiterMax-1
    %% Step 1 - initial guess
    if iter==1
        uHat(iter,:) = uHatInit;
    end
    %% Step 2 - compute Jacobian matrix
    [ H ] = buildJacobianMatrixH(parameters,uHat(iter,:),AP,TYPE);
    
    %% Step 3 - compute the observation matrix
    [ h_uhat ] = measurementModel(parameters,uHat(iter,:),AP,TYPE);
    delta_rho = rho - h_uhat;
    
    %% Step 4 - compute the correction
    %% NLS
%     IHH = inv(H'*H);
%     if rcond(IHH)  <= 1e-4
%         damp_factor = 1e-4;
%         pseudoInv = inv(H'*H + damp_factor*eye(size(H'*H)))*H';
%     else
%         pseudoInv = IHH*H';
%     end
%     delta_u = pseudoInv*delta_rho';
    delta_u = pinv(H)*delta_rho';
    
%     %% WNLS
%     IHH = inv(H'*inv(Q)*H);
%     if rcond(IHH) <= 1e-6
%         damp_factor = 1e-6;
%         pseudoInv = inv(H'*inv(Q)*H + damp_factor*eye(size(H'*inv(Q)*H)))*H';
%     else
%         pseudoInv = IHH*H';
%     end
%     delta_u = pseudoInv*inv(Q)*delta_rho';
    
    %% Step 5 - update the estimate
    uHat(iter+1,:) = uHat(iter,:) + 0.5*delta_u';
    numberOfPerformedIterations = iter+1;
    
    %% stopping criterion
    if sum(delta_u.^2)<1e-6
        return
    end       
    
end

end