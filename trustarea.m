function retval = trustarea(v, n, p)
  if (strayarea(v,n,p) < 0)
    retval = -1.0;
  else
   retval = strayarea(v,n,p)/sqrt(n);
  endif
  return;
endfunction