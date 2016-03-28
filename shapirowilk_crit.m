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
##@deftypefn {Function File} @var{critval} = shapirowilk_crit(@var{n}, @var{p})
##
##Servicefunction for shapirowilk().
##Returns the critical W_alpha value (@var{critval}) for the Shapiro-Wilk test
##for normal distribution.
##
##@var{n} is the numbers of values. 
##@var{p} is the statistical confidence level (%) in a string or
##the level of significance (alpha) as a decimal value.
##
##@example
##@group
##conf. level   level of signif.
##------------------------------
##  "90%"             0.10
##  "95%"             0.05
##  "99%"             0.01
##@end group
##@end example
##
##In the Grubbs outlier test you compare @var{critval} with a calculated 
##G value.
##
##@var{n} has to be between: 3 <= @var{n} <= 600. @var{p} is "90%", "95%, "99%", 
##0.10, 0.05 or 0.01.
##
##Example:
##
##@example
##@group
##V = [6 8 14 12 5 15];
##shapirowilk_crit(length(V), "95%")
##@result{} 0.788
##
##shapirowilk_crit(length(V), 0.05)
##@result{} 0.788
##
##The (@var{critval}) of @var{n}=6 and @var{p}="95%" (0.05) is 1.8871.
##@end group
##@end example
##
##Based on Shapiro, Wilk: "An Analysis of Variance Test for Normality", 
##Biometrika, Vol. 52, No. 3/4. (Dec., 1965), pp. 591-611.
##
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0
function [critval] = shapirowilk_crit(n, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(n) || (n-floor(n) != 0)); error("First argument has to be a integer\n"); endif
  if (n < 5 || n > 50); error("First value has to be greater or equal 5 and less or equal 50"); endif
  if ~(strcmp(p,"90%") || strcmp(p,"95%") || strcmp(p,"99%") || p != 0.10 || p != 0.05 || p != 0.01)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"90%\", \"95%\", \"99%\" or as a alpha value: 0.10, 0.05, 0.01");
  endif

  % watable contains the critical values critval for N (number of values)
  % and alpha (niveau of significance)  
  % Column 1 : Number of values (N)
  % Column 2 : W_alpha_crit, 90% confidence level, alpha = 0.10
  % Column 3 : W_alpha_crit, 95% confidence level, alpha = 0.05
  % Column 4 : W_alpha_crit, 99% confidence level, alpha = 0.01
  watable = [ ...
    3   0.789 0.767 0.753; ... 
    4   0.792 0.748 0.687; ...
    5 	0.806 0.762 0.686; ...
    6	  0.826 0.788 0.713; ...
    7	  0.838 0.803 0.730; ...
    8	  0.851 0.818 0.749; ...
    9	  0.859 0.829 0.764; ...
    10	0.869 0.842 0.781; ...
    11	0.876 0.850 0.792; ...
    12	0.883 0.859 0.805; ...
    13	0.889 0.866 0.814; ...
    14	0.895 0.874 0.825; ...
    15	0.901 0.881 0.835; ...
    16	0.906 0.887 0.844; ...
    17	0.910 0.892 0.851; ...
    18	0.914 0.897 0.858; ...
    19	0.917 0.901 0.863; ...
    20	0.920 0.905 0.868; ...
    25	0.931 0.918 0.888; ...
    30	0.939 0.927 0.900; ...
    35	0.944 0.934 0.910; ...
    40	0.949 0.940 0.919; ...
    45  0.953 0.944 0.925; ...
    50	0.955 0.947 0.930	...
	];
  
  % Set the proper column of the watable, depending on confidence level
  switch(p)
    case("90%")
      j = 2;
    case("95%")
      j = 3;
    case("99%")
      j = 4;
    case(0.10)
      j = 2;
    case(0.05)
      j = 3;
    case(0.01)
      j = 4;
    otherwise
      error();
  endswitch
  
  % Pick the appropriate G_crit value, interpolate if necessary
  if (n >= 5 && n <= 20)
    critval = watable(n-2,j);
  elseif (n >= 21  && n <= 49)
    i = 14 + floor(n/5); % Determine row, 12=correction factor
    qs = (watable(i+1,j) - watable(i,j))/5;
    mul = n - watable(i,1); % Multiplicator for qs
    critval = watable(i,j) + (mul * qs);
  else % for the last value (600)
    i = 14 + floor(n/5); % Determine row, 12=correction factor
    critval = watable(i,j);
  endif
  return;
endfunction