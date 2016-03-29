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
##@deftypefn {Function File} [@var{qcritval}] = dixon_crit(@var{n}, @var{p})
##
##Service function for "dixon()", Dixon outlier test refered to 
##Rorabacher, David B. (1991) "Statistical Treatment for Rejection of Deviant 
##Values: Critical Values of Dixon's Q Parameter and Related Subrange Ratios 
##at the 95% Confidence Level." Analytical Chemistry 63, no. 2 (1991): 139-146.
##
##Returns the critical Q value (@var{critval}).
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
##Exanple:
##
##@example
##@group
##V = [6 8 14 12 5 15];
##dixon_crit(length(V), "95%")
##@result{} 0.62500
##
##dixon_crit(length(V), 0.05)
##@result{} 0.62500
##
##The Q_crit value (@var{critval}) of @var{n}=6 and @var{p}="95%" (0.05) is 0.625.
##@end group
##@end example
##
##@seealso{}
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0
function [critval] = dixon_crit(n, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(n) || (n-floor(n) != 0)); error("First argument has to be a integer\n"); endif
  if (n <3 || n>30); error("First value has to be greater or equal 3 and less or equal 30"); endif
  if ~(strcmp(p,"90%") || strcmp(p,"95%") || strcmp(p,"99%") || p != 0.1 || ...
        p != 0.05 || p != 0.01)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"90%\", \"95%\" or \"99%\" or as alpha value: 0.1, 0.05, 0.01");
  endif

  % qtable contains the critical values critval for N (number of values)
  % and alpha (niveau of significance)  
  % Column 1 : Number of values (N)
  % Column 2 : Q_crit, 90% confidence level, alpha = 0.1
  % Column 3 : Q_crit, 95% confidence level, alpha = 0.05
  % Column 4 : Q_crit, 99% confidence level, alpha = 0.01
  qtable = [ ...
    3 	0.941 	0.97 	0.994; ...
    4 	0.765 	0.829 	0.926; ...
    5 	0.642 	0.71 	0.821; ...
    6 	0.56 	0.625 	0.74; ...
    7 	0.507 	0.568 	0.68; ...
    8 	0.468 	0.526 	0.634; ...
    9 	0.437 	0.493 	0.598; ...
    10 	0.412 	0.466 	0.568; ...
    11 	0.392 	0.444 	0.542; ...
    12 	0.376 	0.426 	0.522; ...
    13 	0.361 	0.41 	0.503; ...
    14 	0.349 	0.396 	0.488; ...
    15 	0.338 	0.384 	0.475; ...
    16 	0.329 	0.374 	0.463; ...
    17 	0.32 	0.365 	0.452; ...
    18 	0.313 	0.356 	0.442; ...
    19 	0.306 	0.349 	0.433; ...
    20 	0.3 	0.342 	0.425; ...
    21 	0.295 	0.337 	0.418; ...
    22 	0.29 	0.331 	0.411; ...
    23 	0.285 	0.326 	0.404; ...
    24 	0.281 	0.321 	0.399; ...
    25 	0.277 	0.317 	0.393; ...
    26 	0.273 	0.312 	0.388; ...
    27 	0.269 	0.308 	0.384; ...
    28 	0.266 	0.305 	0.38; ...
    29 	0.263 	0.301 	0.376; ...
    30 	0.26 	0.29 	0.372 ...
	];
  
  % Set the proper column of the t-table, depending on confidence level
  switch(p)
    case("90%")
      j = 2;
    case(0.1)
      j = 2;
    case("95%")
      j = 3;
    case(0.05)
      j = 3;
    case("99%")
      j = 4;
    case(0.01)
      j = 4;
    otherwise
      error();
  endswitch
  
  % Pick the appropriate Q_crit value, interpolate if necessary
  critval = qtable(n-2,j);
  return;
endfunction