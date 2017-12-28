function output = removestaticprice(matrix)
    [r,c]=size(matrix);
    for i=1:(r-1)
        for j=1:c
            if matrix(i,j)==matrix(i+1,j)
                matrix(i,j)=NaN;
            end
        end
    end
output=matrix;
end