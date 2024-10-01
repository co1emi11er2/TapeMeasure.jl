# ----------------
# multi-object plot format check
# ----------------

let 
    
    xs = [-2.5ft, -2.5ft, -2.5ft, -2.5ft, -2.5ft]
    ys = [4.0ft, 12.0ft, 20.0ft, 28.0ft, 36.0ft]
    lbl_xs = [-2.5ft, -2.5ft, -2.5ft, -2.5ft]
    lbl_ys = [8.0ft, 16.0ft, 24.0ft, 32.0ft]
    lbls = ["8.0 ft", "8.0 ft", "8.0 ft", "8.0 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)

    # check without offset
    minor_lines = major_lines = [0.4ft]
    expected = RightDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = v_dimension(multi_girders_ys_plot_format, multi_girders_xs_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    xs .+= 5ft
    lbl_xs .+= 5ft
    major_lines = [4.5ft]
    expected = RightDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = v_dimension(multi_girders_ys_plot_format, multi_girders_xs_plot_format, offset=5ft)
    test_dimension_fields(expected, calc)
    
end