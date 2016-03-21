## -*- texinfo -*-
##
##@deftypefn {Function File} {[@var{outlierfree}, @var{outlier}}] =} deandixon(@var{v}, @var{p})
##
##"deandixon" performs a Dean-Dixon outliertest based on R.B. Dean, W.J. Dixon,
##"Simplified statistics for small numbers of observations", Anal.Chem. 23 
##(1951) 636-638.
##
##@var{v} is a vector of numerical values. the number of the values should be
##greater or equal than 3 and less or equal than 30 values, @var{p} is the 
##statistical confidence level committed as a string ("95%", "99%" or "99.9%").
##
##95%: significant outlier, 99%: high significant outlier, 99.9%: highly 
##significant outlier
##
##@var{outlierfree} contains a vector of outlier-free values, @var{outlier}
##contains the outlier value. 
##
##EXAMPLE
##@example
##@group
##data = [6 8 14 12 35 15];
##[of, o] = deandixon(data, "95%")
##@result{} of =  6    8   12   14   15
##@result{} o =  35
##
##In the committed vector @var{data} which contains less than 30 values is 
##checked for outliers with a probability of 95%. The value 35 is a significant 
##outlier. 
##@end group
##@end example
##@seealso{pearsonhartley(), grubbs(), grubbs2(), nalimov()}
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0

function [outlierfree, outlier] = deandixon(v, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%"))
    error("Second argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\" or \"99.9%\"");
  endif
  n = length(v);
  if (n < 3 || n > 30)
    error("Dean-Dixon Outliertest is just applicable for sample distributions \
greater than 3 and lesser than 30 values. For more than 30 values use \
Pearson-Hartley test instead."); 
  endif
  
  % Determine Q_crit
  qcritval = qcrit_dd(n, p);
 
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