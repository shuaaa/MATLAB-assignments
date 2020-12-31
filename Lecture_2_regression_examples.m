%% 
clc
clear all
data=xlsread('data_ex_1_2_linreg.xlsx','exdata','A3:L10002');
[n,m]=size(data);
x1=data(:,1); %loading data
y1=data(:,2);

x2=data(:,3);
y2=data(:,4);

x3=data(:,5);
y3=data(:,6);

x4=data(:,7);
y4=data(:,8);

x5=data(:,9);
y5=data(:,10);

x6=data(:,11);
y6=data(:,12);
%% 
%now let us do regression analysis using the linear model class in matlab: http://se.mathworks.com/help/stats/linearmodel-class.html
x=x5;
y=y5;

%plotting the data (whole population of 10000) to see how the relationship may look like
%scatter(x,y)

%let us also consider a subsample of the data (much smaller) - only "obs"
%observations
obs=300;
x_short=x(1:obs,:);
y_short=y(1:obs,:);

%plotting the data (sample of first 300) to see how the relationship may look like
scatter(x_short,y_short)

md1=fitlm(x,y) %this fits a linear regression model and estimates its parameters, provides p-values for the estimations, R-squared values and so on
md1_short=fitlm(x_short,y_short)
%% WHY YOU SHOULD PLOT THE DATA
data_ploting=xlsread('Lecture_2_regression_PLOT_THE_DATA.xlsx','List1','A3:H13');
dp1x=data_ploting(:,1);
dp1y=data_ploting(:,2);
dp2x=data_ploting(:,3);
dp2y=data_ploting(:,4);
dp3x=data_ploting(:,5);
dp3y=data_ploting(:,6);
dp4x=data_ploting(:,7);
dp4y=data_ploting(:,8);
disp('means:')
[mean(dp1x) mean(dp2x) mean(dp3x) mean(dp4x); mean(dp1y) mean(dp2y) mean(dp3y) mean(dp4y)]
disp('variances:')
[var(dp1x) var(dp2x) var(dp3x) var(dp4x); var(dp1y) var(dp2y) var(dp3y) var(dp4y)]

mdp1=fitlm(dp1x,dp1y)
mdp2=fitlm(dp2x,dp2y)
mdp3=fitlm(dp3x,dp3y)
mdp4=fitlm(dp4x,dp4y)

%note how close the results of the lin. reg. are... and yet:
subplot(4,1,1)
scatter(dp1x,dp1y)
subplot(4,1,2)
scatter(dp2x,dp2y)
subplot(4,1,3)
scatter(dp3x,dp3y)
subplot(4,1,4)
scatter(dp4x,dp4y)


%% HOW DO WE GET TO THE COEFFICIENTS/RESULTS? http://se.mathworks.com/help/stats/linearmodel-class.html
outputs = md1_short.Coefficients %returns the outputs of the model - coefficient estimates, their SEs, t-values and p-values
beta = md1_short.Coefficients.Estimate %returns the coefficient estimates as a vector
SE = md1_short.Coefficients.SE %returns the SEs for the coefficient estimates as a vector
tvalues = md1_short.Coefficients.tStat %returns the t-values for the coefficient estimates as a vector
pvalues = md1_short.Coefficients.pValue %returns the p-values for the coefficient estimates as a vector
degrees_of_freedom=md1_short.DFE %Degrees of freedom for error (residuals), equal to the number of observations minus the number of estimated coefficients.

%also SUMS OF SQUARES
RSS=md1_short.SSE %Sum of squared errors (residuals)
md1_short.SSR %Regression sum of squares, the sum of squared deviations of the fitted values from their mean.
md1_short.SST %Total sum of squares, the sum of squared deviations of y from mean(y). SST = SSE + SSR.

%R SQUARED characteristics: Proportion of total sum of squares explained by
%the model. The ordinary R-squared value relates to the SSR and SST properties: Rsquared = SSR/SST = 1 - SSE/SST.
R2= md1_short.Rsquared.Ordinary %Ordinary (unadjusted) R-squared
R2bar= md1_short.Rsquared.Adjusted %R-squared adjusted for the number of coefficients

%INFORMATION CRITERIA: (relevant in model specification tasks - see ARMA models, Box-Jenkins methodology)
%aic = md1.ModelCriterion.AIC %AIC � Akaike information criterion
%aicc = md1.ModelCriterion.AICc %AICc � Akaike information criterion corrected for sample size
%bic = md1.ModelCriterion.BIC %BIC � Bayesian information criterion
%caic = md1.ModelCriterion.CAIC %CAIC � Consistent Akaike information criterion

%VALUES FITTED BY THE MODEL and PREDICTIONS
fitted=md1_short.Fitted; %a vector of values y_cap (values fitted by the model)
predict(md1_short,x(obs:2*obs,:)); %predict the values for x based on the model
CHECK=predict(md1_short,x_short)==fitted; %prediction for the values of x on which the model was based should be equal to the fitted values of y


%RESIDUALS for the population (10000 observations) - normally distributed?
residuals=md1.Residuals.Raw; %Observed minus fitted values.
residuals_stand=md1.Residuals.Standardized; %Raw residuals divided by their estimated standard deviation. 

histogram(residuals)
hold on
histogram(residuals_stand) %black
hold off

%% RESIDUALS for the sample ("obs" observations) - normally distributed?
residuals_short=md1_short.Residuals.Raw; %Observed minus fitted values.
residuals_stand_short=md1_short.Residuals.Standardized; %Raw residuals divided by their estimated standard deviation. 

