"""
    mutable struct BottomDimensions{T, S}

A mutable struct representing the bottom dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.

# Fields
- `xs::Vector{T}`: A vector containing the x-coordinates.
- `ys::Vector{S}`: A vector containing the y-coordinates.
- `labels::Labels{T, S}`: An instance of `Labels` containing labels for the x and y coordinates.
- `minor_lines::Vector{S}`: A vector containing the positions of minor extension lines.
- `major_lines::Vector{S}`: A vector containing the positions of major extension lines.

# Type Parameters
- `T`: The type of the elements in the `xs` vector.
- `S`: The type of the elements in the `ys`, `minor_lines`, and `major_lines` vectors.
"""
mutable struct BottomDimensions{T, S}
    xs::Vector{T}
    ys::Vector{S}
    labels::Labels{T, S}
    minor_lines::Vector{S}
    major_lines::Vector{S}
end

"""
    dim_bottom(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{TopDimensions, BottomDimensions}
    dim_bottom(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}

Computes the bottom dimension for a given set of x and y coordinates of an object.

# Arguments
- `xs::Vector{T}`: A vector of x coordinates.
- `ys::Vector{S}`: A vector of y coordinates.
- `offset`: An optional offset value of type `S`. Defaults to zero.

# Returns
- `TopDimensions` or `BottomDimensions`: Depending on the value of the offset, 
  returns an instance of `TopDimensions` if the offset is non-negative, 
  otherwise returns an instance of `BottomDimensions`.

If the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes 
the x and y dimensions, major and minor lines, and labels, and returns the 
appropriate dimensions object based on the offset value.
"""
function dim_bottom(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_x = max(xs...)
    min_x = min(xs...)
    min_y = min(ys...)
    
    if offset == zero(S)
        offset = (max_x - min_x) * -0.1
    end
    
    x_dims = [min_x, max_x]
    y_dims = [min_y, min_y] .+ offset 

    major_lines, minor_lines = _get_major_minor_lines(x_dims, offset)

    labels = _dimension_labels(x_dims, y_dims)

    if offset >= zero(S)
        return TopDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return BottomDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end

function dim_bottom(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}
    # convert to vectors
    xs, ys = _parse_tuple_object(object)

    return dim_bottom(xs, ys; offset=offset)
end