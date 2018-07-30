% Display results
disp(' ');
disp(['Some output ', num2str(N)]);

disp(' ');disp(' ');
T1 = table (x', y');
T1.Properties.VariableNames = {'column_1','column_2'};
T1.Properties.Description = 'A table title';
disp(['  ',T1.Properties.Description, ':']);
disp(' ');
feature('HotLinks',false);  % disable bold headers 
disp(T1)
