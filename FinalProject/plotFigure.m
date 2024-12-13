reload = false;
if reload == true
    clear all
    clc

    % Load Data
    team1 = lvm_import('Team1.lvm', 0)
    modelData = readtable('Data/CleanedModel.xlsx'); % Load simulated data
    data = team1.Segment1.data; % Load Experimental Data
end

% Import Experimental Data
time = data(:, 1);
mass_flow = data(:, 4); 
pressure = data(:, 5);
force = data(:, 8);
master_setpoint = data(:, 9);

% Import Model Data
time_model = table2array(modelData(:,1));
mass_flow_f_model = table2array(modelData(:,2)) * 22045.89; % Convert m_dot_ox to SLPM
mass_flow_model = mass_flow_f_model + 500; %SLPM
pressure_model = table2array(modelData(:,7));
force_model = table2array(modelData(:,10));
isp_model = table2array(modelData(:,11));
Cstar_model = table2array(modelData(:,5));
OF_model = table2array(modelData(:,3));

% Model Offset
model_time_offset = 252.175+31;
%time_model = time_model + model_time_offset; % Apply time offset
time = time - model_time_offset;

% Experimental Data Calculated
A_th = 7.782e-4 + 0.491; % function for throat area w.r.t. time
isp = force ./ mass_flow; % Eqn 2.29
Cstar = pressure * A_th ./ (mass_flow* 4.4945e-5); % Eqn 2.26 % convert SLPM to lb/s

% Create a figure with 2x2 subplots
figure;

% Plot 1: Flowrate vs Time
subplot(3, 2, 1);
plot(time, mass_flow, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, mass_flow_model, 'r-', 'LineWidth', 1.5); % Model solid line
plot(time, master_setpoint, 'g:', 'LineWidth', 1.0); % Experimental dotted line
xlabel('Time (s)');
ylabel('m_d_o_t (SLPM)');
title('Flowrate vs Time');
legend('Experimental', 'Model', 'Master Setpoint', 'Location', 'best');
xlim([0, 12.5]);
ylim([0, max(max(mass_flow), max(mass_flow_model)) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Plot 2: Pressure vs Time
subplot(3, 2, 2);
plot(time, pressure, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, pressure_model, 'r-', 'LineWidth', 1.5); % Model solid line
xlabel('Time (s)');
ylabel('Pressure (psi)');
title('Pressure vs Time');
legend('Experimental', 'Model', 'Location', 'best');
xlim([0, 12.5]);
ylim([0, max(max(pressure), max(pressure_model)) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Plot 3: Force vs Time
subplot(3, 2, 3);
plot(time, force, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, force_model, 'r-', 'LineWidth', 1.5); % Model solid line
xlabel('Time (s)');
ylabel('Force (lbf)');
title('Force vs Time');
legend('Experimental', 'Model', 'Location', 'best');
xlim([0, 12.5]);
ylim([min(force)*1.2, max(max(force), max(force_model)) * 1.2]); % Adjust Y-axis
grid on;
hold off;

% Plot 4: Isp vs Time
subplot(3, 2, 4);
plot(time, isp, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, isp_model, 'r', 'LineWidth', 1.5); % Model solid line
xlabel('Time (s)');
ylabel('Isp (s)');
title('Isp vs Time');
xlim([0, 12.5]);
ylim([0, max(isp) * 1.2]);
grid on;
hold off;

% Plot 4: Cstar vs Time
subplot(3, 2, 5);
plot(time, Cstar, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, Cstar_model, 'r', 'LineWidth', 1.5); % Model solid line
xlabel('Time (s)');
ylabel('Cstar (in/s)');
title('Cstar vs Time');
xlim([0, 12.5]);
ylim([0, max(Cstar) * 1.2]);
grid on;
hold off;

% Adjust layout
sgtitle('Rocket Parameters vs Time');
