#TODO: fix
function h_dimension(xs::Vector{Vector{Point(T, S)}}; offset = zero(S)) where {T, S}

    x_dims, y_mid = _dimensions(xs, ys)

    # ensure y_dims values are either maximum or minimum
    max_or_min = offset >= zero(S) ? max : min
    y_max_or_min = max_or_min(y_mid...) + offset
    y_dims = [y_max_or_min for _ in y_mid]

    major_lines, minor_lines = _get_major_minor_lines(x_dims, y_mid, y_max_or_min)

    labels = _dimension_labels(x_dims, y_dims)
    if offset >= zero(S)
        return TopDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return BottomDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end