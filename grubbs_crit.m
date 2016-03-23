## -*- texinfo -*-
##
##@deftypefn {Function File} @var{critval} = grubbs_crit(@var{n}, @var{p})
##
##Servicefunction for grubbs().
##Returns the critical G value (@var{critval}) for the Grubbs outlier test.
## 
##(@var{n}) is the numbers of values. 
##@var{p} is the statistical confidence level (%) in a string or
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
##In the Grubbs outlier test you compare @var{critval} with a calculated 
##G value.
##
##@var{n} has to be between: 3 <= @var{n} <= 600. @var{p} is "95%, "99%" or 0.05,
##0.01.
##
##Example:
##
##@example
##@group
##V = [6 8 14 12 5 15];
##grubbs_crit(length(V), "95%")
##@result{} 1.8871
##
##grubbs_crit(length(V), 0.05)
##@result{} 1.8871
##
##The G_crit value (@var{critval}) of @var{n}=6 and @var{p}="95%" (0.05) is 1.8871.
##@end group
##@end example
##
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0
function [critval] = grubbs_crit(n, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(n) || (n-floor(n) != 0)); error("First argument has to be a integer\n"); endif
  if (n <3 || n>600); error("First value has to be greater or equal 3 and less or equal 600"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || p != 0.05 || p != 0.01)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"95%\", \"99%\" or as a alpha value: 0.05, 0.01");
  endif

  % gtable contains the critical values critval for N (number of values)
  % and alpha (niveau of significance)  
  % Column 1 : Number of values (N)
  % Column 2 : G_crit, 95% confidence level
  % Column 3 : G_crit, 99% confidence level
  gtable = [ ...
    3	  1.1543	1.1547; ...
    4	  1.4812	1.4962; ...
    5	  1.7150	1.7637; ...
    6	  1.8871	1.9728; ...
    7	  2.0200	2.1391; ...
    8	  2.1266	2.2744; ...
    9	  2.2150	2.3868; ...
    10	2.2900	2.4821; ...
    11	2.3547	2.5641; ...
    12	2.4116	2.6357; ...
    13	2.4620	2.6990; ...
    14	2.5073	2.7554; ...
    15	2.5483	2.8061; ...
    16	2.5857	2.8521; ...
    17	2.6200	2.8940; ...
    18	2.6516	2.9325; ...
    19	2.6809	2.9680; ...
    20	2.7082	3.0008; ...
    25	2.8217	3.1353; ...
    30	2.9085	3.2361; ...
    40	3.0361	3.3807; ...
    50	3.1282	3.4825; ...
    60	3.1997	3.5599; ...
    70	3.2576	3.6217; ...
    80	3.3061	3.6729; ...
    90	3.3477	3.7163; ...
    100	3.3841	3.7540; ...
    120	3.4451	3.8167; ...
    140	3.4951	3.8673; ...
    160	3.5373	3.9097; ...
    180	3.5736	3.9460; ...
    200	3.6055	3.9777; ...
    300	3.7236	4.0935; ...
    400	3.8032	4.1707; ...
    500	3.8631	4.2283; ...
    600	3.9109	4.2740 ...
	];
  
  % Set the proper column of the gtable, depending on confidence level
  switch(p)
    case("95%")
      j = 2;
    case("99%")
      j = 3;
    case(0.05)
      j = 2;
    case(0.01)
      j = 3;
    otherwise
      error();
  endswitch
  
  % Pick the appropriate G_crit value, interpolate if necessary
  if (n >= 3 && n <= 20)
    critval = gtable(n-2,j);
  elseif (n >= 21  && n <= 30)
    i = 14 + floor(n/5); % Determine row, 14=correction factor
    qs = (gtable(i+1,j) - gtable(i,j))/5;
    mul = n - gtable(i,1); % Multiplicator for qs
    critval = gtable(i,j) + (mul * qs);
  elseif (n >= 31 && n<=100)
    i = 17 + floor(n/10);
    qs = (gtable(i+1,j) - gtable(i,j))/10;
    mul = n - gtable(i,1); % Multiplicator for qs
    critval = gtable(i,j) + (mul * qs);
  elseif (n >= 101 && n<=200)
    i = 22 + floor(n/20);
    qs = (gtable(i+1,j) - gtable(i,j))/20;
    mul = n - gtable(i,1); % Multiplicator for qs
    critval = gtable(i,j) + (mul * qs);
  elseif (n >= 201 && n<=599)
    i = 30 + floor(n/100);
    qs = (gtable(i+1,j) - gtable(i,j))/100;
    mul = n - gtable(i,1); % Multiplicator for qs
    critval = gtable(i,j) + (mul * qs); 
  else % for the last value (600)
    i = 30 + floor(n/100); % Determine row, 6=correction factor
    critval = gtable(i,j);
  endif
  return;
endfunction