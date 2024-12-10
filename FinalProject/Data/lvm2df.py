import pandas as pd

def clean_lvm(file_path):
    """
    Cleans an LVM file by removing the first 23 rows and stores the remaining data as a pandas DataFrame.
    """
    try:
        # Skip the first 23 rows and load the data
        data = pd.read_csv(file_path, skiprows=22, delimiter="\t", header=None)
        # Set the first row as the header
        data.columns = data.iloc[0]
        data = data[1:].reset_index(drop=True)
        # Convert data to numeric, forcing errors to NaN
        data = data.apply(pd.to_numeric, errors='coerce')
        return data
    except Exception as e:
        print(f"Error processing file {file_path}: {e}")
        return None

path = 'TeamYellow_1.lvm'
# Clean the LVM files and store them in a dictionary of DataFrames
df = clean_lvm(path)

print(df)