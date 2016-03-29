## Copyright (C) 2016 Hani Andreas Ibrahim
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
##
##@deftypefn {Function File} @var{normal} = shapirowilk(@var{v}, @var{p})
##
##Servicefunction for shapirowilk().
##Returns the critical W_alpha value (@var{critval}) for the Shapiro-Wilk test
##for normal distribution.
##
##@var{n} is the numbers of values. 
##@var{p} is the statistical confidence level (%) in a string or
##the level of significance (alpha) as a decimal value.
##
##@example
##@group
##conf. level   level of signif.
##------------------------------
##  "90%"             0.10
##  "95%"             0.05
##  "99%"             0.01
##@end group
##@end example
##
##
##@var{v} has to contain >= 3 or <= 50 values. @var{p} is "90%", "95%, "99%" or
##0.10, 0.05, 0.01.
##
##Example:
##
##@example
##@group
##V = [6 8 14 12 5 15];
##shapirowilk(V, "95%")
##@result{} 1
##
##shapirowilk(V, 0.05)
##@result{} 1
##
##The sample distribution V is normally distributed with a confidence of 95%.
##@end group
##@end example
##
##Based on Shapiro, Wilk: "An Analysis of Variance Test for Normality", 
##Biometrika, Vol. 52, No. 3/4. (Dec., 1965), pp. 591-611.
##
##@end deftypefn

function [normal] = shapirowilk(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"90%") || strcmp(p,"95%") || strcmp(p,"99%") || p != 0.10 || p != 0.05 || p != 0.01)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"90%\", \"95%\", \"99%\" or as a alpha value: 0.10, 0.05, 0.01");
  endif
  n = length(v);
  if (n < 3 || n > 50)
    error("Shapiro-Wilk normal distribution test is just applicable for sample distributions \
greater than 3 and lesser than 50 values."); 
  endif
  
  % sort data ascendingly
  v = sort(v);
  
  % Calc. mean
  x = mean(v);
  
  % Calculate S^2 = SUM ( x_i - mean)^2
  s2 =0;
  for i=1:n
    s2 = s2 + (v(i) - x)^2;
  endfor
  
  % Calulate b for even or odd n
  b = 0;
  if ~rem(n,2)
    % Calculate for even-n => b = SUM a_n-i+1 (v_n-i+1 - v_i) from i=1 to i=n/2
    for i=1:(n/2)
      b = b + shapirowilk_a(i,n) * (v(n-i+1) - v(i));
    endfor
  else
    % Calculate for odd-n => b = SUM a_n-i+1 (v_n-i+1 - v_i) from i=1 to i=(n-1)/2
    for i=1:((n-1)/2)
      b = b + shapirowilk_a(i,n) * (v(n-i+1) - v(i));
    endfor 
  endif
  
  % Calculate W = b^2/S^2
  W = b^2/s2;
  
  % Compare W with W_alpha, 
  % if W is greater the W_alpha the distribution is normally distributed
  if W > shapirowilk_crit(n, p)
    normal = true;
  else
    normal = false;
  endif
  
  return;
  
endfunction