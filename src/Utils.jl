"""
    find_spacing(xs::AbstractVector{T}) where T

Compute the spacing of a vector `xs`, which consists of computing the difference between adjacent values in the vector.

# Example
```julia
julia> a = [1; 3; 7; 20; 30]
5-element Vector{Int64}:
  1
  3
  7
 20
 30

julia> find_spacing(a)
4-element Vector{Int64}:
  2
  4
 13
 10

```
"""
function _find_spacing(xs::AbstractVector{T}) where T
    # check if length of vector is more than 1
    if length(xs) == 1
        error("Vector must have a length greater than 1")
    end

    # initialize vector and step through
    len = length(xs) - 1
    result = zeros(T, len)
    for i in 1:len
        result[i] = xs[i+1] - xs[i]
    end

    return result
end


"""
    find_midpoints(xs::AbstractVector{T}) where T

Compute the midpoints of a vector `xs`, which consists of computing the average between adjacent values in the vector.

# Example
```julia
julia> a = [10; 20; 30; 40; 50]
5-element Vector{Int64}:
 10
 20
 30
 40
 50

julia> find_midpoints(a)
4-element Vector{Int64}:
 15
 25
 35
 45

```
"""
function _find_midpoints(xs::AbstractVector{T}) where T
    # check if length of vector is more than 1
    if length(xs) == 1
        error("Vector must have a length greater than 1")
    end

    # initialize vector and step through
    len = length(xs) - 1
    result = zeros(T, len)
    for i in 1:len
        result[i] = (xs[i+1] + xs[i])/2
    end

    return result
end

"""
    dimensions(
    xs::Vector{Vector{T}},
    ys::Vector{Vector{S}};
    offset = zero(S), # offset in y direction
    ) where T where S

Finds the dimensions of a horizontally spaced set of objects with points `xs` and `ys`.
Each vector in `xs` and `ys` represents a new object.
"""
function _dimensions(
    xs::Vector{Vector{T}},
    ys::Vector{Vector{S}};
    ) where T where S

    x_dims = middle.(xs)
    y_dims = middle.(ys)

    x_dims, y_dims
end

"""
    find_theta(xs, ys)

Not implemented.
"""
function _find_theta(xs, ys)
    # determine slope
    dx = last(xs) - first(xs)
    dy = last(ys) - first(ys)
    theta = tand(dy/dx)
    theta = theta == -90.0 ? 90.0 : theta # if negative vertical line, set to positive 90

    return theta
end

"""
    get_major_minor_lines(x_or_y_dims, offset::T) where T
"""
function _get_major_minor_lines(x_or_y_dims, offset::T) where T
    pnt1 = x_or_y_dims[1]
    pnt2 = x_or_y_dims[2]
    dim_dist = abs(pnt2 - pnt1)
    min_length = 0.05 * dim_dist # min length of extention line


    if offset == zero(T)
        major_lines = [min_length for _ in x_or_y_dims]
        minor_lines = major_lines
    else
        major_lines = [abs(offset)*0.9 for _ in x_or_y_dims]
        minor_lines = [min_length for _ in x_or_y_dims]
    end

    return major_lines, minor_lines
end

function _get_major_minor_lines(x_or_y_dims, y_or_x_mid, y_or_x_max::T) where T
    pnt1 = x_or_y_dims[1]
    pnt2 = x_or_y_dims[2]
    dim_dist = abs(pnt2 - pnt1)
    min_length = 0.05 * dim_dist # min length of extention line

    minor_lines = [min_length for _ in x_or_y_dims]

    major_lines = zeros(T, length(y_or_x_mid))
    for (i, y_or_x) in enumerate(y_or_x_mid)

        major_line = abs(y_or_x_max - y_or_x)*0.9
        major_line = major_line == zero(T) ? min_length : major_line
        major_lines[i] = major_line
    end



    return major_lines, minor_lines
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
function h_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(S)) where {T, S}

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


"""
    v_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(T)) where {T, S}

Calculate the vertical dimensions for a given set of x and y coordinates.

# Arguments
- `xs::Vector{Vector{T}}`: A vector of vectors containing the x coordinates.
- `ys::Vector{Vector{S}}`: A vector of vectors containing the y coordinates.
- `offset`: An optional parameter with a default value of `zero(S)`, used to adjust the x-dimensions.

# Returns
- If `offset` is greater than or equal to zero, returns a `RightDimensions` object containing:
  - `x_dims`: The x dimensions adjusted by the offset.
  - `y_dims`: The y dimensions.
  - `labels`: The dimension labels.
  - `minor_lines`: The minor lines for the dimensions.
  - `major_lines`: The major lines for the dimensions.
- If `offset` is less than zero, returns a `LeftDimensions` object containing the same fields as above.
"""
function v_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(T)) where {T, S}

    x_mid, y_dims = _dimensions(xs, ys)

    # ensure x_dims values are either maximum or minimum
    max_or_min = offset >= zero(S) ? max : min
    x_max_or_min = max_or_min(x_mid...) + offset
    x_dims = [x_max_or_min for _ in x_mid]

    major_lines, minor_lines = _get_major_minor_lines(y_dims, x_mid, x_max_or_min)

    labels = _dimension_labels(x_dims, y_dims)
    if offset >= zero(S)
        return RightDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return LeftDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
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
function h_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}
	xs, ys = _convert_to_vectors(objects)
	return h_dimension(xs, ys, offset=offset)
end

"""
    v_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}

Calculate the vertical dimension of a collection of objects.

# Arguments
- `objects::Vector{Vector{Tuple{T, S}}}`: A vector of vectors, where each inner vector contains tuples of type `(T, S)`.
- `offset`: An optional offset value of type `S`. Defaults to `zero(S)`.

# Returns
- The vertical dimension of the given objects.
"""
function v_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}
	xs, ys = _convert_to_vectors(objects)
	return v_dimension(xs, ys, offset=offset)
end

# This function splits a Vector{Vector{Tuple{T, S}}} to xs, ys = Vector{Vector{T}}, Vector{Vector{S}}
function _convert_to_vectors(objects::Vector{Vector{Tuple{T, S}}}) where {T, S}
    xs, ys = Vector{T}[], Vector{S}[]
    for object in objects
        x, y = _parse_tuple_object(object)
        push!(xs, x)
        push!(ys, y)
    end
    return xs, ys
end

function _parse_tuple_object(object::Vector{Tuple{T, S}}) where {T, S}
    xs, ys = T[], S[]
    for point in object
        x, y = point
        push!(xs, x)
        push!(ys, y)
    end
    _ensure_closed(xs, ys)
    return xs, ys
end

function _ensure_closed(xs::Vector{T}, ys::Vector{S}) where {T, S}
    if xs[1] != xs[end] || ys[1] != ys[end]
        push!(xs, xs[1])
        push!(ys, ys[1])
    end
end