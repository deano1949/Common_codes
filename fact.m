function y=fact(x,i)
  tic
  y=recursive(x,i);
  toc
  return

function y=recursive(x,i)

if i==0
    y=eye(size(x));
    return
end
 %fprintf('X= %i\n',x);
 y=x*recursive(x,i-1);
 
return
