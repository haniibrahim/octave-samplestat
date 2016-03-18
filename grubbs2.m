## -*- texinfo -*-
##
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}}] = grubbs2(@var{v}, @var{p})
##
##"grubbs" performs a 2-sided Grubbs outlier test. It tests the lowest and the 
##highest value.
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
##data = [0.0001 6 8 14 12 35 15];
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
function [outlierfree, outlier] = grubbs2(v, p)
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
  gcritval = gcrit2(n, p);
  
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