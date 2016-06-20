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

% SampleStatDemo is a demo script for the samplestat.m functions
%
% - strayarea.m
% - trustarea.m
%
% Core functions as mean(), std(), min() and max() are also used.

% Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
% License: GPL 3.0

% Sample data
v = [ ...
9.999; ...
9.998; ...
10.002; ...
10.000; ...
10.001; ...
10.000 ...
];

% Statistical confidence level
p = "95%";

% Calculate statistical results
n  = length(v);        % Number of values
x  = mean(v);          % Arithmetic mean
s  = std (v);          % Standard deviation
sa = strayarea(v, p);  % Range of dispersion of the values (stray area)
ta = trustarea(v, p);  % Range of dispersion of the mean (trust area)
mi = min(v);           % Minimal value
ma = max(v);           % Maximal value

% Output
fprintf("SampleStatDemo - Demo script 'Statistics for Sampling Distributions'\n\n");
fprintf("Values:\n");
disp(v); % Display data
fprintf("\n"); % blank line
fprintf("\
Number of Values            : %i\n\
Arithmetic Mean             : %g\n\
Standard Deviation (S.D.)   : %g\n\
Confidence Level            : %s\n\
Range of Dispersion (values): %g\n\
Range of Dispersion (mean)  : %g\n\
Minimum                     : %g\n\
Maximum                     : %g\n\
", n, x, s, p, sa, ta, mi, ma);

fprintf("\n"); % blank line

fprintf("\
68 percent of the values will stray arount %g +- %g (S.D.). %s of the values \
will be expected around %g +/- %g (Range of disp. of the values, stray area). \
With a propability of %s the mean of %g will stray around %g +/- %g (Rage of \
dispersion of the mean, trust area).\n", x, s, p, x, sa, p, x, x, ta);

clear;
