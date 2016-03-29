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
##@deftypefn {Function File} @var{critval} = grubbs2_crit(@var{n}, @var{p})
##
##Servicefunction for grubbs2().
##Returns the critical G value (@var{critval}) for the 2-sided Grubbs outlier test. 
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
##In the 2-sided Grubbs outlier test you compare @var{critval} with a calculated 
##G value.
##
##@var{n} has to be between: 3 <= @var{n} <= 600. @var{p} is "95%, "99%" or 0.05,
##0.01.
##
##Example:
##
##@example
##@group
##V = [0.1 6 8 14 12 5 15];
##grubbs2_crit(length(V), "95%")
##@result{} 3.5373
##
##grubbs2_crit(length(V), 0.05)
##@result{} 3.5373
##
##The G_crit value (@var{critval}) of @var{n}=7 and @var{p}="95%" (0.05) is 3.5373.
##@end group
##@end example
##
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0
function [critval] = grubbs2_crit(n, p)
  % Checking arguments3	1.1531	1.1546

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
  % Column 2 : G_crit, 95% confidence level, alpha = 0.05
  % Column 3 : G_crit, 99% confidence level, alpha =0.01
  gtable = [ ...
    3	1.1531	1.1546; ...
    4	1.4625	1.4925; ...
    5	1.6714	1.7489; ...
    6	1.8221	1.9442; ...
    7	1.9381	2.0973; ...
    8	2.0317	2.2208; ...
    9	2.1096	2.3231; ...
    10	2.1761	2.4097; ...
    11	2.2339	2.4843; ...
    12	2.2850	2.5494; ...
    13	2.3305	2.6070; ...
    14	2.3717	2.6585; ...
    15	2.4090	2.7049; ...
    16	2.4433	2.7470; ...
    17	2.4748	2.7854; ...
    18	2.5040	2.8208; ...
    19	2.5312	2.8535; ...
    20	2.5566	2.8838; ...
    25	2.6629	3.0086; ...
    30	2.7451	3.1029; ...
    40	2.8675	3.2395; ...
    50	2.9570	3.3366; ...
    60	3.0269	3.4111; ...
    70	3.0839	3.4710; ...
    80	3.1319	3.5208; ...
    90	3.1733	3.5632; ...
    100	3.2095	3.6002; ...
    120	3.2706	3.6619; ...
    140	3.3208	3.7121; ...
    160	3.3633	3.7542; ...
    180	3.4001	3.7904; ...
    200	3.4324	3.8220; ...
    300	3.5525	3.9385; ...
    400	3.6339	4.0166; ...
    500	3.6952	4.0749; ...
    600	3.7442	4.1214 ...
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