struct TopDimensions
    xs
    ys
    labels
    minor_lines
    major_lines
end

@recipe function f(dims::TopDimensions; with_mask=true, dim_color=:black) 
    
    legend := false

    # points for dimensions
    dim_xs, dim_ys = dims.xs, dims.ys

    # plot dimensions
    @series begin
        seriestype  :=  :path
        linecolor := dim_color
        markercolor := dim_color
        yerror --> (dims.major_lines, dims.minor_lines)
        markersize := 0
        
        dim_xs, dim_ys
    end

    # plot labels
    @series begin
        dims.labels
    end
end

function dim_top(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_x = max(xs...)
    min_x = min(xs...)
    max_y = max(ys...)
    
    if offset == zero(S)
        offset = (max_x - min_x) * 0.1
    end
    
    x_dims = [min_x, max_x]
    y_dims = [max_y, max_y] .+ offset 

    major_lines, minor_lines = get_major_minor_lines(x_dims, offset)

    labels = dimension_labels(x_dims, y_dims)

    if offset >= zero(S)
        return TopDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return BottomDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end


