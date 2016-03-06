## -*- texinfo -*-
##
##@deftypefn {Function File} @var{retval} = strayarea(@var{v}, @var{p})
##
##"strayarea" @var{retval} is the range of dispersion of the values and is 
##calculated as s * t. (t = student factor, dependent on the confidence level P% =
##95%, 99% or 99.9% and the degree of freedom f = n - 1. f and t are specified 
##in the t-table. s = standard deviation). 
##
##The strayarea @var{retval} indicates that P% of all single values are expected
##around mean + @var{retval} and mean - @var{retval}. the strayarea is the 
##parameter which specify the quality of the raw values.
##
##@var{v} is a vector of numerical values, @var{p} is the statistical confidence
##level committed as a string ("95%", "99%" or "99.9%").
##
##@example
##@group
##V = [6 8 14 12 5 15];
##mean(V)
##@result{} 10.
##strayarea(V, "95%")
##@result{} 10.904
##
##In the given vector "@var{v}" 95% of all values will stray about 10.9 around
##the arithmetic mean of 10 => 0 and 20.9
##@end group
##@end example
##@seealso{trustarea(), studentfactor(), mean(), std(), min(), max()}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function retval = strayarea(v, p)

  % Check arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%"))
    error("Second argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\" or \"99.9%\"");
  endif
  
  % Number of values
  n = length(v);

  if studentfactor(n, p) < 0
    retval = -1.0;
    return;
  endif
  
  retval = std(v) * studentfactor(n, p);
  return; 

endfunction