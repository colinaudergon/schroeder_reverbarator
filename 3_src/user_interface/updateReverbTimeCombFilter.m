function updateReverbTimeCombFilter(hObject,~)
  %convert text to value
  text_value = get(hObject, "string");
  cbf_reverb_time = str2double(text_value);
   
   if isnan(cbf_reverb_time)
        % Display an error message if the input is not a valid number
        errordlg("Invalid input! Please enter a valid number.", "Error");
        % Reset the edit box to empty
        set(hObject, "string", "");
        return;
    else
        global tr_cmf;
        tr_cmf = cbf_reverb_time;
    endif
endfunction