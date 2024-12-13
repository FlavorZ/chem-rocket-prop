% Experimental Data
data = data1;

% Import Experimental Data
time = data(:, 1);
mass_flow = data(:, 4);
pressure = data(:, 5);
force = data(:, 8);
master_setpoint = data(:, 9);
Cstar = 165 * A(t) / mass_flow;

% Import Model Data
time_model = table2array(modelData(:,1));
mass_flow_ox_model = table2array(modelData(:,2)) * 22045.89; % Convert m_dot_ox to SLPM
mass_flow_model = mass_flow_ox_model + 500; %SLPM
pressure_model = table2array(modelData(:,7));
force_model = table2array(modelData(:,10));
isp_model = table2array(modelData(:,11));
Cstar_model = table2array(modelData(:,5));
OF_model = table2array(modelData(:,3));

% Model Offset
model_time_offset = 30-1.3+1.9;
%time_model = time_model + model_time_offset; % Apply time offset
time = time - model_time_offset;

% Create a figure with 2x2 subplots
figure;

% Plot 1: Flowrate vs Time
subplot(2, 2, 1);
plot(time, mass_flow, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, mass_flow_model, 'r-', 'LineWidth', 1.5); % Model solid line
plot(time, master_setpoint, 'g:', 'LineWidth', 1.0); % Experimental dotted line
xlabel('Time (s)');
ylabel('m_d_o_t (SLPM)');
title('Flowrate vs Time');
legend('Experimental', 'Model', 'Master Setpoint', 'Location', 'best');
xlim([0, 12]);
ylim([0, max(max(mass_flow), max(mass_flow_model)) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Plot 2: Pressure vs Time
subplot(2, 2, 2);
plot(time, pressure, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, pressure_model, 'r-', 'LineWidth', 1.5); % Model solid line
xlabel('Time (s)');
ylabel('Pressure (psi)');
title('Pressure vs Time');
legend('Experimental', 'Model', 'Location', 'best');
xlim([0, 12]);
ylim([0, max(max(pressure), max(pressure_model)) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Plot 3: Force vs Time
subplot(2, 2, 3);
plot(time, force, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, force_model, 'r-', 'LineWidth', 1.5); % Model solid line
xlabel('Time (s)');
ylabel('Force (lbf)');
title('Force vs Time');
legend('Experimental', 'Model', 'Location', 'best');
xlim([0, 12]);
ylim([0, max(max(force), max(force_model)) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Plot 4: Isp vs Time
subplot(2, 2, 4);
plot(time, master_setpoint, 'b:', 'LineWidth', 1.5); % Experimental dotted line
xlabel('Time (s)');
ylabel('Master Setpoint');
title('Master Setpoint vs Time');
xlim([0, 12]);
ylim([0, max(master_setpoint) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Adjust layout
sgtitle('Rocket Parameters vs Time');
