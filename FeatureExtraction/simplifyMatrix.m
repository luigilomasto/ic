function simplifiedMatrix = simplifyMatrix(total_matrix)

[num_images, num_labels] = size(total_matrix);

simplifiedMatrix = zeros(num_images, 9);

for i=1:num_images
	simplifiedMatrix(i,1)=total_matrix(i,1);
	if total_matrix(i, 2)==1
		simplifiedMatrix(i,2)=1;
		simplifiedMatrix(i,3)=1;
	end
	if total_matrix(i,3)==1
		simplifiedMatrix(i,4)=1;
		simplifiedMatrix(i,5)=1;
	end
	if total_matrix(i,4)==1
		simplifiedMatrix(i,6)=1;
		simplifiedMatrix(i,7)=1;
	end
	if total_matrix(i,5)==1
		simplifiedMatrix(i,8)=1;
		simplifiedMatrix(i,9)=1;
	end
	if total_matrix(i,6)==1
		simplifiedMatrix(i,3)=1;
	end
	if total_matrix(i,7)==1
		simplifiedMatrix(i,5)=1;
	end
	if total_matrix(i,8)==1
		simplifyMatrix(i,7)=1;
	end
	if total_matrix(i,9)==1
		simplifiedMatrix(i,9)=1;
	end
	if total_matrix(i,10)==1
		simplifiedMatrix(i,2)=1;
	end
	if total_matrix(i,11)==1
		simplifiedMatrix(i,4)=1;
	end
	if total_matrix(i,12)==1
		simplifyMatrix(i,6)=1;
	end
	if total_matrix(i,13)==1
		simplifiedMatrix(i,8)=1;
	end
end
end
