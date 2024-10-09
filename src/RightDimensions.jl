"""
    mutable struct RightDimensions{T, S}

A mutable struct representing the right dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.

# Fields
- `xs::Vector{T}`: A vector containing the x-coordinates.
- `ys::Vector{S}`: A vector containing the y-coordinates.
- `labels::Labels{T, S}`: An instance of `Labels` containing labels for the x and y coordinates.
- `minor_lines::Vector{T}`: A vector containing the positions of minor extension lines.
- `major_lines::Vector{T}`: A vector containing the positions of major extension lines.

# Type Parameters
- `T`: The type of the elements in the `xs`, `minor_lines`, and `major_lines` vectors.
- `S`: The type of the elements in the `ys` vector.
"""
mutable struct RightDimensions{T, S}
    xs::Vector{T}
    ys::Vector{S}
    labels::Labels{T, S}
    minor_lines::Vector{S}
    major_lines::Vector{S}
end

"""
    dim_right(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{RightDimensions, LeftDimensions}
    dim_right(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}

Computes the right dimension of a given set of x and y coordinates of an object.

# Arguments
- `xs::Vector{T}`: A vector of x coordinates.
- `ys::Vector{S}`: A vector of y coordinates.
- `offset`: An optional offset value of type `S`. Defaults to zero.

# Returns
- `RightDimensions` or `LeftDimensions`: Depending on the value of the offset, 
  returns an instance of `RightDimensions` if the offset is non-negative, 
  otherwise returns an instance of `LeftDimensions`.

If the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes 
the x and y dimensions, major and minor lines, and labels, and returns the 
appropriate dimensions object based on the offset value.
"""
function dim_right(xs::Vector{T}, ys::Vector{S}; offset=zero(T)) where {T, S}
    max_y = max(ys...)
    min_y = min(ys...)
    max_x = max(xs...)
    
    if offset == zero(T)
        offset = (max_y - min_y) * 0.1
    end
    
    x_dims = [max_x, max_x] .+ offset 
    y_dims = [max_y, min_y] 

    major_lines, minor_lines = _get_major_minor_lines(y_dims, offset)

    labels = _dimension_labels(x_dims, y_dims)

    if offset >= zero(S)
        return RightDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return LeftDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end

function dim_right(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}
    # convert to vectors
    xs, ys = _parse_tuple_object(object)

    return dim_right(xs, ys; offset=offset)
end