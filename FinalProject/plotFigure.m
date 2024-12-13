reload = true;

if reload == true
    clear all
    clc

    % Team number - Select an integer 1-5
    teamnum = 1;

    % Load Data
    file = "Data/Team" + string(teamnum) + ".lvm";
    team = lvm_import("Data/Team" + string(teamnum) + ".lvm", 0);
    modelData = readtable('Data/CleanedModel.xlsx'); % Load simulated data
    data = team.Segment1.data; % Load Experimental Data
end

g_c = 32.474; % ft/s^2
time_frames = [283.175 12.5; 30 12.5; 27.5 14; 166 14; 53.3 14];

% Import Experimental Data
time = data(:, 1); 
mass_ox_flow = data(:, 4) * 4.4945e-5; % Convert from SLPM to lb/s
pressure = data(:, 5); % psi
force = data(:, 8); % lbf
master_setpoint = data(:, 9) * 4.4945e-5; % SLPM to lb/s

% Import Model Data
time_model = table2array(modelData(:,1));
mass_flow_f_model = table2array(modelData(:,2));
mass_flow_model = mass_flow_f_model + (500 * 4.4945e-5); % converts SLPM to lb/s
pressure_model = table2array(modelData(:,7));
force_model = table2array(modelData(:,10));
isp_model = table2array(modelData(:,11));
Cstar_model = table2array(modelData(:,5));
OF_model = table2array(modelData(:,3));

% Experimental Data Calculated
A_th = 7.782e-4 + 0.491; % function for throat area w.r.t. time
isp = force ./ (mass_ox_flow * g_c); % Eqn 2.29
Cstar = pressure * A_th ./ mass_ox_flow * 12; % Eqn 2.26 % Convert ft to in

% Model Offset
experiment_start_time = time_frames(teamnum,1);
experiment_duration = time_frames(teamnum,2);
time = time - experiment_start_time;

% Create a figure with 2x2 subplots
figure;

% Plot 1: Flowrate vs Time
subplot(3, 2, 1);
plot(time, mass_ox_flow, 'b:', 'LineWidth', 1.5); % Experimental dotted line
hold on;
plot(time_model, mass_flow_model, 'r-', 'LineWidth', 1.5); % Model solid line
plot(time, master_setpoint, 'g:', 'LineWidth', 1.5); % Experimental dotted line
xlabel('Time (s)');
ylabel('m_d_o_t (lb/s)');
title('Flowrate vs Time');
legend('Experimental', 'Model', 'Master Setpoint', 'Location', 'best');
xlim([0, experiment_duration]);
ylim([0, max(max(mass_ox_flow), max(mass_flow_model)) * 1.2]); % Adjust Y-axis
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
xlim([0, experiment_duration]);
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
xlim([0, experiment_duration]);
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
xlim([0, experiment_duration]);
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
xlim([0, experiment_duration]);
ylim([0, max(Cstar_model) * 1.2]);
grid on;
hold off;

sgtitle("Team "+ string(teamnum))