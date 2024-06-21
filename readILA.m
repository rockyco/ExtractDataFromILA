% Specify the file path and name
opts = detectImportOptions("iladata_evm_bad3.csv"); 

% Specify the columns and rows you want to read
opts.SelectedVariableNames = ["rx_out0_TVALID", "rx_out0_TREADY", "rx_out0_TDATA"];
opts = setvartype(opts, 'string');

% Read the CSV file
data = readtable("iladata_evm_bad3.csv", opts);
newData = zeros(2);
compxData = complex(zeros(size(data,1), 1));
j = 1;
for i = 1:size(data, 1)
    a = str2double(data{i,1}); % TVALID 
    b = str2double(data{i,2}); % TREADY
    if (a == 1 && b == 1) % TVALID and TREADY are both high
        tmp = data{i,3}; % TDATA
        % Extract the 16-bit data
        for k = 1:2
            str = extractBetween(tmp, 4*(k-1)+1, 4*k); % Extract 4 hex characters
            xdat = hex2dec(str); % Convert to decimal
            isNegative = int16(bitget(xdat, 16)); % Check if the number is negative
            convertedValue = int16(bitset(xdat,16,0)) + (-2^15)*isNegative; % Convert to signed 16-bit
            newData(k) = convertedValue; % Store the data
        end
        compxData(j) = complex(newData(2), newData(1)); % Store the complex data
        j = j + 1; % Increment the index of the complex data array
    end
end

compxData = compxData(1:j-1, :).'; % Remove the unused elements


% Display the data
disp(compxData);
% Save the data to a .mat file
save("iladata_evm_bad3.mat", "compxData"); 