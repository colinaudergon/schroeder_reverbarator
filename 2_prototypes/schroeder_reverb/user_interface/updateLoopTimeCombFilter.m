function updateLoopTimeCombFilter(hObject,cbfIndex)
  global tl_cmfs;
  if cbfIndex > length(tl_cmfs);
    errordlg("Invalid input");
    return;
  else
    text_value = get(hObject, "string");
    cbf_loop_time = str2double(text_value);
    
    if isnan(cbf_loop_time)
        % Display an error message if the input is not a valid number
        errordlg("Invalid input! Please enter a valid number.", "Error");
        % Reset the edit box to empty
        set(hObject, "string", "");
        return;
     else
        
        tl_cmfs(cbfIndex) = cbf_loop_time;
    endif
  endif
  
endfunction