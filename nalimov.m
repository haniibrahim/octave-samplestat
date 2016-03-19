## -*- texinfo -*-
##
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}] = nalimov(@var{n}, @var{p})
##
##"nalimov" performs a Nalimov outlier test.
##
##@var{v} is a vector of numerical values. the number of the values should be
##greater or equal than 3 and less or equal than 1000 values, @var{p} is the 
##statistical confidence level committed as a string ("95%", "99%", "99.9%").
##
##95%: significant outlier, 99%: high significant outlier, 99.9%: highly 
##significant outlier
##
##@example
##@group
##
##@end group
##@end example
##
##@seealso{}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function [outlierfree, outlier] = nalimov(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%"))
    error("Second argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\", \"99.9\"");
  endif
  n = length(v);
  if (n < 3 || n > 600)
    error("Grubbs Outliertest is just applicable for sample distributions \
      greater than 3 and lesser than 1000 values."); 
  endif
  
  % Determine Q_crit
  qcritval = qcrit_na(n, p);

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