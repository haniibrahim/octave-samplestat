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
##@deftypefn {Function File} @var{retval} = trustarea(@var{v}, @var{p})
##
##"trustarea" @var{retval} is the range of dispersion of the mean. This 
##parameter tells how secure the mean is. It indicates the stray area of the 
##mean and not of the raw values as the stray area does.
##
##The trust area @var{retval} indicates that the mean of the values in vector 
##@var{v} strays around +/-@var{retval} with the specified probability.
##
##@var{p} is the statistical confidence level (%) in a string or
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
##trustarea(V, "95%")
##@result{} 4.4514
##
##trustarea(V, 0.05)
##@result{} 4.4514
##
##With a probability of 95% the arithmetic mean of 10 will stray 
##around 4.5 => 10 +/- 4.5
##@end group
##@end example
##@seealso{}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function retval = trustarea(v, p)
  % Check arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(v) || ~isvector(v)); error("First argument has to be a numeric vector\n"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%") || p != 0.05 || ...
        p != 0.01 || p != 0.001)
    error("Second argument is the statistical confidence level and has to be a string, \
as \"95%\", \"99%\" or \"99.9%\" or as alpha value: 0.05, 0.01, 0.001");
  endif
  n = length(v); % Number of values
  if (strayarea(v,p) < 0)
    retval = -1.0;
  else
   retval = strayarea(v,p)/sqrt(n);
  endif
  return;
endfunction