# samplestat - Octave statistic package for sample distributions

Octave package for statistics of normal distributed populations.

This package is made for normal distributed, natural scientific (chemistry, physics) data in the first place. The tests are focused for distributions of less than 30 samples. 

These functions are good to extend the built-in functions mean(), std(), max(), min(), median() and the [statistics package](http://octave.sourceforge.net/statistics/index.html) maintained by Arno Onken at [Octave Forge](http://octave.sourceforge.net/index.html).

## Functions

It contains the following user functions:

- Stray area (range of dispersion of the values) - *strayarea()*
- Trust area (range of dispersion of the mean) - *trustarea()*
- Outlier tests
  - Dean-Dixon - *deandixon()*
  - Dixon (Revised by Rorabacher) - *dixon()*
  - Pearson-Hartley - *pearsonhartley()*
  - Grubbs (2-sided) - *grubbs()*
  - Nalimov - *nalimov()*
- Test for normal distribution
  - Shapiro-Wilk - *shapirowilk()*
- Graphs
  - Boxplot (for single data set) - *sboxplot()*
    Wrapper of `boxplot` from the [statistics package](http://octave.sourceforge.net/statistics/index.html). You need this package installed to run `sboxplot`. Optimized for single datasets (which is not the strength of the original function) and with handy automatic tick labeling. Draws vertical and horizontal boxplots.
- Demo scripts
  - Demo for mean evaluation via "strayarea()" and "trustarea()" - *SampleStatDemo*

Useful probability plot and histogram functions are contained in the [statistics package](http://octave.sourceforge.net/statistics/index.html) on the Forge.

##Boxplot
    
```
data = randn(10,1)*5+140;
sboxplot(data);
print -dpng boxplot.png;
```
![Boxplot (sboxplot())](http://blog.hani-ibrahim.de/wp-content/uploads/boxplot_small.png)

## Installation

You have two opportunities:

1. Copy all m-files in a arbitrary directory, e.g. `~/octave/samplestat` and add the path in one of Octave's startup files, e.g. `~/.octaverc`, by appending `addpath('~/octave/samplepath');` to this file, or
2. Download the package file `samplestat-1.0.0.tar.gz` from the "package" folder and then start Octave and type in Octave's prompt: `pkg install /path/to/samplestat-1.0.0.tar.gz` and then `pkg load samplestat`.

`~`stands for your home directory (Unix) and your profile directory (Windows) respectivly.

## Help

For help just type in Octave:

```
>> help <function-name>
```
e.g.:
```
>> help deandixon
```
```
 -- Function File: [ OUTLIERFREE , OUTLIER] = deandixon(V, P)

     "deandixon()" performs a Dean-Dixon outlier test for less than 30
     values.

     OUTLIERFREE contains a vector of outlier-free values, OUTLIER
     contains the outlier value.

     V is a vector of numerical values. The number of the values should
     be greater or equal than 3 and less or equal than 30 values. P is
     the statistical confidence level (%) as a string or the level of
     significance (alpha) as a decimal value.

          conf. level   level of signif.
          ------------------------------
            "95%"             0.05
            "99%"             0.01
            "99.9%"           0.001

     Example:

          data = [6 8 14 12 35 15];
          [of, o] = deandixon(data, "95%")
          => of =  6    8   12   14   15
          => o =  35

          [of, o] = deandixon(data, 0.05)
          => of =  6    8   12   14   15
          => o =  35

          In the committed vector DATA is checked for outliers with a confidence
          level of 95%. The value 35 is a significant outlier.

     Based on R.B. Dean, W.J. Dixon, "Simplified statistics for small
     numbers of observations", Anal.Chem.  23 (1951) 636-638.

     See also: dixon(), grubbs(), pearsonhartley(), nalimov(),
     shapirowilk().

Additional help for built-in functions and operators is
available in the online version of the manual.  Use the command
'doc <topic>' to search the manual index.

Help and information about Octave is also available on the WWW
at http://www.octave.org and via the help@octave.org
mailing list.
```

## Demoscript for mean evaluation

This demo make use of the functions `strayarea()` (range of dispersion of the values) and `trustarea()` (range of dispersion of the mean). 

```
>> SampleStatDemo
```

```
SampleStatDemo - Demo script 'Statistics for Sampling Distributions'

Values:
    9.9990
    9.9980
   10.0020
   10.0000
   10.0010
   10.0000

Number of Values            : 6
Arithmetic Mean             : 10
Standard Deviation (S.D.)   : 0.00141421
Confidence Level            : 95%
Range of Dispersion (values): 0.00363453
Range of Dispersion (mean)  : 0.00148379
Minimum                     : 9.998
Maximum                     : 10.002

68 percent of the values will stray arount 10 +- 0.00141421 (S.D.). 95% of the values will be expected around 10 +/- 0.00363453 (Range of disp. of the values, stray area). With a propability of 95% the mean of 10 will stray around 10 +/- 0.00148379 (Rage of dispersion of the mean, trust area).
```

## License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.