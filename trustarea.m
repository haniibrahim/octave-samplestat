## -*- texinfo -*-
##
##@deftypefn {Function File} @var{retval} = trustarea(@var{v}, @var{n}, @var{p})
##
##"trustarea" @var{retval} is the range of dispersion of the mean. This 
##parameter tells how secure the mean is. It indicates the stray area of the 
##mean and not of the raw values as the stray area does.
##
##The trust area @var{retval} indicates that the mean of the values in vector 
##@var{v} strays around +/-@var{retval} with the specified probability.
##
##@var{v} is a vector of numerical values, @var{n} is the number of values of @var{v}.
##@var{p} is the statistical confidence level committed as a string ("95%", 
##"99%" or "99.9%").
##
##@example
##@group
##V = [6 8 14 12 5 15];
##mean(V)
##@result{} 10.
##trustarea(V, length(V), "95%")
##@result{} 4.4514
##
##With a probability of 95% the arithmetic mean of 10 will stray 
##around 4.5 => 10 +/- 4.5
##@end group
##@end example
##@seealso{strayarea(), studentfactor(), mean(), std(), min(), max()}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function retval = trustarea(v, n, p)
  % Check arguments
  if (nargin == 0 || nargin > 3); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if (~isnumeric(n) || (n-floor(n) != 0)) ; error("Second argument is the number of values and has to be an integer"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%"))
    error("Third argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\" or \"99.9%\"");
  endif
  if (strayarea(v,n,p) < 0)
    retval = -1.0;
  else
   retval = strayarea(v,n,p)/sqrt(n);
  endif
  return;
endfunction