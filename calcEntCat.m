function infoGain = calcEntCat(data, dataClass, targetCatVals)

is_data_row = isrow(data);
if is_data_row==1
  data=data';
end

is_dataClass_row = isrow(dataClass);
if is_dataClass_row==1
  dataClass=dataClass';
end


[tempSorted, sortIdxes] = sort(data,1,'ascend');
data_sorted = data(sortIdxes,:);
class_sorted = dataClass(sortIdxes,:);
class_sorted = categorical(class_sorted);

dataClass = categorical(dataClass);
totalEnt = calcEnt(dataClass,0);
class_list = categories(dataClass);
nData = size(dataClass,1);
nClasses = size(class_list,1);

data_categorised=zeros(1,9);


for j=1:nData
    data_categorised(j)=ismember(data_sorted(j),targetCatVals);
end


for i=2:nData
    if  data_categorised(i) ~= data_categorised(i-1)
        
        % Specific Conditional Entropy Above
        data_sorted_above = data_sorted(i:end);
        class_sorted_above = class_sorted(i:end);
        numberDataAbove = numel(data_sorted_above);
        
        ent_val_above = calcEnt(class_sorted_above,0);
        
        
        % Specific Conditional Entropy Below
        data_sorted_below = data_sorted(1:i-1);
        class_sorted_below = class_sorted(1:i-1);
        numberDataBelow = numel(data_sorted_below);
        
        ent_val_below = calcEnt(class_sorted_below,0);
        
        probAbove = numberDataAbove/nData;
        probBelow = numberDataBelow/nData;
        condEnt = probAbove*ent_val_above + probBelow*ent_val_below;          

        infoGain = totalEnt - condEnt;
    end
        
end

end