"""
    mutable struct HDimensions{T, S}

A mutable struct representing the horizontal dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.

# Fields
- `xs::Vector{T}`: A vector containing the x-coordinates.
- `ys::Vector{S}`: A vector containing the y-coordinates.
- `labels::Labels{T, S}`: An instance of `Labels` containing labels for the x and y coordinates.
- `minor_lines::Vector{S}`: A vector containing the positions of minor grid lines.
- `major_lines::Vector{S}`: A vector containing the positions of major grid lines.

# Type Parameters
- `T`: The type of the elements in the `xs` vector.
- `S`: The type of the elements in the `ys`, `minor_lines`, and `major_lines` vectors.
"""
mutable struct HDimensions{T, S} <: Dimensions
    xs::Vector{T}
    ys::Vector{S}
    labels::Labels{T, S}
    minor_lines::Vector{S}
    major_lines::Vector{S}
    offset::S
end

"""
    h_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(S)) where {T, S}

This function calculates the horizontal dimensions based on the input vectors `xs` and `ys`.

# Arguments
- `xs::Vector{Vector{T}}`: A vector of vectors containing the x-coordinates.
- `ys::Vector{Vector{S}}`: A vector of vectors containing the y-coordinates.
- `offset`: An optional parameter with a default value of `zero(S)`, used to adjust the y-dimensions.

# Returns
- If `offset` is greater than or equal to zero, returns an instance of `TopDimensions` containing:
  - `x_dims`: The calculated x-dimensions.
  - `y_dims`: The adjusted y-dimensions.
  - `labels`: The dimension labels.
  - `minor_lines`: The minor lines for the dimensions.
  - `major_lines`: The major lines for the dimensions.
- If `offset` is less than zero, returns an instance of `BottomDimensions` with the same fields as above.
"""
@stable function h_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(S)) where {T, S}

    x_dims, y_mid = _dimensions(xs, ys)

    # ensure y_dims values are either maximum or minimum
    max_or_min = offset >= zero(S) ? max : min
    y_max_or_min = max_or_min(y_mid...) + offset
    y_dims = [y_max_or_min for _ in y_mid]

    major_lines, minor_lines = _get_major_minor_lines(x_dims, y_mid, y_max_or_min)

    labels = _dimension_labels(x_dims, y_dims)

    return HDimensions{T, S}(x_dims, y_dims, labels, minor_lines, major_lines, offset)

end

"""
    h_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}

Calculate the horizontal dimension of a collection of objects.

# Arguments
- `objects::Vector{Vector{Tuple{T, S}}}`: A vector of vectors, where each inner vector contains tuples of type `(T, S)`.
- `offset`: An optional offset value of type `S`. Defaults to `zero(S)`.

# Returns
- The horizontal dimension of the given objects.
"""
@stable function h_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}
	xs, ys = _convert_to_vectors(objects)
	return h_dimension(xs, ys, offset=offset)
end


"""
    dim_top(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{TopDimensions, BottomDimensions}
    dim_top(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}

Computes the top dimensions for a given set of x and y coordinates of an object.

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
@stable function dim_top(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_x = max(xs...)
    min_x = min(xs...)
    max_y = max(ys...)

    offset = convert(S, offset)
    if offset == zero(S)
        offset = (max_x - min_x) * 0.1
    end
    
    x_dims = [min_x, max_x]
    y_dims = [max_y, max_y] .+ offset 

    major_lines, minor_lines = _get_major_minor_lines(x_dims, offset)

    labels = _dimension_labels(x_dims, y_dims)

    return HDimensions(x_dims, y_dims, labels, minor_lines, major_lines, offset)
end

@stable function dim_top(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}
    # convert to vectors
    xs, ys = _parse_tuple_object(object)

    return dim_top(xs, ys; offset=offset)
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
@stable function dim_bottom(xs::Vector{T}, ys::Vector{S}; offset=zero(S)) where {T, S}
    max_x = max(xs...)
    min_x = min(xs...)
    min_y = min(ys...)
    
    offset = convert(S, offset)
    if offset == zero(S)
        offset = (max_x - min_x) * -0.1
    end
    
    x_dims = [min_x, max_x]
    y_dims = [min_y, min_y] .+ offset 

    major_lines, minor_lines = _get_major_minor_lines(x_dims, offset)

    labels = _dimension_labels(x_dims, y_dims)

    return HDimensions(x_dims, y_dims, labels, minor_lines, major_lines, offset)
end

@stable function dim_bottom(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}
    # convert to vectors
    xs, ys = _parse_tuple_object(object)

    return dim_bottom(xs, ys; offset=offset)
end


