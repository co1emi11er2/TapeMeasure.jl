mutable struct BottomDimensions{T, S}
    xs::Vector{T}
    ys::Vector{S}
    labels::Labels{T, S}
    minor_lines::Vector{S}
    major_lines::Vector{S}
end


function dim_bottom(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_x = max(xs...)
    min_x = min(xs...)
    min_y = min(ys...)
    
    if offset == zero(S)
        offset = (max_x - min_x) * -0.1
    end
    
    x_dims = [min_x, max_x]
    y_dims = [min_y, min_y] .+ offset 

    major_lines, minor_lines = get_major_minor_lines(x_dims, offset)

    labels = dimension_labels(x_dims, y_dims)

    if offset >= zero(S)
        return TopDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return BottomDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end