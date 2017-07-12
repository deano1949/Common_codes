function y=fact1(x,i)
  tic
  y=loop(x,i);
  toc
  return
  
function y=loop(x,i)
y=x;
   while i>1
       y=y*x;

       i=i-1;
   end
return
