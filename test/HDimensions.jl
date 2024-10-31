# ----------------
# multi-object plot format check
# ----------------

let 
    spa = 8.0ft
    xs = [4.0ft, 12.0ft, 20.0ft, 28.0ft, 36.0ft]
    ys = [-2.5ft, -2.5ft, -2.5ft, -2.5ft, -2.5ft]
    lbl_xs = [8.0ft, 16.0ft, 24.0ft, 32.0ft]
    lbl_ys = [-2.5ft, -2.5ft, -2.5ft, -2.5ft]
    lbls = ["8.0 ft", "8.0 ft", "8.0 ft", "8.0 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)

    # check without offset
    minor_lines = major_lines = [0.4ft for _ in xs]
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, 0.0ft)
    calc = h_dimension(multi_girders_xs_plot_format, multi_girders_ys_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    ys .+= 5ft
    lbl_ys .+= 5ft
    major_lines = [5.0ft for _ in xs]
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, 5.0ft)
    calc = h_dimension(multi_girders_xs_plot_format, multi_girders_ys_plot_format, offset=5ft)
    test_dimension_fields(expected, calc)

    # check with offset of -5ft
    ys .-= 10ft
    lbl_ys .-= 10ft
    major_lines = [5.0ft for _ in xs]
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, -5.0ft)
    calc = h_dimension(multi_girders_xs_plot_format, multi_girders_ys_plot_format, offset=-5ft)
    test_dimension_fields(expected, calc)
    
end


# ----------------
# single-object plot format check
# ----------------

let 
    xs = [2.5ft, 5.5ft]
    ys = [0.050000000000000044ft, 0.050000000000000044ft]
    lbl_xs = [4.0ft]
    lbl_ys = [0.050000000000000044ft]
    lbls = ["3.0 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)

    # check without offset
    minor_lines = [0.15000000000000002ft for _ in xs]
    major_lines = [0.2700000000000001ft for _ in xs]
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, 0.30000000000000004ft)
    calc = dim_top(single_girder_xs_plot_format, single_girder_ys_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    ys = [4.75ft, 4.75ft]
    lbl_ys = [4.75ft]
    major_lines = [4.5ft for _ in xs]
    labels = Labels(lbl_xs, lbl_ys, lbls)
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, 5.0ft)
    calc = dim_top(single_girder_xs_plot_format, single_girder_ys_plot_format, offset=5ft)
    test_dimension_fields(expected, calc)
    
end


# ----------------
# single-object plot format check
# ----------------

let 
    xs = [2.5ft, 5.5ft]
    ys = [-5.050000000000000044ft, -5.050000000000000044ft]
    lbl_xs = [4.0ft]
    lbl_ys = [-5.050000000000000044ft]
    lbls = ["3.0 ft"]
    labels = Labels(lbl_xs, lbl_ys, lbls)

    # check without offset
    minor_lines = [0.15000000000000002ft for _ in xs]
    major_lines = [0.2700000000000001ft for _ in xs]
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, -0.30000000000000004ft)
    calc = dim_bottom(single_girder_xs_plot_format, single_girder_ys_plot_format)
    test_dimension_fields(expected, calc)

    # check with offset of 5ft
    ys = [-9.75ft, -9.75ft]
    lbl_ys = [-9.75ft]
    major_lines = [4.5ft for _ in xs]
    labels = Labels(lbl_xs, lbl_ys, lbls)
    expected = HDimensions(xs, ys, labels, minor_lines, major_lines, -5.0ft)
    calc = dim_bottom(single_girder_xs_plot_format, single_girder_ys_plot_format, offset=-5ft)
    test_dimension_fields(expected, calc)
end