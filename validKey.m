function valid = validKey(inputKey)
    validKeys = ['1!', '2@', '3#', '4$'];
    if ismember(inputKey, validKeys)
        valid = true;
    else 
        valid = false;
    end
end
