"""
    find_middle(xs::AbstractArray{T}) where T

Compute the middle of an array `xs` for each column, which consists of finding its extrema and then computing their mean.

# Example
```julia
julia> a = [
       1 2 3
       4 5 6
       7 8 9
       ]
3×3 Matrix{Int64}:
 1  2  3
 4  5  6
 7  8  9

julia> find_middle(a)
3-element Vector{Int64}:
 4
 5
 6

```
"""
function find_middle(xs::AbstractArray{T}) where T
    # initialize vector and step through columns to find middle
    n_cols = size(xs, 2)
    middle_xs = zeros(T, n_cols)
    for i in 1:n_cols
        middle_xs[i] = middle(xs[:, i])
    end

    return middle_xs
end


"""
    find_middle(xs::AbstractArray{T}, ys::AbstractArray{S}) where T where S

Compute the middle of an array `xs` and `ys` for each column, which consists of finding its extrema and then computing their mean. 
Will return two vectors for each array.
"""
function find_middle(xs::AbstractArray{T}, ys::AbstractArray{S}) where T where S
    # check if xs and ys have the same dimension
    if size(xs, 2) != size(ys, 2)
        error("Number of columns in xs must be equal to number of columns in ys")
    end

    # initialize vectors and step through columns to find middle
    n_cols = size(xs, 2)
    middle_xs = zeros(T, n_cols)
    middle_ys = zeros(S, n_cols)
    for i in 1:n_cols
        middle_xs[i] = middle(xs[:, i])
        middle_ys[i] = middle(ys[:, i])
    end

    return middle_xs, middle_ys
end


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
function find_spacing(xs::AbstractVector{T}) where T
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
function find_midpoints(xs::AbstractVector{T}) where T
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
function dimensions(
    xs::Vector{Vector{T}}, 
    ys::Vector{Vector{S}}; 
    ) where T where S

    x_dims = middle.(xs)
    y_dims = middle.(ys)

    x_dims, y_dims
end

function find_theta(xs, ys)
    # determine slope
    dx = last(xs) - first(xs)
    dy = last(ys) - first(ys)
    theta = tand(dy/dx)
    theta = theta == -90.0 ? 90.0 : theta # if negative vertical line, set to positive 90

    return theta 
end

function get_major_minor_lines(x_or_y_dims, offset::T) where T
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

function get_major_minor_lines(x_or_y_dims, y_or_x_mid, y_or_x_max::T) where T
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

function h_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(S)) where {T, S}
    
    x_dims, y_mid = dimensions(xs, ys)

    # ensure y_dims values are either maximum or minimum
    max_or_min = offset >= zero(S) ? max : min
    y_max_or_min = max_or_min(y_mid...) + offset
    y_dims = [y_max_or_min for _ in y_mid]

    major_lines, minor_lines = get_major_minor_lines(x_dims, y_mid, y_max_or_min)

    labels = dimension_labels(x_dims, y_dims)
    if offset >= zero(S)
        return TopDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return BottomDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end

function v_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(S)) where {T, S}
    
    x_mid, y_dims = dimensions(xs, ys)

    # ensure x_dims values are either maximum or minimum
    max_or_min = offset >= zero(S) ? max : min
    x_max_or_min = max_or_min(x_mid...) + offset
    x_dims = [x_max_or_min for _ in x_mid]

    major_lines, minor_lines = get_major_minor_lines(y_dims, x_mid, x_max_or_min)

    labels = dimension_labels(x_dims, y_dims)
    if offset >= zero(S)
        return RightDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    else
        return LeftDimensions(x_dims, y_dims, labels, minor_lines, major_lines)
    end
end

# function plot_h_dimensions_makie!(
#     xs::Vector{Vector{T}}, 
#     ys::Vector{Vector{S}}; 
#     error = 0.02ft, 
#     color = :grey, 
#     offset = zero(S),
#     ) where T where S

#     # plot dimension lines
#     x_dims, y_dims = middle.(xs), middle.(ys)
#     y_dims = y_dims .+ offset
#     err = sequence(length(xs), error, 0.0ft)
#     lines!(x_dims, y_dims; color, linewidth=1)
#     errorbars!(x_dims, y_dims, err; color, linewidth=1)

#     # plot annotations
#     fntcm = "Courier"
#     fntsz = 4
#     x_lbls = find_midpoints(x_dims)
#     y_lbls = find_midpoints(y_dims)
#     spa = round.(T, find_spacing(x_dims), digits=2)
#     annos = string.(spa)
#     n = length.(annos)
#     blanks = vcat("█".^n #=.* "█"=#)
#     text!(x_lbls, y_lbls; text=blanks, color=:white, align=(:center, :center))
#     text!(x_lbls, y_lbls; text=annos, color, align=(:center, :center))
# end