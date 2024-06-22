# readILA.m

This MATLAB script is designed to read complex data from a CSV file named "waveform.csv", process it, and assemble it into complex numbers. The script is particularly useful for processing waveform data, where each data point consists of an imaginary and a real part.

## How it works

1. **Initialization**: The script starts by setting up the number of columns and data points to be processed. It then specifies the file path and name of the CSV file to be read.

2. **Reading the CSV File**: The script uses `detectImportOptions` to specify which columns to read from the CSV file. The columns selected are "data2CFO_TVALID", "data2CFO_TDATA_im", and "data2CFO_TDATA_re". The data type for these columns is set to 'string'.

3. **Data Processing**:
   - The script reads the specified columns from the CSV file into a table.
   - It initializes arrays for storing the new data and the complex numbers.
   - It iterates through each row of the table. For each row, it checks if the TVALID signal is high (1). The TREADY signal is assumed to be always high (1) in this script.
   - For each valid data row, it processes the TDATA fields for both the imaginary and real parts. This involves:
     - Extracting 4 hex characters at a time.
     - Converting the extracted hex string to decimal.
     - Checking if the number is negative and converting it to a signed 16-bit integer.
     - Storing the processed data in an array.

4. **Complex Number Assembly**: The script assembles the processed data points into complex numbers, where each number consists of an imaginary and a real part.

## Usage

To use this script, simply run it in MATLAB. Ensure that the CSV file "waveform.csv" is in the same directory as the script or adjust the file path accordingly.

## Requirements

This script requires MATLAB to run.

## Note

This script is tailored for waveform data processing, where each data point in the CSV file has an imaginary and a real part. The TVALID signal is used to determine if the data is valid for processing. The TREADY signal is assumed to be always high (1) in this script, simplifying the control flow for data transfer.
