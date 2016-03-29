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
##@var{v} is a vector of numerical values, @var{p} is the statistical confidence level (%) in a string or
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
##Example:
##
##@example
##@group
##V = [6 8 14 12 5 15];
##mean(V)
##@result{} 10.
##strayarea(V, "95%")
##@result{} 10.904
##
##strayarea(V, 0.05)
##@result{} 10.904
##
##In the given vector "@var{v}" 95% of all values will stray about 10.9 around
##the arithmetic mean of 10 => 0 and 20.9
##@end group
##@end example
##@seealso{}
##@end deftypefn

## Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
## License: GPL 3.0
function retval = strayarea(v, p)

  % Check arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%") || p != 0.05 || ...
        p != 0.01 || p != 0.001)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"95%\", \"99%\" or \"99.9%\" or as alpha value: 0.05, 0.01, 0.001");
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