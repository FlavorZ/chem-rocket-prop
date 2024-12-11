import numpy as np
import pandas as pd

output_units = 'imperial'     # 'imperial' or 'metric'

## INITIAL PARAMETERS
# Propellant Properties
# Fuel: HTPB
a = 0.104 # in^2.362*s^0.319*lbm^(-0.681)
n = 0.681 # unitless

# Grain Geometry
R_0 = 0.25 # in
L = 11 # in
d_f = 1.24 # in

# Chamber Properties
v_dot_ox = 500 # SLPM
P_c = 165 # psi

# Nozzle Properties
d_throat = 0.25 # in
Area_ratio = 4
P_e = 15 # Psi to Pa: Estimated from plots and assume constant
g_0 = 9.81 # m/s^2
P_amb = 0.85 # atm


## Data from CAE
OF_ratio = [1, 
    1.5, 
    1.75, 
    2, 
    2.5, 
    3, 
    3.5, 
    4, 
    5
]
Gamma = [ 1.2754,
    1.2012,
    1.1617,
    1.1415,
    1.1287,
    1.125,
    1.1234,
    1.1226,
    1.1227
]
Cstar_metric = [ 1490.3,
    1739.3,
    1788.1,
    1793.7,
    1754.6,
    1706.8,
    1663.8,
    1626.2,
    1564
] # m/s

Cstar_imperial = [4888.184,
    5704.904,
    5864.968,
    5883.336,
    5755.088,
    5598.304,
    5457.264,
    5333.936,
    5129.92
] # ft/s

## UNITS & CONVERSION
if output_units == 'metric':
    mass_dim = 'kg'
    pressure_dim = 'Pa'
    Cstar = Cstar_metric
    in_to_m = 0.0254
    psi_to_pa = 6894.757
    atm_to_pa = 101325
    #Propellant Properties
    rho_fuel = 915.356161 # kg/m^3
    a = a * 0.00017069 * 1.71321 # m^2.362*s^0.319*kg^(-0.681)
    rho_ox = 1.4287 # kg/m^3
    m_dot_ox = v_dot_ox * (0.001 / 60) * rho_ox # kg/s
    #Grain Geometry
    R_0 = R_0 * in_to_m # m
    L = L * in_to_m # m
    d_throat = d_throat * in_to_m # m
    #Chamber Properties
    P_c = P_c * psi_to_pa # Pa
    P_e = P_e * psi_to_pa # Pa
    P_amb = P_amb * atm_to_pa # Pa
    
elif output_units == 'imperial':
    Cstar = Cstar_imperial
    g_0 = 386.1 # in/s^2
    #Propellant Properties
    rho_fuel = 0.033 # lbm/in^3
    m_dot_ox = (101219.16/((8314/32)*300))*v_dot_ox*(1/60000)*2.205 # lb/sec
    #Chamber Properties
    P_amb = P_amb * 14.696 # atm to psi
    mass_dim = 'lb'
    pressure_dim = 'psi'
else:
    print("Invalid output_units. Please choose 'imperial' or 'metric'.")
    exit()

## INITIAL PARAMETERS (CALCULATED)
#Grain Geometry
A_burn = 2 * np.pi * R_0 * L
A_port = np.pi * R_0**2
R_f = d_f/2
#Nozzle Properties
A_th = np.pi * d_throat**2 / 4
Area_ratio = 4
A_e = A_th*Area_ratio


## TRENDLINES from CAE
# Trendline for Gamma
Gamma_trend = np.polyfit(OF_ratio, Gamma, 4)
Gamma_trendline = np.poly1d(Gamma_trend)

# Trendline for Cstar
Cstar_trend = np.polyfit(OF_ratio, Cstar, 5)
Cstar_trendline = np.poly1d(Cstar_trend)


## EQUATIONS w.r.t.
time = np.arange(0, 60.1, 0.1)

# Mass Fuel Flow Rate 
m_dot_f = 2*np.pi**(1-n)*rho_fuel*L*a*m_dot_ox**n*((2*n+1)*a*(m_dot_ox/np.pi)**n*time+R_0**(2*n+1))**((1-2*n)/(2*n+1))

# O/F Ratio
OF_ratio_t = m_dot_ox/m_dot_f

# C* Trend
Cstar_t = Cstar_trendline(OF_ratio_t) # m/s

# Gamma Trend
Gamma_t = Gamma_trendline(OF_ratio_t) # unitless

# Chamber Pressure
P_c_t = (m_dot_f + m_dot_ox)*Cstar_t/(A_th*g_0)

# Thrust Coefficient 1
Cf0 = np.sqrt(2*Gamma_t**2/(Gamma_t-1)*(2/(Gamma_t+1))**((Gamma_t+1)/(Gamma_t-1))*(1-(P_e/P_c)**((Gamma_t-1)/Gamma_t)))

# Thrust Coefficient 2
Cf = Cf0 + (P_e-P_amb)/(P_c_t*(A_e/A_th))

#Thrust
thrust = Cf * P_c_t / A_th

# Isp
isp = Cstar_t * Cf / g_0

# Burn Rate and Port Radius Initial
r_dot = [a * (m_dot_ox/np.pi*R_0**2)**n]
r_port = [R_0]

for t in time[1:]:
    r_port.append(r_port[-1] + r_dot[-1] * 0.1)
    r_dot.append(a * (m_dot_ox/np.pi*r_port[-1]**2)**n)


# Make a table of arrays using pandas
data = {
    'Time (s)': time,
    'Mass Flow Rate Fuel (kg/s)': m_dot_f,
    'OF Ratio': OF_ratio_t,
    'C* (m/s)': Cstar_t,
    'Gamma': Gamma_t,
    'Chamber Pressure (Pa)': P_c_t,
    'Cf0': Cf0,
    'Thrust Coefficient': Cf,
    'Thrust (N)': thrust,
    'Isp (s)': isp,
    'Burn Rate (m/s)': r_dot,
    'Port Radius (m)': r_port
}

df = pd.DataFrame(data)
#print(df)
df.to_csv('output.csv', index=False)

print('Output file units:', str.upper(output_units))
print(f'Geometry:\nR_0: {R_0:.4f} {mass_dim}\nL: {L:.4f} {mass_dim}\nd_f: {d_f:.4f} {mass_dim}\n')
print(f'Chamber Parameters:\nm_dot_ox: {m_dot_ox:.4f} {mass_dim}/s\nP_c: {P_c:.4f} {pressure_dim}\n')
print(f'Nozzle Parameters:\nd_throat: {d_throat:.4f} {mass_dim}\nArea Ratio: {Area_ratio}\nP_e: {P_e:.4f} {pressure_dim}\n')
