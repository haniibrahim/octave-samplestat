# samplestat - Octave package for sample statistics

Octave package for statistics of normal distributed populations.

This package is made for normal distributed, natural scientific (chemistry, physics) data in the first place. The tests are focused for distributions of less than 30 samples. 

But they are some tests for bigger distributions, like Pearson-Hartley, Grubbs and Chi-squared test.

## Functions

It contains the following functions:

- Stray area (range of dispersion of the values) - *strayarea.m*
- Trust area (range of dispersion of the mean) - *trustarea.m*
- Outliert tests
  - Dean-Dixon - *deandixon.m*
  - Pearson-Hartley - *pearsonhartley.m*
  - Grubbs - *grubbs.m*
  - Grubbs (2-sided) - *grubbs2.m*
  - Nalimov
- Test for normal distribution
  - Chi-squared*
  - Shapiro-Wilk*
- Graphs
  - Tukey's boxplot*
- Make an Octave package*

*not implemented yet

## Help

For help just type in Octave:

```
help <function-name>
```
e.g.:
```
help deandixon

 -- Function File: [ OUTLIERFREE , OUTLIER] = deandixon(V, P)

     "deandixon" performs a Dean-Dixon outliertest based on R.B. Dean,
     W.J. Dixon, "Simplified statistics for small numbers of
     observations", Anal.Chem.  23 (1951) 636-638.

     V is a vector of numerical values.  the number of the values should
     be greater or equal than 3 and less or equal than 30 values, P is
     the statistical confidence level committed as a string ("95%",
     "99%" or "99.9%").

     95%: significant outlier, 99%: high significant outlier, 99.9%:
     highly significant outlier

     OUTLIERFREE contains a vector of outlier-free values, OUTLIER
     contains the outlier value.

          data = [6 8 14 12 35 15];
          [of, o] = deandixon(data, "95%")
          => of =  6    8   12   14   15
          => o =  35

          In the committed vector DATA which contains less than 30 values is
          checked for outliers with a probability of 95%. The value 35 is a significant
          outlier.


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