function totalEnt = calcEnt(dataClass, calcEnt)

    % identify if dataClass is in current orientation
    is_data_row = isrow(dataClass);
    if is_data_row==1
        dataClass=dataClass';
    end

    totalEnt=0; %pre-allocate total entropy to zero

    class_list = categories(dataClass); % Defines the categories in dataClass
    calcEnt=class_list; % Initialise to class_list
    nClasses = size(class_list,1); % Number of classes in class_list
    nData = size(dataClass,1); % Size of data in dataClass

    % for loop for all classes
    for i = 1:nClasses
        testClass = class_list(i); 
        numClass = nnz(dataClass == testClass); % Number of Non-Zero classes
        probClass = numClass/nData; % Calculate probability

        ent_current = -1*probClass * log2(probClass); % Calculate current entropy

        if probClass == 0 % If probability zero, entropy is equal to zero
            ent_current = 0;
        end

        totalEnt = totalEnt+ent_current; % total Entropy allocated every iteration
    end
    
end

