struct Labels
    xs
    ys
    lbls
end


function dimension_labels(
    x_dims::Vector{T},
    y_dims::Vector{S};
    ) where T where S

    # find location of dimension labels
    x_lbls = find_midpoints(x_dims)
    y_lbls = find_midpoints(y_dims)

    # find spacing of dimension points to determine label
    spa_x = round.(find_spacing(x_dims), digits=2)
    spa_y = round.(find_spacing(y_dims), digits=2)
    spa = sqrt.(spa_x.^2+spa_y.^2)
    spa = round.(spa, digits=2)
    lbls = string.(spa)

    return Labels(x_lbls, y_lbls, lbls)

end

function dimension_labels(
    x_dims::Vector{T},
    y_dims::Vector{S};
    ) where T<:Quantity where S<:Quantity

    # find location of dimension labels
    x_lbls = find_midpoints(x_dims)
    y_lbls = find_midpoints(y_dims)

    # find spacing of dimension points to determine label
    spa_x = round.(T, find_spacing(x_dims), digits=2)
    spa_y = round.(S, find_spacing(y_dims), digits=2)
    spa = sqrt.(spa_x.^2+spa_y.^2)
    spa = round.(T, spa, digits=2)
    lbls = string.(spa)

    return Labels(x_lbls, y_lbls, lbls)

end

