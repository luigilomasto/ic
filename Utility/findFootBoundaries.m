function [left_bound, right_bound, upper_bound, lower_bound] = findFootBoundaries(image)

[num_rows, num_cols] = size(image);

black_row = zeros(1, num_cols);
black_col = zeros(num_rows, 1);

for i=1:num_rows
  if ~isequal(black_row, image(i,:))
    upper_bound = i;
    break;
  end
end

for i=num_rows:-1:1
  if ~isequal(black_row, image(i,:))
    lower_bound = i;
    break;
  end
end

for i=1:num_cols
  if ~isequal(black_col, image(:,i))
    left_bound = i;
    break;
  end
end

for i=num_cols:-1:1
  if ~isequal(black_col, image(:,i))
    right_bound = i;
    break;
  end
end
