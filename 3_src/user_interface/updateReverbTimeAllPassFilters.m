function updateReverbTimeAllPassFilters(hObject,apfIndex)
    global tr_apfs;
  if apfIndex > length(tr_apfs);
    errordlg("Invalid input");
    return;
  else
    text_value = get(hObject, "string");
    apf_loop_time = str2double(text_value);
    
    if isnan(apf_loop_time)
        % Display an error message if the input is not a valid number
        errordlg("Invalid input! Please enter a valid number.", "Error");
        % Reset the edit box to empty
        
        return;
     else
        tr_apfs(apfIndex) = apf_loop_time;
    endif
   endif
  endfunction