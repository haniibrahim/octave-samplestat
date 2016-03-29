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
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}] = pearsonhartley(@var{v}, @var{p})
##
##"pearsonhartley()" determine the significance thresholds of Pearson-Hartley
##applied to a distributon of more than 30 values. It is used as an outlier test.
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier value.
##
##@var{v} is a vector of numerical values. The number of the values should be 
##greater than 30. 
####@var{p} is the statistical confidence level (%) in a string or
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
##@example
##@group
##[of, o] = pearsonhartley(data, "95%")
##
##@end group
##@end example
##@seealso{deandixon(), dixon(), grubbs(), grubbs2(), nalimov(), shapirowilk()}
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0

function [outlierfree, outlier] = pearsonhartley(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%"))
    error("Second argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\"");
  endif
  n = length(v);
  if (n < 30 || n > 1000)
    error("Pearson-Hartley is just applicable for sample \
distributions greater than 30 and less than 1000 values. Use the Dean-Dixon \
outlier test \"deandixon()\" or better the newer Dixon test \"dixon()\" for less \
than 30 samples\n"); 
   endif
  
  % Determine Q_crit
  qcritval = pearsonhartley_crit(n, p);
  
  S = std(v);
  X = mean(v);
  j = 1; % index variable for outlier vector
  k = 1; % index variable for outlier-free vector
  outlier = [];
  outlierfree = [];
  
  for i=1:n
    q = abs((v(i)-X)/S);
    if (q > qcritval)
      outlier(j) = v(i);
      j = j + 1;
      break;
    endif
    outlierfree(k) = v(i);
    k = k + 1;
  endfor
  
  % make vertical vectors
  outlierfree = outlierfree';
  outlier = outlier';
  
  return;
  
endfunction