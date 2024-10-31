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
@stable function _find_spacing(xs::AbstractVector{T}) where T
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
@stable function _find_midpoints(xs::AbstractVector{T}) where T
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
    ) where T where S

Finds the dimensions of a horizontally spaced set of objects with points `xs` and `ys`.
Each vector in `xs` and `ys` represents a new object.
"""
@stable function _dimensions(
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
@stable function _find_theta(xs, ys)
    # determine slope
    dx = last(xs) - first(xs)
    dy = last(ys) - first(ys)
    theta = tand(dy/dx)
    theta = theta == -90.0 ? 90.0 : theta # if negative vertical line, set to positive 90

    return theta
end

# TODO: Implement way to adjust auto major/minor lines
"""
    get_major_minor_lines(x_or_y_dims, offset::T) where T
"""
@stable function _get_major_minor_lines(x_or_y_dims, offset::T) where T
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

@stable function _get_major_minor_lines(x_or_y_dims, y_or_x_mid, y_or_x_max::T) where T
    pnt1 = x_or_y_dims[1]
    pnt2 = x_or_y_dims[2]
    dim_dist = abs(pnt2 - pnt1)
    min_length = 0.05 * dim_dist # min length of extention line

    minor_lines = [min_length for _ in x_or_y_dims]

    major_lines = zeros(T, length(y_or_x_mid))
    for (i, y_or_x) in enumerate(y_or_x_mid)

        major_line = abs(y_or_x_max - y_or_x)
        major_line = major_line == zero(T) ? min_length : major_line
        major_lines[i] = major_line
    end



    return major_lines, minor_lines
end

# This function splits a Vector{Vector{Tuple{T, S}}} to xs, ys = Vector{Vector{T}}, Vector{Vector{S}}
@stable function _convert_to_vectors(objects::Vector{Vector{Tuple{T, S}}}) where {T, S}
    xs, ys = Vector{T}[], Vector{S}[]
    for object in objects
        x, y = _parse_tuple_object(object)
        push!(xs, x)
        push!(ys, y)
    end
    return xs, ys
end

@stable function _parse_tuple_object(object::Vector{Tuple{T, S}}) where {T, S}
    xs, ys = T[], S[]
    for point in object
        x, y = point
        push!(xs, x)
        push!(ys, y)
    end
    _ensure_closed!(xs, ys)
    return xs, ys
end

@stable function _ensure_closed!(xs::Vector{T}, ys::Vector{S}) where {T, S}
    if xs[1] != xs[end] || ys[1] != ys[end]
        push!(xs, xs[1])
        push!(ys, ys[1])
    end

    return nothing
end