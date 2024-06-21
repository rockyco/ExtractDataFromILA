# readILA.m

This MATLAB script is designed to read data from a CSV file, process it, and save the processed data into a .mat file. The script specifically handles data related to the AMD/Xilinx Vivado ILA (Integrated Logic Analyzer).

## How it works

1. The script first specifies the file path and name of the CSV file to be read. The file in this case is "iladata_evm_bad3.csv".

2. It then specifies the columns to be read from the CSV file. The columns are "rx_out0_TVALID", "rx_out0_TREADY", and "rx_out0_TDATA".

3. The CSV file is read and the data is stored in a table.

4. The script then initializes some variables and arrays to store the processed data.

5. It then loops through each row of the data. For each row, it checks if the TVALID and TREADY values are both 1. If they are, it processes the TDATA value.

6. The TDATA value is a hexadecimal string. The script extracts 4 hex characters at a time, converts them to decimal, checks if the number is negative, and then converts it to a signed 16-bit number.

7. The processed data is stored in an array and then converted into a complex number.

8. The script then removes any unused elements from the array of complex numbers.

9. Finally, it displays the processed data and saves it to a .mat file named "iladata_evm_bad3.mat".

## Usage

To use this script, simply run it in MATLAB. Ensure that the CSV file "iladata_evm_bad3.csv" is in the same directory as the script or adjust the file path accordingly.

## Requirements

This script requires MATLAB to run.

## Note

This script only processes the TVALID, TREADY, and TDATA signals. It does not process the TUSER and TLAST signals. TVALID and TREADY are interface signals of the AXI-Stream channel. TVALID is driven by the source (master) side of the channel and indicates that the value in the payload field (TDATA) is valid. TREADY is driven by the receiver (slave) and indicates that the slave is ready to receive data. When both TVALID and TREADY are TRUE in a cycle, a transfer occurs. The master and slave set TVALID and TREADY respectively for the next transfer appropriately.
