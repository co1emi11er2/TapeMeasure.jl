@recipe function f(dims::BottomDimensions; with_mask=true, dim_color=:black)
    
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
		err_x = [x, x]
		err_y = [y + major, y - minor]
		
		@series begin
			seriestype  :=  :path
			linecolor := dim_color

			err_x, err_y
		end
	end

    # plot labels
    @series begin
        dims.labels
    end
end