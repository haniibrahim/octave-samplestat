function retval = strayarea(v, n, p)

  if studentfactor(n, p) < 0
    retval = -1.0;
    return;
  endif
  
  retval = std(v) * studentfactor(n, p);
  return; 

endfunction