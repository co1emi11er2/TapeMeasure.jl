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
    minor_lines = major_lines = [0.4ft for _ in xs]
    expected = VDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = v_dimension(multi_girders_ys_plot_format, multi_girders_xs_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    xs .+= 5ft
    lbl_xs .+= 5ft
    major_lines = [5.0ft for _ in xs]
    expected = VDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = v_dimension(multi_girders_ys_plot_format, multi_girders_xs_plot_format, offset=5ft)
    test_dimension_fields(expected, calc)
    
end


# ----------------
# single-object plot format check
# ----------------

let 
    xs = [5.95ft, 5.95ft]
    ys = [-0.25ft, -4.75ft]
    lbl_xs = [5.95ft]
    lbl_ys = [-2.5ft]
    lbls = ["4.5 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)

    # check without offset
    minor_lines = [0.225ft for _ in xs]
    major_lines = [0.405ft for _ in xs]
    expected = VDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = dim_right(single_girder_xs_plot_format, single_girder_ys_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    xs = [10.5ft, 10.5ft]
    lbl_xs = [10.5ft]
    major_lines = [4.5ft for _ in xs]
    labels = Labels(lbl_xs, lbl_ys, lbls)
    expected = VDimensions(xs, ys, labels, minor_lines, major_lines)
    calc = dim_right(single_girder_xs_plot_format, single_girder_ys_plot_format, offset=5ft)
    test_dimension_fields(expected, calc)
    
end

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
    minor_lines = major_lines = [0.4ft for _ in xs]
    expected = VDimensions(xs, ys, labels, major_lines, minor_lines)
    calc = v_dimension(multi_girders_ys_plot_format, multi_girders_xs_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    xs .-= 5ft
    lbl_xs .-= 5ft
    major_lines = [5.0ft for _ in xs]
    expected = VDimensions(xs, ys, labels, major_lines, minor_lines)
    calc = v_dimension(multi_girders_ys_plot_format, multi_girders_xs_plot_format, offset=-5ft)
    test_dimension_fields(expected, calc)
    
end

# ----------------
# single-object plot format check
# ----------------

let 
    xs = [2.05ft, 2.05ft]
    ys = [-0.25ft, -4.75ft]
    lbl_xs = [2.05ft]
    lbl_ys = [-2.5ft]
    lbls = ["4.5 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)

    # check without offset
    minor_lines = [0.225ft for _ in xs]
    major_lines = [0.405ft for _ in xs]
    expected = VDimensions(xs, ys, labels, major_lines, minor_lines)
    calc = dim_left(single_girder_xs_plot_format, single_girder_ys_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    xs = [-2.5ft, -2.5ft]
    lbl_xs = [-2.5ft]
    major_lines = [4.5ft for _ in xs]
    labels = Labels(lbl_xs, lbl_ys, lbls)
    expected = VDimensions(xs, ys, labels, major_lines, minor_lines)
    calc = dim_left(single_girder_xs_plot_format, single_girder_ys_plot_format, offset=-5ft)
    test_dimension_fields(expected, calc)
    
end