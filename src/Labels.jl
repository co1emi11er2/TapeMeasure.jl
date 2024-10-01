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

function labels_for_plots(
    labels::Labels, 
    with_mask::Bool=true,
    font_size = 5,
    font_color = :black,
    font = "Courier",)

    x_lbls = labels.xs
    y_lbls = labels.ys
    annos = labels.lbls

    annotations = []
    for (x, y, txt) in zip(x_lbls, y_lbls, annos)
        push!(annotations, (x, y, (txt, font_size, font_color)))
    end

    if with_mask
        n = length.(annos)
        blanks = vcat("█".^n #=.* "█"=#)

        # annotations = Vector{Tuple{Float64, Float64, String, Tuple}}(undef, length(x_lbls))
        blank_annotations = []
        for (x, y, txt) in zip(x_lbls, y_lbls, blanks)
            push!(blank_annotations, (x, y, (txt, font_size, :white)))
        end

        annotations = vcat(blank_annotations, annotations)
        x_lbls = vcat(x_lbls, x_lbls)
        y_lbls = vcat(y_lbls, y_lbls)
    end

    x_lbls, y_lbls, annotations
end