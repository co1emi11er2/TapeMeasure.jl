function labels_for_plots(
    labels::Labels, 
    with_mask::Bool,
    font_size,
    font_color,
    font,
    align_text,
    text_rotation)

    x_lbls = labels.xs
    y_lbls = labels.ys
    annos = labels.lbls

    align = with_mask ? :center : align_text
    annotations = []
    for (x, y, txt) in zip(x_lbls, y_lbls, annos)
        push!(annotations, (x, y, Plots.text(txt, font_size, font_color, font, align, rotation=text_rotation)))
    end

    if with_mask
        n = length.(annos)
        blank_mask = lowercase(font) == "courier" ? "█".^n .* "█" : "█".^n # courier is monospaced (add extra blank)
        blanks = vcat(blank_mask)
        
        # annotations = Vector{Tuple{Float64, Float64, String, Tuple}}(undef, length(x_lbls))
        blank_annotations = []
        for (x, y, txt) in zip(x_lbls, y_lbls, blanks)
            push!(blank_annotations, (x, y, Plots.text(txt, font_size, :white, font, rotation=text_rotation)))
        end

        annotations = vcat(blank_annotations, annotations)
        x_lbls = vcat(x_lbls, x_lbls)
        y_lbls = vcat(y_lbls, y_lbls)
    end

    x_lbls, y_lbls, annotations
end

@recipe function f(lbls::Labels; with_mask=true, font_color=:black, font_size=5, font = "sans-serif", align_text = :bottom, text_rotation=0)
    
    legend := false

    # points for labels
    x_lbls, y_lbls, annos = labels_for_plots(lbls, with_mask, font_size, font_color, font, align_text, text_rotation)

    # plot labels
    @series begin
        seriestype:= :scatter
        markersize := 0
        annotations --> annos
        x_lbls, y_lbls
    end
end