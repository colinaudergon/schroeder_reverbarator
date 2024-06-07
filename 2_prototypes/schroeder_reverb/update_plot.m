function update_plot (obj, init = false)
  ## gcbo holds the handle of the control
  h = guidata (obj);
  replot = false;
  recalc = false;
  switch (gcbo)
    case {h.print_pushbutton}
      fn =  uiputfile ("*.png");
      print (fn);
    case {h.grid_checkbox}
      v = get (gcbo, "value");
      grid (merge (v, "on", "off"));
    case {h.minor_grid_toggle}
      v = get (gcbo, "value");
      grid ("minor", merge (v, "on", "off"));
    case {h.plot_title_edit}
      v = get (gcbo, "string");
      set (get (h.ax, "title"), "string", v);
    case {h.linecolor_radio_blue}
      set (h.linecolor_radio_red, "value", 0);
      replot = true;
    case {h.linecolor_radio_red}
      set (h.linecolor_radio_blue, "value", 0);
      replot = true;
    case {h.linestyle_popup, h.markerstyle_list}
      replot = true;
    case {h.noise_slider}
      recalc = true;
  endswitch

  if (recalc || init)
    x = linspace (-4, 9);
    noise = get (h.noise_slider, "value");
    set (h.noise_label, "string", sprintf ("Noise: %.1f%%", noise * 100));
    y = h.fcn (x) + 5 * noise * randn (size (x));
    if (init)
      h.plot = plot (x, y, "b");
      guidata (obj, h);
    else
      set (h.plot, "ydata", y);
    endif
  endif

  if (replot)
    cb_red = get (h.linecolor_radio_red, "value");
    lstyle = get (h.linestyle_popup, "string"){get (h.linestyle_popup, "value")};
    lstyle = strtrim (lstyle(1:2));

    mstyle = get (h.markerstyle_list, "string"){get (h.markerstyle_list, "value")};
    if (strfind (mstyle, "none"))
      mstyle = "none";
    else
      mstyle = mstyle(2);
    endif
  
    set (h.plot, "color", merge (cb_red, [1 0 0 ], [0 0 1]),
                 "linestyle", lstyle,
                 "marker", mstyle);
  endif
  
endfunction