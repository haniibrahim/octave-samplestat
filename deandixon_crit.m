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
##@deftypefn {Function File} [@var{critval}] = deandixon_crit(@var{n}, @var{p})
##
##Service function for "deandixon()" Dean-Dixon outlier test.
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
##  "95%"             0.05
##  "99%"             0.01
##  "99.9%"           0.001
##@end group
##@end example
##
##
##@var{n} has to be between: 3 <= @var{n} <= 30. @var{p} is "95%" (0.05), "99%" 
##(0.01) or "99.9%" (0.001).
##
##Example:
##
##@example
##@group
##V = [6 8 14 12 5 15];
##deandixon_crit(length(V), "95%")
##@result{} 0.56300
##
##deandixon_crit(length(V), 0.05)
##@result{} 0.56300
##
##The Q_crit value (@var{critval}) of @var{n}=6 and @var{p}="95%" (0.05) is 0.563.
##@end group
##@end example
##
##Based on R.B. Dean, W.J. Dixon,
##"Simplified statistics for small numbers of observations", Anal.Chem. 23 
##(1951) 636-638.
##@seealso{deandixon(), dixon(), grubbs(), pearsonhartley(), nalimov(), shapirowilk()}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function [critval] = deandixon_crit(n, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(n) || (n-floor(n) != 0)); error("First argument has to be a integer\n"); endif
  if (n <3 || n>30); error("First value has to be greater or equal 3 and less or equal 30"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%") || p != 0.05 || ...
        p != 0.01 || p != 0.001)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"95%\", \"99%\" or \"99.9%\" or as alpha value: 0.05, 0.01, 0.001");
  endif

  % qtable contains the critical values critval for N (number of values)
  % and alpha (niveau of significance)  
  % Column 1 : Number of values (N)
  % Column 2 : Q_crit, 95% confidence level, alpha = 0.05
  % Column 3 : Q_crit, 99% confidence level, alpha = 0.01
  % Column 4 : Q_crit, 99.9% confidence level, alpha = 0.001
  qtable = [ ...
     3 0.941 0.994 0.999; ...
     4 0.766 0.921 0.964; ...
     5 0.643 0.824 0.895; ...
     6 0.563 0.744 0.822; ...
     7 0.507 0.681 0.763; ...
     8 0.467 0.633 0.716; ...
     9 0.436 0.596 0.675; ...
    10 0.412 0.568 0.647; ...
    15 0.338 0.473 0.544; ...
    20 0.300 0.426 0.491; ...
    25 0.277 0.395 0.455; ...
    30 0.260 0.371 0.430  ...
	];
  
  % Set the proper column of the t-table, depending on confidence level
  switch(p)
    case("95%")
      j = 2;
    case(0.05)
      j = 2;
    case("99%")
      j = 3;
    case(0.01)
      j = 3;
    case("99.9%")
      j = 4;
    case(0.001)
      j = 4;
    otherwise
      error();
  endswitch
  
  % Pick the appropriate Q_crit value, interpolate if necessary
  if (n >= 3 && n <= 10)
    critval = qtable(n-2,j);
  elseif (n >= 11  && n <= 29)
    i = 6 + floor(n/5); % Determine row, 6=correction factor
    qs = (qtable(i,j) - qtable(i+1,j))/5;
    mul = n - qtable(i,1); % Multiplicator for qs
    critval = qtable(i,j) - (mul * qs);
%    critval = qtable(i,j) - ((qtable(i,j)-qtable(i+1,j))/5);
  else % for the last value (30)
    i = 6 + floor(n/5); % Determine row, 6=correction factor
    critval = qtable(i,j);
  endif
  return;
endfunction