## -*- texinfo -*-
##
##@deftypefn {Function File} [@var{outlierfree}, @var{outlier}] = dixon(@var{v}, @var{p})
##
##"dixon" performs a revisited Dixon outlier test refered to
##Rorabacher, David B. (1991): "Statistical Treatment for Rejection of Deviant 
##Values: Critical Values of Dixon's Q Parameter and Related Subrange Ratios 
##at the 95% Confidence Level." Analytical Chemistry 63, no. 2 (1991): 139-146.
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier value. 
##
##@var{n} is the number of values in the sample distribution, committed as an
##integer. @var{p} is the statistical confidence level (%) in a string or
##the level of significance (alpha) as a decimal value.
##
##@example
##@group
##conf. level   level of signif.
##------------------------------
##  "90%"             0.1
##  "95%"             0.05
##  "99%"             0.01
##@end group
##@end example
##
##
##@var{n} has to be between: 3 <= @var{n} <= 30. @var{p} is "90%" (0.1), "95%" 
##(0.05) or "99%" (0.01).
##
##Example:
##
##@example
##@group
##data = [6 8 14 12 35 15];
##[of, o] = deandixon(data, "95%")
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##[of, o] = deandixon(data, 0.05)
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##In the committed vector @var{data} which contains less than 30 values is 
##checked for outliers with a confidence level of 95%. The value 35 is a significant 
##outlier. 
##@end group
##@end example
##@seealso{}
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0

function [outlierfree, outlier] = dixon(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"90%") || strcmp(p,"95%") || strcmp(p,"99%") || p != 0.1 || ...
        p != 0.05 || p != 0.01)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"90%\", \"95%\" or \"99%\" or as alpha value: 0.1, 0.05, 0.01");
  endif
  n = length(v);
  if (n < 3 || n > 30)
    error("Dean-Dixon Outliertest is just applicable for sample distributions \
greater than 3 and lesser than 30 values. For more than 30 values use \
Pearson-Hartley test 'pearsonhartley()' instead."); 
  endif
  
  % Determine Q_crit
  qcritval = dixon_crit(n, p);
 
  % Calculate Q for the smallest value
  vasc = sort(v);
  qsmall = abs(vasc(2)-vasc(1))/abs(vasc(n)-vasc(1));
  
  % Calculate Q for the biggest value
  vdes = sort(v, "descend");
  qbig = abs(vdes(2)-vdes(1))/abs(vdes(n)-vdes(1));
  
  % Compare Q with Qcrit
  if qsmall > qcritval
    osmall = true;
  else
    osmall = false;
  endif
  
  if qbig > qcritval
    obig = true;
  else
    obig = false;
  endif
  
  % Output
  if osmall && obig
    outlierfree = vasc(2:n-1);
    outlier = vertcat(vasc(1):vasc(n));
  elseif osmall && ~obig
    outlierfree = vasc(2:n);
    outlier = vasc(1);
  elseif ~osmall && obig
    outlierfree = vasc(1:n-1);
    outlier = vasc(n);
  else
    outlierfree = vasc;
    outlier = []; % empty vector
  endif
  return;
endfunction