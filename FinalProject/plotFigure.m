% Assuming 'data1' is the dataset
time = data1(:, 1); % First column is assumed to be time
mass_flow_ox = data1(:, 4); % Example data for plotting
pressure = data1(:, 5); % Example data for plotting
force = data1(:, 8); % Example data for plotting
master_setpoint = data1(:, 9); % Example data for plotting

% Create a figure with 2x2 subplots
figure;

% Plot 1: Flowrate vs Time
subplot(2, 2, 1);
plot(time, mass_flow_ox, 'b-', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('m_dot_ox');
title('Flowrate vs Time');
grid on;

% Plot 2: Pressure vs Time
subplot(2, 2, 2);
plot(time, pressure, 'r--', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Pressure');
title('Parameter 5 vs Time');
grid on;

% Plot 3: Force vs Time
subplot(2, 2, 3);
plot(time, force, 'g-.', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Force');
title('Force vs Time');
grid on;

% Plot 4: Flowrate Setpoint vs Time
subplot(2, 2, 4);
plot(time, master_setpoint, 'k:', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Master setpoint');
title('Master setpoint vs Time');
grid on;

% Adjust layout
sgtitle('Rocket Parameters vs Time');
