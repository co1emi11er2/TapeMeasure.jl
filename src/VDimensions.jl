"""
    mutable struct VDimensions{T, S}

A mutable struct representing the right dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.

# Fields
- `xs::Vector{T}`: A vector containing the x-coordinates.
- `ys::Vector{S}`: A vector containing the y-coordinates.
- `labels::Labels{T, S}`: An instance of `Labels` containing labels for the x and y coordinates.
- `minor_lines::Vector{T}`: A vector containing the positions of minor extension lines.
- `major_lines::Vector{T}`: A vector containing the positions of major extension lines.
- `offset::T`: Stores the offset value of the dimension

# Type Parameters
- `T`: The type of the elements in the `xs`, `minor_lines`, `major_lines` vectors and `offset` value.
- `S`: The type of the elements in the `ys` vector.
"""
mutable struct VDimensions{T, S} <: AbstractDimensions
    xs::Vector{T}
    ys::Vector{S}
    labels::Labels{T, S}
    minor_lines::Vector{S}
    major_lines::Vector{S}
    offset::T
end

"""
    v_dim(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(T)) where {T, S}

Calculate the vertical dimensions for a given set of x and y coordinates.

# Arguments
- `xs::Vector{Vector{T}}`: A vector of vectors containing the x coordinates.
- `ys::Vector{Vector{S}}`: A vector of vectors containing the y coordinates.
- `offset`: An optional parameter with a default value of `zero(S)`, used to adjust the x-dimensions.

# Returns
- `VDimensions` object containing:
  - `x_dims`: The x dimensions adjusted by the offset.
  - `y_dims`: The y dimensions.
  - `labels`: The dimension labels.
  - `minor_lines`: The minor lines for the dimensions.
  - `major_lines`: The major lines for the dimensions.
  - `offset`: offset from reference objects
"""
function v_dim(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(T)) where {T, S}

    x_mid, y_dims = _dimensions(xs, ys)

    # ensure x_dims values are either maximum or minimum
    max_or_min = offset >= zero(T) ? max : min
    x_max_or_min = max_or_min(x_mid...) + offset
    x_dims = [x_max_or_min for _ in x_mid]

    major_lines, minor_lines = _get_major_minor_lines(y_dims, x_mid, x_max_or_min)

    labels = _dimension_labels(x_dims, y_dims)

    return VDimensions{T, S}(x_dims, y_dims, labels, minor_lines, major_lines, offset)
end

"""
    v_dim(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}

Calculate the vertical dimension of a collection of objects.

# Arguments
- `objects::Vector{Vector{Tuple{T, S}}}`: A vector of vectors, where each inner vector contains tuples of type `(T, S)`.
- `offset`: An optional offset value of type `S`. Defaults to `zero(S)`.

# Returns
- `VDimensions` object containing:
  - `x_dims`: The x dimensions adjusted by the offset.
  - `y_dims`: The y dimensions.
  - `labels`: The dimension labels.
  - `minor_lines`: The minor lines for the dimensions.
  - `major_lines`: The major lines for the dimensions.
  - `offset`: offset from reference objects
"""
function v_dim(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}
	xs, ys = _convert_to_vectors(objects)
	return v_dim(xs, ys, offset=offset)
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
- `VDimensions` object containing:
  - `x_dims`: The x dimensions adjusted by the offset.
  - `y_dims`: The y dimensions.
  - `labels`: The dimension labels.
  - `minor_lines`: The minor lines for the dimensions.
  - `major_lines`: The major lines for the dimensions.
  - `offset`: offset from reference objects

If the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes 
the x and y dimensions, major and minor lines, and labels, and returns the 
appropriate dimensions object based on the offset value.
"""
function dim_right(xs::Vector{T}, ys::Vector{S}; offset=zero(T)) where {T, S}
    max_y = max(ys...)
    min_y = min(ys...)
    max_x = max(xs...)
    
    offset = convert(T, offset)
    if offset == zero(T)
        offset = (max_y - min_y) * 0.1
    end
    
    x_dims = [max_x, max_x] .+ offset 
    y_dims = [max_y, min_y] 

    major_lines, minor_lines = _get_major_minor_lines(y_dims, offset)

    labels = _dimension_labels(x_dims, y_dims)

    return VDimensions(x_dims, y_dims, labels, minor_lines, major_lines, offset)

end

function dim_right(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}
    # convert to vectors
    xs, ys = _parse_tuple_object(object)

    return dim_right(xs, ys; offset=offset)
end

"""
    dim_left(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{RightDimensions, LeftDimensions}
    dim_left(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}

Computes the left dimensions of a given set of x and y coordinates of an object.

# Arguments
- `xs::Vector{T}`: A vector of x coordinates.
- `ys::Vector{S}`: A vector of y coordinates.
- `offset`: An optional offset value of type `S`. Defaults to zero.

# Returns
- `VDimensions` object containing:
  - `x_dims`: The x dimensions adjusted by the offset.
  - `y_dims`: The y dimensions.
  - `labels`: The dimension labels.
  - `minor_lines`: The minor lines for the dimensions.
  - `major_lines`: The major lines for the dimensions.
  - `offset`: offset from reference objects

If the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes 
the x and y dimensions, major and minor lines, and labels, and returns the 
appropriate dimensions object based on the offset value.
"""
function dim_left(xs::Vector{T}, ys::Vector{S}; offset=zero(T)) where {T, S}
    max_y = max(ys...)
    min_y = min(ys...)
    min_x = min(xs...)
    
    offset = convert(T, offset)
    if offset == zero(T)
        offset = (max_y - min_y) * -0.1
    end
    
    x_dims = [min_x, min_x] .+ offset 
    y_dims = [max_y, min_y] 

    major_lines, minor_lines = _get_major_minor_lines(y_dims, offset)

    labels = _dimension_labels(x_dims, y_dims)

    return VDimensions(x_dims, y_dims, labels, minor_lines, major_lines, offset)

end

function dim_left(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}
    # convert to vectors
    xs, ys = _parse_tuple_object(object)

    return dim_left(xs, ys; offset=offset)
end