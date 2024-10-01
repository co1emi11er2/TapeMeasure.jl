struct LeftDimensions
    xs
    ys
    labels
    minor_lines
    major_lines
end

@recipe function f(dims::LeftDimensions; with_mask=true, dim_color=:black)
    
    legend := false

    # points for dimensions
    dim_xs, dim_ys = dims.xs, dims.ys

    # plot dimensions
    @series begin
        seriestype  :=  :path
        linecolor := dim_color
        markercolor := dim_color
        xerror --> (dims.minor_lines, dims.major_lines)
        markersize := 0
        
        dim_xs, dim_ys
    end

    # plot labels
    @series begin
        dims.labels
    end
end

function dim_left(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_y = max(ys...)
    min_y = min(ys...)
    min_x = min(xs...)
    
    if offset == zero(S)
        offset = (max_y - min_y) * -0.1
    end
    
    x_dims = [min_x, min_x] .+ offset 
    y_dims = [max_y, min_y] 

    major_lines, minor_lines = get_major_minor_lines(y_dims, offset)

    labels = dimension_labels(x_dims, y_dims)

    if offset >= zero(S)
        return RightDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return LeftDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end