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
        push!(annotations, (x, y, (txt, font_color, font_size)))
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

@recipe function f(lbls::Labels; with_mask=true, font_color=:black, font_size=5)
    
    legend := false

    # points for labels
    x_lbls, y_lbls, annos = labels_for_plots(lbls, with_mask, font_size, font_color)

    # plot labels
    @series begin
        seriestype:= :scatter
        markersize := 0
        annotations --> annos
        x_lbls, y_lbls
    end
end