function infoGain = calcEntThresh(data,dataClass,threshVal)

    % identify if data is in current orientation
    is_data_row = isrow(data);
    if is_data_row==1
        data=data';
    end
    
    % identify if dataClass is in current orientation
    is_dataClass_row = isrow(dataClass);
    if is_dataClass_row==1
        dataClass=dataClass';
    end

    % Sort data and dataClass
    [tempSorted, sortIdxes] = sort(data,1,'ascend');
    data_sorted = data(sortIdxes,:);
    class_sorted = dataClass(sortIdxes,:);
    
    % Convert to categorical
    class_sorted = categorical(class_sorted); 
    dataClass = categorical(dataClass);
    
    totalEnt = calcEnt(dataClass,0); % Initialise total Entropy using function
    class_list = categories(dataClass); % Defines the categories in dataClass
    
    nData = size(dataClass,1); % Size of data in dataClass
    nClasses = size(class_list,1); % Number of classes in class_list

    for j=1:nData
        % if data_sorted is above the threshold value initialise to allow
        % for calculation of above and below split
        if data_sorted(j) >= threshVal 
            data_sorted(j)=1;
        else
            data_sorted(j)=0;
        end

        % if data_sorted is calculated as zero infoGain is zero 
        if data_sorted(j) == 0
            infoGain=0;
        end
    end


    for i=2:nData
        if  data_sorted(i) ~= data_sorted(i-1) % if previous result switches number

            % Conditional Entropy Above from i to end of array
            DataSortedAbove = data_sorted(i:end); 
            ClassSortedAbove = class_sorted(i:end);
            NumberDataAbove = numel(DataSortedAbove); %no. of data sorted above 
            
            % Calculate Entropy Above using entropy function
            EntValAbove = calcEnt(ClassSortedAbove,0); 


            % Conditional Entropy Above from 1 to i-1 of array
            DataSortedBelow = data_sorted(1:i-1);
            ClassSortedBelow = class_sorted(1:i-1);
            NumberDataBelow = numel(DataSortedBelow); %no. of data sorted above

            % Calculate Entropy Above using entropy function
            EntValBelow = calcEnt(ClassSortedBelow,0);

            
            % Conditional Entropy for Above and Below
            ProbAbove = NumberDataAbove/nData; % probability calc. of Above
            ProbBelow = NumberDataBelow/nData; % probability calc. of Below
            condEnt = ProbAbove*EntValAbove + ProbBelow*EntValBelow;          

            %  display(probAbove)
            %  display(probBelow)
            %  display(condEnt)
            
            infoGain = totalEnt - condEnt; % InfoGain every iteration

        end
    end
end

