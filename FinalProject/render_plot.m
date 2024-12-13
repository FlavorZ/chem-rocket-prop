clear
clear all
clear functions
clc

% Load data from files
load('team1modelData.mat'); % Replace with the actual variable names

% Assuming 'experimental' and 'model' variables exist in the MAT files:
data1 = data1; % Adjust based on the actual variable name
data2 = table2array(modelData); % Adjust based on the actual variable name

% Define lower and upper bounds for the x-axis (time)
time_lower_bound = 0;
time_upper_bound = 295.7;

% Offset model time
time_model_offset = 0;

% Apply offset to model time
adjusted_model_time = data2(:, 1) + time_model_offset;

% Create a subplot layout (2 rows, 2 columns)
figure;

% First subplot: Pressure
subplot(2, 2, 1);
plot(data1(:, 1), data1(:, 5), 'b-', 'LineWidth', 1.5); 
hold on;
scatter(data1(:, 1), data1(:, 9), 'r', 'filled');
grid on;
xlabel('Time (s)');
ylabel('Pressure (psi)');
title('Pressure vs Time');
xlim([time_lower_bound, time_upper_bound]);
legend('Experimental', 'Model');

% Second subplot: Force
subplot(2, 2, 2);
plot(data1(:, 1), data1(:, 8), 'r-', 'LineWidth', 1.5); hold on;
scatter(adjusted_model_time, data2(:, 9), 'g', 'filled');
grid on;
xlabel('Time (s)');
ylabel('Force (lbf)');
title('Force vs Time');
xlim([time_lower_bound, time_upper_bound]);
legend('Experimental', 'Model');

% Third subplot: Column 7
subplot(2, 2, 3);
plot(data2(:, 1), data2(:, 7), 'g-', 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Column 7 Value');
title('Column 1 vs Column 7');
xlim([time_lower_bound, time_upper_bound]);
legend('Data2');

% Fourth subplot: Column 8
subplot(2, 2, 4);
plot(data2(:, 1), data2(:, 8), 'k-', 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Column 8 Value');
title('Column 1 vs Column 8');
xlim([time_lower_bound, time_upper_bound]);
legend('Data2');
