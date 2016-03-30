# Copyright (C) 2016 Hani Andreas Ibrahim
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
## @deftypefn {Function File} {@var{s} =} sboxplot (@var{v}, @var{vertical})
##
## Produce a box plot for a single data set committed as a vector.
##
## "sboxplot" is a wrapper of the "boxplot" function of the "statistics" package 
## from Octave Forge (http://octave.sourceforge.net/statistics/index.html), 
## programmed by Alberto Terruzzi, Alberto Pose, Pascal Dupuis and Juan Pablo 
## Carbajal.
##
## @var{v} is a vector which contains the data for plotting.
##
## @var{vert} = 0 makes the boxes horizontal, by default @var{vert} = 1.
## @var{vert} is optional.
##
## The returned matrix @var{s} has one column for each data set as follows:
##
## @multitable @columnfractions .1 .8
## @item 1 @tab Minimum
## @item 2 @tab 1st quartile
## @item 3 @tab 2nd quartile (median)
## @item 4 @tab 3rd quartile
## @item 5 @tab Maximum
## @item 6 @tab Lower confidence limit for median
## @item 7 @tab Upper confidence limit for median
## @end multitable
##
## Example
##
## @example
## data = randn(10,1)*5+140;
## sboxplot (data);
##
## Plots a vertical boxplot.
##
## sboxplot (data, 0)
## set(gca(), "ytick", 1, "yticklabel", {"Measured Data"})
## title("My boxplot");
## xlabel("values");
##
## Plots a horizontal boxplot and prints the boxplot data: quartiles, etc. Then
## it changes the y-axis tick-label from "data" to "Measured Data", set title and
## x-axis label.
## @end example
##
## @end deftypefn

function s = sboxplot(v, vert)
  % Check for "Statistics" package
  try
    pkg load statistics
  catch
    fprintf(stderr, "Package 'statistics' not installed. Do 'pkg install -forge statistics'\n"); % Package "statistics" not installed
    s = [];
    return;
  end_try_catch
  pkg load statistics;
  
  % Check arguments
  if (nargin < 1 || nargin > 2); print_usage(); endif
  if ~(isvector(v) && isnumeric(v)); error ("First argument must be a numerical vector"); endif
  if (nargin == 1); vert = 1; endif % Init "vert" to true (vertical) if empty
  if ~(vert == 1 || vert == 0); error("Second argument must be 0=horzontal or 1=vertical"); endif
  
  
  if vert == 1
    s = boxplot(v);
    axis([0.4,1.6]); % Enter the box with space left and right
    set(gca (), "xtick", [1], "xticklabel", { inputname(1) }) % 
  else
    s = boxplot(v, 0, ['+','o'],0 );
    old_axis = axis;
    axis([old_axis(1), old_axis(2), 0.4,1.6]); % Enter the box with space left and right
    set(gca (), "ytick", [1], "yticklabel", { inputname(1) }) % 
  endif
  
  return;
  
endfunction