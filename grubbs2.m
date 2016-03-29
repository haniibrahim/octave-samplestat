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
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}] = grubbs2(@var{v}, @var{p})
##
##"grubbs" performs a 2-sided Grubbs outlier test. It tests the lowest and the 
##highest value.
##
##@var{v} is a vector of numerical values. the number of the values should be
##greater or equal than 3 and less or equal than 600 values, 
##@var{p} is the statistical confidence level (%) in a string or
##the level of significance (alpha) as a decimal value.
##
##@example
##@group
##conf. level   level of signif.
##------------------------------
##  "95%"             0.05
##  "99%"             0.01
##@end group
##@end example
##
##95%: significant outlier, 99%: high significant outlier
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier value.
##
##Example:
##
##@example
##@group
##data = [0.0001 6 8 14 12 35 15];
##[of, o] = grubbs(data, "95%")
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##[of, o] = grubbs(data, 0.05)
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##The committed vector "@var{data}" is checked for outliers with a probability 
##of 95%. The value 35 is a significant outlier. 
##@end group
##@end example
##@seealso{pearsonhartley(), mean(), std(), min(), max()}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function [outlierfree, outlier] = grubbs2(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || p != 0.05 || p != 0.01)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"95%\", \"99%\" or as a alpha value: 0.05, 0.01");
  endif
  n = length(v);
  if (n < 3 || n > 600)
    error("Grubbs Outliertest is just applicable for sample distributions \
      greater than 3 and lesser than 600 values."); 
  endif
  
  % Determine Q_crit
  gcritval = grubbs2_crit(n, p);
  
  % Make a vector vertical if necessary and set a flag
  if (columns(v) > 1)
    v = v';
    isvert = false;
  else
    isvert = true;
  endif
  
  x = mean(v); % mean
  sd = std(v); % standard deviation
  
  v = sort(v); % Sort vector for easy handling of the minimum and maximum values
  
  % Determine minimum and maximum Grubbs' g-value
  g_min = (x - v(1)) / sd;
  g_max = (v(n) - x) / sd;
  
  % Check if g_min or g_max are outliers
  if (g_min > gcritval)
    g_min_out = true;
  else
    g_min_out = false;
  endif
  if (g_max > gcritval)
    g_max_out = true;
  else
    g_max_out = false;
  endif
  
  % Output outlier- and outlierfree vectors
  if (g_min_out && g_max_out)
    outlierfree = v(2:n-1);
    outlier = vertcat(v(1), v(n));  
  elseif (~g_min_out && g_max_out)
    outlierfree = v(1:n-1);
    outlier = v(n); 
  elseif(g_min_out && ~g_max_out)
    outlierfree = v(2:n);
    outlier = v(1);
  elseif(~g_min_out && ~g_max_out)
    outlierfree = v;
    outlier = [];
  else
    error();
  endif
  
  return;

endfunction