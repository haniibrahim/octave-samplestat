## -*- texinfo -*-
##
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}}] = grubbs(@var{v}, @var{p})
##
##"grubbs" performs a common Grubbs outlier test.
##
##@var{v} is a vector of numerical values. the number of the values should be
##greater or equal than 3 and less or equal than 600 values, @var{p} is the 
##statistical confidence level committed as a string ("95%", "99%").
##
##95%: significant outlier, 99%: high significant outlier
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier value. 
##
##@example
##@group
##data = [6 8 14 12 35 15];
##[of, o] = grubbs(data, "95%")
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
function [outlierfree, outlier] = grubbs(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%"))
    error("Second argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\"");
  endif
  n = length(v);
  if (n < 3 || n > 600)
    error("Grubbs Outliertest is just applicable for sample distributions \
      greater than 3 and lesser than 600 values."); 
  endif
  
  % Determine Q_crit
  gcritval = gcrit(n, p);
  
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