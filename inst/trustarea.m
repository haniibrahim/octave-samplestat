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
##@deftypefn {Function File} @var{trustval} = trustarea(@var{v}, @var{p})
##
##"trustarea" determine the range of dispersion of the mean. It describes the
##quality of the mean and indicates the range of dispersion of the 
##mean and not of the raw values as the stray area does.
##
##E.g. if @var{trustval} = 1.4 at @var{p} = 95% with a mean = 10,0 the mean for
##the whole population will stray with a confidence of 95% at about 10.0 +/- 1.4.
##
##@var{trustval} is the trust area (range of dispersion of the mean).
## 
##@var{p} is the statistical confidence level (%) as a string or
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
##With a confidence of 95% the arithmetic mean of 10 will stray 
##around 4.5 => 10 +/- 4.5
##@end group
##@end example
##
##The trustarea is the result of the division of the strayarea with the squareroot 
##of the numbers of values: strayarea / sqrt(n).
##The strayarea is calculated as s * t. (t = student factor, dependent on the 
##confidence level P% = 95%, etc. and the degree of freedom f = n - 1.
##
##Based on the German book R. Kaiser, G. Gottschalk; "Elementare Tests zur 
##Beurteilung von Meßdaten", BI Hochschultaschenbücher, Bd. 774, Mannheim 1972.
##@seealso{strayarea()}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function trustval = trustarea(v, p)
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
    error("Wrong studenfactor 't' was committed. Here is something serously wrong!");
  else
   trustval = strayarea(v,p)/sqrt(n);
  endif
  return;
endfunction