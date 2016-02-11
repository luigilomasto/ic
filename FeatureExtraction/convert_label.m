function label = convert_label(row, left, varo)

if left
	col_to_check_cavo = 2;
	col_to_check_piatto = 4;
	col_to_check_valgo = 6;
	col_to_check_varo = 8;
else
	col_to_check_cavo = 3;
	col_to_check_piatto = 5;
	col_to_check_valgo = 7;
	col_to_check_varo = 9;
end

if ~varo
	if row(col_to_check_cavo) == 1
		label = 1;
    elseif row(col_to_check_piatto) == 1
		label = 2;
    else
        label = 3;
    end
else
	if row(col_to_check_valgo) == 1
		label = 4;
    elseif row(col_to_check_varo) == 1
		label = 5;
    else
        label = 3;
    end
end

end
