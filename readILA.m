COL_NUM = 2; % Number of columns to assemble the complex data
DAT_NUM = 1; % Number of data points in each column
% Specify the file path and name
opts = detectImportOptions("waveform.csv"); 

% Specify the columns and rows you want to read
opts.SelectedVariableNames = ["data2CFO_TVALID", "data2CFO_TDATA_im", "data2CFO_TDATA_re"];
opts = setvartype(opts, 'string');

% Read the CSV file
data = readtable("waveform.csv", opts);
newData = zeros(2);
compxData = complex(zeros(size(data,1), 1));
j = 1;
for i = 1:size(data, 1) % Iterate through the rows of the data
    a = str2double(data{i,1}); % TVALID 
    % b = str2double(data{i,2}); % TREADY
    b = 1;
    if (a == 1 && b == 1) % TVALID and TREADY are both high
        for m = 1:COL_NUM % Iterate through the columns
            tmp = data{i, m+1}; % TDATA
            % Extract the 16-bit data
            for k = 1:DAT_NUM % Iterate through the data points
                str = extractBetween(tmp, 4*(k-1)+1, 4*k); % Extract 4 hex characters
                xdat = hex2dec(str); % Convert to decimal
                isNegative = int16(bitget(xdat, 16)); % Check if the number is negative
                convertedValue = int16(bitset(xdat,16,0)) + (-2^15)*isNegative; % Convert to signed 16-bit
                newData((m-1)*DAT_NUM + k) = convertedValue; % Store the data
            end
        end
        compxData(j) = complex(newData(2), newData(1)); % Store the complex data
        j = j + 1; % Increment the index of the complex data array
    end
end

compxData = compxData(1:j-1, :).'; % Remove the unused elements


% Display the data
disp(compxData);
% Save the data to a .mat file
save("waveform2CFO.mat", "compxData"); 