histogram(residuals_short)
hold on
histogram(residuals_stand_short)
hold off
%%
%NOTE, that switching the values (dependent and independent) changes the
%results - thus it is not as symmetrical as correlation:

% md2=fitlm(y,x)
%display(corrcoef(x,y),'correlation between x and y') %correlation matrix for x and y
%display(corrcoef(y,x),'correlation between x and y') %correlation matrix for y and x


%% model can also be specified using 
% 'constant'	Model contains only a constant (intercept) term.
% 'linear'	Model contains an intercept and linear terms for each predictor.
% 'interactions'	Model contains an intercept, linear terms, and all products of pairs of distinct predictors (no squared terms).
% 'purequadratic'	Model contains an intercept, linear terms, and squared terms.
% 'quadratic'	Model contains an intercept, linear terms, interactions, and squared terms.
% 'polyijk'	Model is a polynomial with all terms up to degree i in the first predictor, degree j in the second predictor, etc. Use numerals 0 through 9. For example, 'poly2111' has a constant plus all linear and product terms, and also contains terms with predictor 1 squared.
% or using a terms matrix T (for multivariate regression) % e.g. T = [0 0 0
% 0;1 0 0 0;0 0 1 0;0 0 0 1] - each row represents the multiplication used to obtain one regressor in the
% model, each column then represents the power of the independent variable that is used - 0 0 0 0 is a constant term, 0 1 0 1 means x_2*x_4, 0 0 2 0 means x_3^2 

% md2 = fitlm(x,y,'constant')
% or
% md2 = fitlm(x,y,'linear')
% or
% md2 = fitlm(x,y,'interactions')
% or
% md2 = fitlm(x,y,'purequadratic')
% or
% md2 = fitlm(x,y,'quadratic')
% or
md2 = fitlm(x,y,'poly6')
%or
%T=[0;2;3;5] %represents a + bx^2 + cx^3 + dx^5
%md2 = fitlm(x,y,T)



%mdl1 = addTerms(mdl,terms) can also be used to ADD additional terms into the model.
% Input Arguments:
% mdl ... Linear model, as constructed by fitlm or stepwiselm.
% terms ... Terms to add to the mdl regression model. Specify as either a: Text string representing one or more terms to add. For details, see Wilkinson Notation. 
% Row or rows in the terms matrix (see modelspec in fitlm). For example, if there are three variables A, B, and C:
% 
%     [0 0 0] represents a constant term or intercept
%     [0 1 0] represents B; equivalently, A^0 * B^1 * C^0
%     [1 0 1] represents A*C
%     [2 0 0] represents A^2
%     [0 1 2] represents B*(C^2)

plot(md2)%plots the fitted model
disp(md2) %displays the model (in text form) also just calling the model structure name "md2" at the command line would do the same
%% DIAGNOSTICS of the model using plots http://se.mathworks.com/help/stats/linearmodel.plotdiagnostics.html
%model diagnostics using graphical representation (for md1)
plotDiagnostics(md1_short) %a leverage plot of the data and model - we are looking for data with high leverage. 
%But this plot does not reveal whether the high-leverage points are
%outliers. - we can look for point with high Cook distance and remove them

%Look for points with large Cook's distance.
%% Cooks distance
plotDiagnostics(md1_short,'cookd') % If there are data instances with high cook distance, we may want to identify it and remove it from the model. You can use the Data Cursor (Tools - Data cursor) to click the outlier and identify it.
%% Examining the RESIDUALS graphically http://se.mathworks.com/help/stats/linearmodel.plotresiduals.html
plotResiduals(md1_short) %histogram of residuals - is it symmetric? close to normal? - there might be potential outliers in the data - consider the discontinuity on the right side
%% probability plot of residuals
plotResiduals(md1_short,'probability') %again if there seem to be points too far from the probability line, these may be outliers
%% lagged residuals plot
plotResiduals(md1_short,'lagged') %if the distribution of crosses among the 4 quadrants is uneven, there might be a positive or negative serial correlation among the residuals.
%% plot of residuals vs. fitted values
plotResiduals(md1_short,'fitted') %if the residuals seem to grow od decrease wit the fitted value, there might be a proportionality of the errors to the fitted values; (not this case)

%% MODEL DIAGNOSTICS 
%coefficient tests; see more http://se.mathworks.com/help/stats/linearmodel.coeftest.html
p = coefTest(md1)
%[p,F,r]=coefTest(md1,[0 1],3) %tests H0 that the second coefficient is equal
%to 3
[p,F,r]=coefTest(md1,[0 1],1) %tests H0 that the second coefficient is equal
%to 1

%confidence intervals for model parameters
ci = coefCI(md1,0.05)



%% HOW IS IT WITH THE DISTRIBUTIONS RELEVANT FOR HYPOTHESES TESTING???
%let us consider x to be the population and a "obs" long sample is taken
%from this population and the coefficients in the linear regression are
%estimated. What is the probability distribution of the test statistics for
%H_0: intercept = 5?

% data_test=[x,y];
% alpha_test_stat=zeros(100000,1);
% for i=1:100000
% data_sample= datasample(data_test,obs,'Replace',false);
% x_test=data_sample(:,1);
% y_test=data_sample(:,2);
% md_test=fitlm(x_test,y_test);
% alpha_test_stat(i,1)=(md_test.Coefficients.Estimate(1)-5)/md_test.Coefficients.SE(1);
% end
% histogram(alpha_test_stat)


