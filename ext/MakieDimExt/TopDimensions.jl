
Makie.plottype(::TopDimensions) = Dim{<:Tuple{TopDimensions}}

function Makie.plot!(p::Dim{<:Tuple{TopDimensions}})
	obj = p[:object]
	
    xs = obj[].xs
	ys = obj[].ys

	# get!(kwargs, :linewidth)
	# major and minor lines can be single digit or vector
	# convert to vector
	minor_lines = xs .* 0 .+ obj[].minor_lines
	major_lines = xs .* 0 .+ obj[].major_lines

	# Plot dimension lines
    lines!(p, xs, ys; color = p.color, linewidth=p.linewidth)

	# plot extension lines
    for (x, y, minor, major) in zip(xs, ys, minor_lines, major_lines)
		err_x = [x, x]
		err_y = [y + minor, y - major]
		lines!(p, err_x, err_y; color = p.color, linewidth=p.linewidth)
	end

	# pull label info
	lbl_x = obj[].labels.xs
	lbl_y = obj[].labels.ys
	annos = obj[].labels.lbls

	# create blank labels
	n = length.(annos)
	monospaced_fonts = ["JetBrains"]
	blank_mask = p.font[] in monospaced_fonts ? "█".^n .* "█" : "█".^n # courier is monospaced (add extra blank)
    blanks = vcat(blank_mask)

	# plot blank labels
	if p.with_mask[]
		text!(p, lbl_x, lbl_y; text=blanks, align=(:center, :center), color=:white, fontsize=p.fontsize, font=p.font, rotation=p.rotation)
	end

	# plot labels
	text_align = p.with_mask[] == true ? :center : :bottom
    text!(p, lbl_x, lbl_y; text=annos, align=(:center, text_align), color=p.color, fontsize=p.fontsize, font=p.font, rotation=p.rotation)
    return p
end