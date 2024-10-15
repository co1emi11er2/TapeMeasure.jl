@recipe function f(dims::VDimensions; with_mask=true, dim_color=:black, font_size = 5, align_text=:bottom, text_rotation=90)
    
    legend := false

    # points for dimensions
    xs, ys = dims.xs, dims.ys

	# major and minor lines can be single digit or vector
	# convert to vector
	minor_lines = xs .* 0 .+ dims.minor_lines
	major_lines = xs .* 0 .+ dims.major_lines

    # plot dimensions
    @series begin
        seriestype  :=  :path
        linecolor := dim_color
        
        xs, ys
    end

	# plot extension lines
	for (x, y, minor, major) in zip(xs, ys, minor_lines, major_lines)
		err_x = [x + minor, x - major]
		err_y = [y, y]

		@series begin
			seriestype  :=  :path
			linecolor := dim_color

			err_x, err_y
		end
	end

    # plot labels
    @series begin
		with_mask --> with_mask
		font_color --> dim_color
		font_size --> font_size
		align_text --> align_text
		text_rotation --> text_rotation
        dims.labels
    end
end