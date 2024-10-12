Makie.plottype(::LeftDimensions) = Dim{<:Tuple{LeftDimensions}}

function Makie.plot!(p::Dim{<:Tuple{LeftDimensions}})
	obj = p[:object]
	
    xs = obj[].xs
	ys = obj[].ys

	# major and minor lines can be single digit or vector
	# convert to vector
	minor_lines = xs .* 0 .+ obj[].minor_lines
	major_lines = xs .* 0 .+ obj[].major_lines

	# Plot dimension lines
    lines!(p, xs, ys; color = p.color, linewidth=p.linewidth)

	# plot extension lines
    for (x, y, minor, major) in zip(xs, ys, minor_lines, major_lines)
		err_x = [x + major, x - minor]
		err_y = [y, y]
		lines!(p, err_x, err_y; color = p.color, linewidth=p.linewidth)
	end

	# pull label info
	lbl_x = obj[].labels.xs
	lbl_y = obj[].labels.ys
	annos = obj[].labels.lbls

	# create blank labels
	n = length.(annos)
    blanks = vcat("█".^n #=.* "█"=#)

	# plot blank labels
	text!(p, lbl_x, lbl_y; text=blanks, align=(:center, :center), color=:white, fontsize=p.fontsize)

	# plot labels
    text!(p, lbl_x, lbl_y; text=annos, align=(:center, :center), color=p.color, fontsize=p.fontsize)
    return p
end