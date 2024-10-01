# ----------------
# multi-object plot format check
# ----------------

let 
    xs = [4.0ft, 12.0ft, 20.0ft, 28.0ft, 36.0ft]
    ys = [-2.5ft, -2.5ft, -2.5ft, -2.5ft, -2.5ft]
    lbl_xs = [8.0ft, 16.0ft, 24.0ft, 32.0ft]
    lbl_ys = [-2.5ft, -2.5ft, -2.5ft, -2.5ft]
    lbls = ["8.0 ft", "8.0 ft", "8.0 ft", "8.0 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)
    minor_lines = major_lines = [0.4ft]

    # check with offset of 5ft
    ys .-= 5ft
    lbl_ys .-= 5ft
    major_lines = [4.5ft]
    expected = BottomDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = h_dimension(multi_girders_xs_plot_format, multi_girders_ys_plot_format, offset=-5ft)
    test_dimension_fields(expected, calc)
    
end