# samplestat - Octave package for sample statistics

Octave package for statistics of normal distributed populations.

This package is made for normal distributed, natural scientific (chemistry, physics) data in the first place. The tests are focused for distributions of less than 30 samples. 

But they are some tests for bigger distributions, like Pearson-Hartley, Grubbs and Chi-squared test.

These functions are good to extend the built-in functions mean(), std(), max(), min(), median() and the [statistics package](http://octave.sourceforge.net/statistics/index.html) maintained by Arno Onken at [Octave Forge](http://octave.sourceforge.net/index.html).

## Functions

It contains the following functions:

- Stray area (range of dispersion of the values) - *strayarea.m*
- Trust area (range of dispersion of the mean) - *trustarea.m*
- Outliert tests
  - Dean-Dixon - *deandixon.m*
  - Dixon - *dixon.m*
  - Pearson-Hartley - *pearsonhartley.m*
  - Grubbs - *grubbs.m*
  - Grubbs (2-sided) - *grubbs2.m*
  - Nalimov - *nalimov.m*
- Test for normal distribution
  - Shapiro-Wilk*

*not implemented yet

## Help

For help just type in Octave:

```
help <function-name>
```
e.g.:
```
help deandixon
```
```
 -- Function File: [ OUTLIERFREE , OUTLIER] = deandixon(V, P)

     "deandixon" performs a Dean-Dixon outlier test based on R.B. Dean,
     W.J. Dixon, "Simplified statistics for small numbers of
     observations", Anal.Chem.  23 (1951) 636-638.

     OUTLIERFREE contains a vector of outlier-free values, OUTLIER
     contains the outlier value.

     N is the number of values in the sample distribution, committed as
     an integer.  P is the statistical confidence level (%) in a string
     or the level of significance (alpha) as a decimal value.

          conf. level   level of signif.
          ------------------------------
            "95%"             0.05
            "99%"             0.01
            "99.9%"           0.001

     N has to be between: 3 <= N <= 30.  P is "95%" (0.05), "99%" (0.01)
     or "99.9%" (0.001).

     Example:

          data = [6 8 14 12 35 15];
          [of, o] = deandixon(data, "95%")
          => of =  6    8   12   14   15
          => o =  35

          [of, o] = deandixon(data, 0.05)
          => of =  6    8   12   14   15
          => o =  35

          In the committed vector DATA which contains less than 30 values is
          checked for outliers with a confidence level of 95%. The value 35 is a significant
          outlier.

     See also: pearsonhartley(), grubbs(), grubbs2(), nalimov().

Additional help for built-in functions and operators is
available in the online version of the manual.  Use the command
'doc <topic>' to search the manual index.

Help and information about Octave is also available on the WWW
at http://www.octave.org and via the help@octave.org
mailing list.
```

## License

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.