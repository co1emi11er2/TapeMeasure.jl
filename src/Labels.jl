"""
    mutable struct Labels{T, S}

A structure to hold labeled information for dimensions object.

# Fields
- `xs::Vector{T}`: A vector of x-coordinates of type `T`.
- `ys::Vector{S}`: A vector of y-coordinates of type `S`.
- `lbls::Vector{String}`: A vector of labels corresponding to the data points.
"""
mutable struct Labels{T, S}
    xs::Vector{T}
    ys::Vector{S}
    lbls::Vector{String}
end


@stable function _dimension_labels(
    x_dims::Vector{T},
    y_dims::Vector{S};
    ) where T where S

    # find location of dimension labels
    x_lbls = _find_midpoints(x_dims)
    y_lbls = _find_midpoints(y_dims)

    # find spacing of dimension points to determine label
    spa_x = _find_spacing(x_dims)
    spa_y = _find_spacing(y_dims)
    spa = sqrt.(spa_x.^2+spa_y.^2)
    spa = round.(spa, digits=2)
    lbls = string.(spa)

    return Labels(x_lbls, y_lbls, lbls)

end

@stable function _dimension_labels(
    x_dims::Vector{T},
    y_dims::Vector{S};
    ) where T<:Quantity where S<:Quantity

    # find location of dimension labels
    x_lbls = _find_midpoints(x_dims)
    y_lbls = _find_midpoints(y_dims)

    # find spacing of dimension points to determine label
    spa_x = _find_spacing(x_dims)
    spa_y = _find_spacing(y_dims)
    spa = sqrt.(spa_x.^2+spa_y.^2)
    spa = round.(T, spa, digits=2)
    lbls = string.(spa)

    return Labels(x_lbls, y_lbls, lbls)

end

