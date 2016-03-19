## -*- texinfo -*-
##
##@deftypefn {Function File} [@var{qcritval}] = qcrit_na(@var{n}, @var{p})
##
##Returns the critical Q value (@var{qcritval}) for a committed number of values 
##(@var{n}) of a sample distribution and a given confidence level (@var{p}) for 
##the Nalimov outlier test.
##
##In the Nalimov outlier test you compare @var{qcritval} with a calculated 
##Q value. 
##
##@var{n} has to be between: 3 <= @var{n} <= 1000. @var{p} is "95% or "99%" or "99.9%".
##
##@example
##@group
##V = [6 8 14 12 5 15];
##qcrit_na(length(V), "95%")
##@result{} 1.870
##
##The Q_crit value (@var{qcritval}) of @var{n}=6 and @var{p}="95%" is 1.870.
##@end group
##@end example
##
##@seealso{}
##@end deftypefn

# Author: Hani Andreas Ibrahim <hani.ibrahim@gmx.de>
# License: GPL 3.0
function [qcritval] = qcrit_na(n, p)
  % Checking arguments
  if (nargin < 2 || nargin > 2); print_usage(); endif
  if (~isnumeric(n) || (n-floor(n) != 0)); error("First argument has to be a integer\n"); endif
  if (n <3 || n>1000); error("First value has to be greater or equal 3 and less or equal 1000"); endif
  if ~(strcmp(p,"95%") || strcmp(p,"99%") || strcmp(p,"99.9%"))
    error("Second argument is the statistical confidence level and has to be a string, as \"95%\", \"99%\" or \"99.9%\"");
  endif

  % qtable contains the critical values qcritval for N (number of values)
  % and alpha (niveau of significance)  
  % Column 1 : Dregree of freedom (f = n-2)
  % Column 2 : Q_crit, 95% confidence level
  % Column 3 : Q_crit, 99% confidence level
  % Column 4 : Q_crit, 99.9% confidence level
  qtable = [ ...
    1	    1.409	1.414	1.414; ...
    2	    1.645	1.715	1.730; ...
    3	    1.757	1.918	1.982; ...
    4	    1.814	2.051	2.178; ...
    5	    1.848	2.142	2.329; ...
    6	    1.870	2.208	2.447; ...
    7	    1.885	2.256	2.540; ...
    8	    1.895	2.294	2.616; ...
    9	    1.903	2.324	2.678; ...
    10  	1.910	2.348	2.730; ...
    11  	1.916	2.368	2.774; ...
    12  	1.920	2.385	2.812; ...
    13  	1.923	2.399	2.845; ...
    14  	1.926	2.412	2.874; ...
    15	  1.928	2.423	2.899; ...
    16  	1.931	2.432	2.921; ...
    17	  1.933	2.440	2.941; ...
    18  	1.935	2.447	2.959; ...
    19	  1.936	2.454	2.975; ...
    20  	1.937	2.460	2.990; ...
    25	  1.942	2.483	3.047; ...
    30  	1.945	2.498	3.085; ...
    35  	1.948	2.509	3.113; ...
    40  	1.949	2.518	3.134; ...
    45  	1.950	2.524	3.152; ...
    50  	1.951	2.529	3.166; ...
    100 	1.956	2.553	3.227; ...
    200 	1.958	2.564	3.265; ...
    300 	1.958	2.566	3.271; ...
    400 	1.959	2.568	3.275; ...
    500 	1.959	2.570	3.279; ...
    600 	1.959	2.571	3.281; ...
    700 	1.959	2.572	3.283; ...
    800	  1.959	2.573	3.285; ...
    1000  1.960	2.576	3.291 ...
	];
  
  % Set the proper column of the t-table, depending on confidence level
  switch(p)
    case("95%")
      j = 2;
    case("99%")
      j = 3;
    case("99.9%")
      j = 4;
    otherwise
      error();
  endswitch
  
  % degree of freedom
  f = n-2;
  
  % Pick the appropriate Q_crit value, interpolate if necessary
  if (f >= 1 && f <= 20)
    qcritval = qtable(f,j);
  elseif (f >= 21  && f <= 50)
    i = 16 + floor(f/5); % Determine row, 16=correction factor
    qs = (qtable(i+1,j) - qtable(i,j))/5;
    mul = f - qtable(i,1); % Multiplicator for qs
    qcritval = qtable(i,j) + (mul * qs);
  elseif (f >= 51  && f <= 100)
    i = 25 + floor(f/50); % Determine row, 25=correction factor
    qs = (qtable(i+1,j) - qtable(i,j))/50;
    mul = f - qtable(i,1); % Multiplicator for qs
    qcritval = qtable(i,j) + (mul * qs);
  elseif (f >= 101  && f <= 800)
    i = 26 + floor(f/100); % Determine row, 26=correction factor
    qs = (qtable(i+1,j) - qtable(i,j))/100;
    mul = f - qtable(i,1); % Multiplicator for qs
    qcritval = qtable(i,j) + (mul * qs);
  elseif (f >= 801  && f < 1000)
    i = 30 + floor(f/200); % Determine row, 30=correction factor
    qs = (qtable(i+1,j) - qtable(i,j))/200;
    mul = f - qtable(i,1); % Multiplicator for qs
    qcritval = qtable(i,j) + (mul * qs);
  else % for the last value (1000)
    i = 35; % Determine row, 6=correction factor
    qcritval = qtable(i,j);
  endif
  return;
endfunction