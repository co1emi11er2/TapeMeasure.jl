Makie.plottype(::VDimensions) = Dim{<:Tuple{VDimensions}}

function Makie.plot!(p::Dim{<:Tuple{VDimensions}})
	obj = p[:object]
	
    xs = obj[].xs
	ys = obj[].ys

	# major and minor lines can be single digit or vector
	# convert to vector
	minor_lines = xs .* 0 .+ obj[].minor_lines
	major_lines = xs .* 0 .+ obj[].major_lines

	# if offset is less than zero then switch minor and major lines
	if obj[].offset < zero(typeof(obj[].offset))
		major_lines, minor_lines = minor_lines, major_lines
	end

	# Plot dimension lines
    lines!(p, xs, ys; color = p.color, linewidth=p.linewidth)

	# plot extension lines
    for (x, y, minor, major) in zip(xs, ys, minor_lines, major_lines)
		err_x = [x + minor, x - major]
		err_y = [y, y]
		lines!(p, err_x, err_y; color = p.color, linewidth=p.linewidth)
	end

	# pull label info
	lbl_x = obj[].labels.xs
	lbl_y = obj[].labels.ys
	annos = obj[].labels.lbls

	# check rotation
	p.rotation[] = p.rotation[] === false ? π/2 : p.rotation[]

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