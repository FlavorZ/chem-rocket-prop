% Define lower and upper bounds for the x-axis (time)
time_lower_bound = 0; %282.068; % Replace with the desired lower bound
time_upper_bound = 295.7; % Replace with the desired upper bound

% Offset model time
time_model_offset = 0;

% Create a subplot layout (2 rows, 2 columns)
figure; 

% First subplot: Line plot and scatter plot for data1
subplot(2, 2, 1); % Create the first subplot
plot(data1(:,1), data1(:,5), 'b-', 'LineWidth', 1.5); % Line plot for column 5
hold on; % Hold for overlaying scatter plot
scatter(data1(:,1), data1(:,9), 'r', 'filled'); % Scatter plot for column 9
grid on; % Add a grid
xlabel('Time (s)'); % Label for the x-axis
ylabel('Pressure (psi)'); % Replace with your y-axis label
title('Pressure'); % Title for the first subplot
xlim([time_lower_bound, time_upper_bound]); % Set x-axis limits
legend('Column 5 (Line)', 'Column 9 (Scatter)'); % Add a legend

% Second subplot: Line plot for data2, column 6
subplot(2, 2, 2); % Create the second subplot
plot(data1(:,1), data1(:,8), 'r-', 'LineWidth', 1.5); % Line plot for column 6
grid on; % Add a grid
scatter(model(:,1), model(:,9), 'r', 'filled'); % Scatter plot for column 9
xlabel('Time (s)'); % Label for the x-axis
ylabel('Force (lbf)'); % Replace with your y-axis label
title('Force'); % Title for the second subplot
xlim([time_lower_bound, time_upper_bound]); % Set x-axis limits
legend('Data2'); % Add a legend

% Third subplot: Line plot for data2, column 7
subplot(2, 2, 3); % Create the third subplot
plot(data2(:,1), data2(:,7), 'g-', 'LineWidth', 1.5); % Line plot for column 7
grid on; % Add a grid
xlabel('Time (s)'); % Label for the x-axis
ylabel('Y-axis Label'); % Replace with your y-axis label
title('Plot of Column 1 vs Column 7 - Data2'); % Title for the third subplot
xlim([time_lower_bound, time_upper_bound]); % Set x-axis limits
legend('Data2'); % Add a legend

% Fourth subplot: Line plot for data2, column 8
subplot(2, 2, 4); % Create the fourth subplot
plot(data2(:,1), data2(:,8), 'k-', 'LineWidth', 1.5); % Line plot for column 8
grid on; % Add a grid
xlabel('Time (s)'); % Label for the x-axis
ylabel('Y-axis Label'); % Replace with your y-axis label
title('Plot of Column 1 vs Column 8 - Data2'); % Title for the fourth subplot
xlim([time_lower_bound, time_upper_bound]); % Set x-axis limits
legend('Data2'); % Add a legend
