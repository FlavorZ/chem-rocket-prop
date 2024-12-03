data1 = team1.Segment1.data
data2 = team2.Segment1.data
data3 = team3.Segment1.data
data4 = team4.Segment1.data
data5 = team5.Segment1.data

% Define lower and upper bounds for the x-axis (time)
time_lower_bound = 282.068; % Replace with the desired lower bound
time_upper_bound = 295.7; % Replace with the desired upper bound

% Plot the data (scatter)
figure;
plot(data1(:,1), data1(:,5), 'b-', 'LineWidth', 1.5);
grid on; % Add a grid
xlabel('X-axis Label'); % Replace with your x-axis label
ylabel('Y-axis Label'); % Replace with your y-axis label
title('Plot of Column 1 vs Column 5'); % Replace with your title
legend('Data1'); % Add a legend

% If a line plot is desired, replace scatter with plot:


% Set x-axis limits
xlim([time_lower_bound, time_upper_bound]);