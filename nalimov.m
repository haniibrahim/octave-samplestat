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
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}] = nalimov(@var{n}, @var{p})
##
##"nalimov()" performs a Nalimov outlier test. IMPORTANT: Do use nalimov() with
##care. It indicates outliers very strict and is controversial discussed.
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier values. 
##
##@var{v} is a vector of numerical values. The number of the values should be
##greater or equal than 3 and less or equal than 1000 values.  
##@var{p} is the statistical confidence level (%) as a string or
##the level of significance (alpha) as a decimal value.
##
##@example
##@group
##conf. level   level of signif.
##------------------------------
##  "95%"             0.05
##  "99%"             0.01
##  "99.9%"           0.001
##@end group
##@end example
##
##Example:
##
##@example
##@group
##data = [6 8 14 12 35 15];
##[of, o] = nalimov(data, "95%")
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##[of, o] = nalimov(data, 0.05)
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##The committed vector "@var{data}" is checked for outliers with a confidence 
##of 95%. The value 35 is a significant outlier. 
##@end group
##@end example
##
##@seealso{deandixon(), dixon(), grubbs(), pearsonhartley(), shapirowilk()}
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0

function [outlierfree, outlier] = nalimov(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%") || p != 0.05 || ...
        p != 0.01 || p != 0.001)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"95%\", \"99%\" or \"99.9%\" or as alpha value: 0.05, 0.01, 0.001");
  endif
  n = length(v);
  if (n < 3 || n > 600)
    error("Grubbs Outliertest is just applicable for sample distributions \
      greater than 3 and lesser than 1000 values."); 
  endif
  
  % Determine Q_crit
  qcritval = nalimov_crit(n, p);

  x = mean(v); % mean
  sd = std(v); % standard deviation
  
  outlier = [];
  outlierfree = [];
  
  for i=1:n
    q = abs(v(i)-x)/sd * sqrt(n/(n-1));
    if (q > qcritval)
      outlier = vertcat(outlier, v(i));
    else
      outlierfree = vertcat(outlierfree, v(i));
    endif
  endfor
  
  return;

endfunction