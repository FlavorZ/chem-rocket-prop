from lvm2df import clean_lvm
import matplotlib.pyplot as plt
import pandas as pd

file_path = ['TeamYellow_1.lvm', 'Blue_2.lvm', 'FestiveGreen.lvm', 'TeamRed.lvm','Team5.lvm']

team1 = clean_lvm(file_path[0])
team2 = clean_lvm(file_path[1])
team3 = clean_lvm(file_path[2])
team4 = clean_lvm(file_path[3])
team5 = clean_lvm(file_path[4])

def plot_columns(df, col1, col2):
    plt.figure(figsize=(10, 6))
    plt.plot(df[col1], df[col2], marker='o')
    plt.xlabel(col1)
    plt.ylabel(col2)
    plt.title(f'{col1} vs {col2}')
    plt.grid(True)
    plt.show()

start_time = 280
end_time = 295

#plot_columns(team1, 'Time', 'Master_Setpoint')
fig, axs = plt.subplots(3, 1, figsize=(10, 18))

axs[0].plot(team1[(team1['Time'] > start_time) & (team1['Time'] < end_time)]['Time'], 
            team1[(team1['Time'] > start_time) & (team1['Time'] < end_time)]['Master_Setpoint'], marker='o')
axs[0].set_xlabel('Time')
axs[0].set_ylabel('Master_Setpoint')
axs[0].set_title('Time vs Master_Setpoint')
axs[0].grid(True)

axs[1].plot(team1[(team1['Time'] > start_time) & (team1['Time'] < end_time)]['Time'], 
            team1[(team1['Time'] > start_time) & (team1['Time'] < end_time)]['Pressure'], marker='o')
axs[1].set_xlabel('Time')
axs[1].set_ylabel('Pressure')
axs[1].set_title('Time vs Pressure')
axs[1].grid(True)

axs[2].plot(team1[(team1['Time'] > start_time) & (team1['Time'] < end_time)]['Time'], 
            team1[(team1['Time'] > start_time) & (team1['Time'] < end_time)]['Thrust Input'], marker='o')
axs[2].set_xlabel('Time')
axs[2].set_ylabel('Thrust')
axs[2].set_title('Time vs Thrust')
axs[2].grid(True)

plt.tight_layout()
plt.show()