import numpy as np

rho_HTPB = 14.765  #g/in^3
rho_MDI = 20.00 # g/in^3

# Geometry
diameter_casing = 1.215# in
length_casing = 11.25 # in
diameter_port = 0.5# in

V_fuel =  np.pi * diameter_casing**2 * length_casing /4 - np.pi * diameter_port**2 * length_casing /4 

m_HTPB = V_fuel * 0.87 * rho_HTPB
m_MDI = V_fuel * 0.13 * rho_MDI

print(f"Mass HTPB = {m_HTPB} g ")
print(f"Mass MDI = {m_MDI} g")
