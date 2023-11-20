function [h] = getPartialRegressionPlot( tbl, indepVar, depVarSet, var_x, plotColor )
% this function takes in data tbl and plots the partial correlation plot:
if nargin < 5
    plotColor = [0 0 0];
end
% generating the formula for the full model:
formula = [indepVar ' ~ 1 + '];
for depVarSetIdx = 1:numel(depVarSet)
    formula = [formula  depVarSet{depVarSetIdx} ' + ' ];
end
formula = formula(1:end-3); % --> this is eliminating the last ' + '

% generating the formula for partial Y model:
formula_y = [indepVar ' ~ 1 + '];
for depVarSetIdx = 1:numel(depVarSet)
    if ~strcmpi( depVarSet{depVarSetIdx}, var_x )  % we don't want to include the variable itself in the equation
        formula_y = [formula_y  depVarSet{depVarSetIdx} ' + ' ];
    end
end
formula_y = formula_y(1:end-3); % --> this is eliminating the last ' + '

% generating the formula for partial X model:
formula_x = [var_x ' ~ 1 + '];
for depVarSetIdx = 1:numel(depVarSet)
    if ~strcmpi( depVarSet{depVarSetIdx}, var_x )  % we don't want to include the variable itself in the equation
        formula_x = [formula_x  depVarSet{depVarSetIdx} ' + ' ];
    end
end
formula_x = formula_x(1:end-3); % --> this is eliminating the last ' + '

%%%%%%%%%%%%%%%%%% Extracting relevant information for plotting %%%%%%%%%
% First, generating the full model:
model = fitlm( tbl, formula );   % running linear model
% For plotting partial relationships one needs to plot the residuals for
% model_y and model_x:
model_y = fitlm( tbl, formula_y );   % running linear model for partial Y
model_x = fitlm( tbl, formula_x );   % running linear model for partial X
residuals_mdl_y = model_y.Residuals.Raw; %residuals(model_y);   % taking the residual of partial Y model
residuals_mdl_x = model_x.Residuals.Raw;  %residuals(model_x);   % taking the residual of partial X model
% plotting residuals of partial Y model against residuals of partial X model:
h = scatter( residuals_mdl_x, residuals_mdl_y, 'ko', 'MarkerFaceColor', plotColor, 'MarkerEdgeColor', plotColor, 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5);
xL = []; yL = [];
xL= xlim;
yL= ylim;
% only plot best-fit line if relationship is significant.
pVAL = model.Coefficients.pValue( strcmpi(model.CoefficientNames(:), var_x) == 1);
if pVAL < 0.05
   p = lsline;
   set(p,'color','r');
end
xlabel( ['Adjusted ' var_x ' (residualized)'] )
ylabel( ['Adjusted ' indepVar ' (residualized)'] )

str = ['p = ' num2str(pVAL,3)];

text(xL(1)+(0.1*range(xL)),yL(1)+(0.1*range(yL)),str)
% % plotting residuals of partial Y model against X (semi-partial):
% subplot( 1,2,2)
% plotAdjustedResponse( model ,var_x)









