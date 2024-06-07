function updateWetDryLevel(hObject, ~)
    global wet_dry_level;

    wet_dry_level = get(hObject, "value");
    disp("wet level:");
    disp(wet_dry_level);
endfunction