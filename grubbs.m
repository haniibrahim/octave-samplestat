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
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}] = grubbs(@var{v}, @var{p})
##
##"grubbs()" performs a Grubbs outlier test (2-sided).
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier value. 
##
##@var{v} is a vector of numerical values. The number of the values should be
##greater or equal than 3 and less or equal than 600 values. 
##@var{p} is the statistical confidence level (%) as a string or
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
##Example:
##
##@example
##@group
##data = [6 8 14 12 35 15];
##[of, o] = grubbs(data, "95%")
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##[of, o] = grubbs(data, 0.05)
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##The committed vector "@var{data}" is checked for outliers with a confidence 
##of 95%. The value 35 is a significant outlier. 
##@end group
##@end example
##
##Based on F. Grubbs,	"Procedures for Detecting Outlying Observations in Samples",
##Technometrics, Vol. 11 (1969) 1-21. 
##@seealso{deandixon(), dixon(), pearsonhartley(), nalimov(), shapirowilk()}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function [outlierfree, outlier] = grubbs(v, p)
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
  gcritval = grubbs_crit(n, p);
  
  % Make a vector vertical if necessary and set a flag
  if (columns(v) > 1)
    v = v';
    isvert = false;
  else
    isvert = true;
  endif
  
  x = mean(v); % mean
  sd = std(v); % standard deviation
  
  % Max. value of the difference to the S.D. |v(i)-sd|
  for i=1:n
    m(i) = abs(v(i) - x);
  endfor
  [maximum, idx] = max(m);
  
  g = maximum / sd; % determine g-value
  
  if (g > gcritval)
    outlier = v(idx);
  else
    outlier = [];
    idx = 0; % flag for no outlier 
  endif
  
  if (idx == 1) % outlier is the first value
    outlierfree = v(2:n);
  elseif (idx == n) % outlier is the last value
    outlierfree = v(1:n-1);
  elseif (idx  == 0) % no outlier
    outlierfree = v;
  else % outlier somewhere in the vector exept the first, the last
    of1 = v(1:idx-1);
    of2 = v(idx+1:n);
    of = vertcat(of1, of2);
    if (~isvert) % Make vector horizonal when it was committed horizontally
      outlierfree = of';
    else
      outlierfree = of;
    endif
  endif
  
  return;

endfunction