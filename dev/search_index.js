var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = Dimensions","category":"page"},{"location":"#Dimensions","page":"Home","title":"Dimensions","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for Dimensions.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Dimensions]","category":"page"},{"location":"#Dimensions.BottomDimensions","page":"Home","title":"Dimensions.BottomDimensions","text":"mutable struct BottomDimensions{T, S}\n\nA mutable struct representing the bottom dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.\n\nFields\n\nxs::Vector{T}: A vector containing the x-coordinates.\nys::Vector{S}: A vector containing the y-coordinates.\nlabels::Labels{T, S}: An instance of Labels containing labels for the x and y coordinates.\nminor_lines::Vector{S}: A vector containing the positions of minor extension lines.\nmajor_lines::Vector{S}: A vector containing the positions of major extension lines.\n\nType Parameters\n\nT: The type of the elements in the xs vector.\nS: The type of the elements in the ys, minor_lines, and major_lines vectors.\n\n\n\n\n\n","category":"type"},{"location":"#Dimensions.Labels","page":"Home","title":"Dimensions.Labels","text":"struct Labels{T, S}\n\nA structure to hold labeled information for dimensions object.\n\nFields\n\nxs::Vector{T}: A vector of x-coordinates of type T.\nys::Vector{S}: A vector of y-coordinates of type S.\nlbls::Vector{String}: A vector of labels corresponding to the data points.\n\n\n\n\n\n","category":"type"},{"location":"#Dimensions.LeftDimensions","page":"Home","title":"Dimensions.LeftDimensions","text":"mutable struct LeftDimensions{T, S}\n\nA mutable struct representing the left dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.\n\nFields\n\nxs::Vector{T}: A vector containing the x-coordinates.\nys::Vector{S}: A vector containing the y-coordinates.\nlabels::Labels{T, S}: An instance of Labels containing labels for the x and y coordinates.\nminor_lines::Vector{T}: A vector containing the positions of minor extension lines.\nmajor_lines::Vector{T}: A vector containing the positions of major extension lines.\n\nType Parameters\n\nT: The type of the elements in the xs, minor_lines, and major_lines vectors.\nS: The type of the elements in the ys vector.\n\n\n\n\n\n","category":"type"},{"location":"#Dimensions.RightDimensions","page":"Home","title":"Dimensions.RightDimensions","text":"mutable struct RightDimensions{T, S}\n\nA mutable struct representing the right dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.\n\nFields\n\nxs::Vector{T}: A vector containing the x-coordinates.\nys::Vector{S}: A vector containing the y-coordinates.\nlabels::Labels{T, S}: An instance of Labels containing labels for the x and y coordinates.\nminor_lines::Vector{T}: A vector containing the positions of minor extension lines.\nmajor_lines::Vector{T}: A vector containing the positions of major extension lines.\n\nType Parameters\n\nT: The type of the elements in the xs, minor_lines, and major_lines vectors.\nS: The type of the elements in the ys vector.\n\n\n\n\n\n","category":"type"},{"location":"#Dimensions.TopDimensions","page":"Home","title":"Dimensions.TopDimensions","text":"mutable struct TopDimensions{T, S}\n\nA mutable struct representing the top dimensions for an object that can be shown on a plot using Plots.jl or Makie.jl.\n\nFields\n\nxs::Vector{T}: A vector containing the x-coordinates.\nys::Vector{S}: A vector containing the y-coordinates.\nlabels::Labels{T, S}: An instance of Labels containing labels for the x and y coordinates.\nminor_lines::Vector{S}: A vector containing the positions of minor grid lines.\nmajor_lines::Vector{S}: A vector containing the positions of major grid lines.\n\nType Parameters\n\nT: The type of the elements in the xs vector.\nS: The type of the elements in the ys, minor_lines, and major_lines vectors.\n\n\n\n\n\n","category":"type"},{"location":"#Dimensions._dimensions-Union{Tuple{T}, Tuple{S}, Tuple{Array{Vector{T}, 1}, Array{Vector{S}, 1}}} where {S, T}","page":"Home","title":"Dimensions._dimensions","text":"dimensions(\nxs::Vector{Vector{T}},\nys::Vector{Vector{S}};\noffset = zero(S), # offset in y direction\n) where T where S\n\nFinds the dimensions of a horizontally spaced set of objects with points xs and ys. Each vector in xs and ys represents a new object.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions._find_midpoints-Union{Tuple{AbstractVector{T}}, Tuple{T}} where T","page":"Home","title":"Dimensions._find_midpoints","text":"find_midpoints(xs::AbstractVector{T}) where T\n\nCompute the midpoints of a vector xs, which consists of computing the average between adjacent values in the vector.\n\nExample\n\njulia> a = [10; 20; 30; 40; 50]\n5-element Vector{Int64}:\n 10\n 20\n 30\n 40\n 50\n\njulia> find_midpoints(a)\n4-element Vector{Int64}:\n 15\n 25\n 35\n 45\n\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions._find_spacing-Union{Tuple{AbstractVector{T}}, Tuple{T}} where T","page":"Home","title":"Dimensions._find_spacing","text":"find_spacing(xs::AbstractVector{T}) where T\n\nCompute the spacing of a vector xs, which consists of computing the difference between adjacent values in the vector.\n\nExample\n\njulia> a = [1; 3; 7; 20; 30]\n5-element Vector{Int64}:\n  1\n  3\n  7\n 20\n 30\n\njulia> find_spacing(a)\n4-element Vector{Int64}:\n  2\n  4\n 13\n 10\n\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions._find_theta-Tuple{Any, Any}","page":"Home","title":"Dimensions._find_theta","text":"find_theta(xs, ys)\n\nNot implemented.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions._get_major_minor_lines-Union{Tuple{T}, Tuple{Any, T}} where T","page":"Home","title":"Dimensions._get_major_minor_lines","text":"get_major_minor_lines(x_or_y_dims, offset::T) where T\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.dim_bottom-Union{Tuple{S}, Tuple{T}, Tuple{Vector{T}, Vector{S}}} where {T, S}","page":"Home","title":"Dimensions.dim_bottom","text":"dim_bottom(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{TopDimensions, BottomDimensions}\ndim_bottom(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}\n\nComputes the bottom dimension for a given set of x and y coordinates of an object.\n\nArguments\n\nxs::Vector{T}: A vector of x coordinates.\nys::Vector{S}: A vector of y coordinates.\noffset: An optional offset value of type S. Defaults to zero.\n\nReturns\n\nTopDimensions or BottomDimensions: Depending on the value of the offset,  returns an instance of TopDimensions if the offset is non-negative,  otherwise returns an instance of BottomDimensions.\n\nIf the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes  the x and y dimensions, major and minor lines, and labels, and returns the  appropriate dimensions object based on the offset value.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.dim_left-Union{Tuple{S}, Tuple{T}, Tuple{Vector{T}, Vector{S}}} where {T, S}","page":"Home","title":"Dimensions.dim_left","text":"dim_left(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{RightDimensions, LeftDimensions}\ndim_left(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}\n\nComputes the left dimensions of a given set of x and y coordinates of an object.\n\nArguments\n\nxs::Vector{T}: A vector of x coordinates.\nys::Vector{S}: A vector of y coordinates.\noffset: An optional offset value of type S. Defaults to zero.\n\nReturns\n\nRightDimensions or LeftDimensions: Depending on the value of the offset,  returns an instance of RightDimensions if the offset is non-negative,  otherwise returns an instance of LeftDimensions.\n\nIf the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes  the x and y dimensions, major and minor lines, and labels, and returns the  appropriate dimensions object based on the offset value.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.dim_right-Union{Tuple{S}, Tuple{T}, Tuple{Vector{T}, Vector{S}}} where {T, S}","page":"Home","title":"Dimensions.dim_right","text":"dim_right(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{RightDimensions, LeftDimensions}\ndim_right(object::Vector{Tuple{T, S}}; offset=zero(T)) where {T, S}\n\nComputes the right dimension of a given set of x and y coordinates of an object.\n\nArguments\n\nxs::Vector{T}: A vector of x coordinates.\nys::Vector{S}: A vector of y coordinates.\noffset: An optional offset value of type S. Defaults to zero.\n\nReturns\n\nRightDimensions or LeftDimensions: Depending on the value of the offset,  returns an instance of RightDimensions if the offset is non-negative,  otherwise returns an instance of LeftDimensions.\n\nIf the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes  the x and y dimensions, major and minor lines, and labels, and returns the  appropriate dimensions object based on the offset value.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.dim_top-Union{Tuple{S}, Tuple{T}, Tuple{Vector{T}, Vector{S}}} where {T, S}","page":"Home","title":"Dimensions.dim_top","text":"dim_top(xs::Vector{T}, ys::Vector{S}; offset::S=0) -> Union{TopDimensions, BottomDimensions}\ndim_top(object::Vector{Tuple{T, S}}; offset=zero(S)) where {T, S}\n\nComputes the top dimensions for a given set of x and y coordinates of an object.\n\nArguments\n\nxs::Vector{T}: A vector of x coordinates.\nys::Vector{S}: A vector of y coordinates.\noffset: An optional offset value of type S. Defaults to zero.\n\nReturns\n\nTopDimensions or BottomDimensions: Depending on the value of the offset,  returns an instance of TopDimensions if the offset is non-negative,  otherwise returns an instance of BottomDimensions.\n\nIf the offset is not provided, it is set to 10% of the range of x coordinates. The function then computes  the x and y dimensions, major and minor lines, and labels, and returns the  appropriate dimensions object based on the offset value.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.h_dimension-Union{Tuple{Array{Array{Tuple{T, S}, 1}, 1}}, Tuple{S}, Tuple{T}} where {T, S}","page":"Home","title":"Dimensions.h_dimension","text":"h_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}\n\nCalculate the horizontal dimension of a collection of objects.\n\nArguments\n\nobjects::Vector{Vector{Tuple{T, S}}}: A vector of vectors, where each inner vector contains tuples of type (T, S).\noffset: An optional offset value of type S. Defaults to zero(S).\n\nReturns\n\nThe horizontal dimension of the given objects.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.h_dimension-Union{Tuple{S}, Tuple{T}, Tuple{Array{Vector{T}, 1}, Array{Vector{S}, 1}}} where {T, S}","page":"Home","title":"Dimensions.h_dimension","text":"h_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(S)) where {T, S}\n\nThis function calculates the horizontal dimensions based on the input vectors xs and ys.\n\nArguments\n\nxs::Vector{Vector{T}}: A vector of vectors containing the x-coordinates.\nys::Vector{Vector{S}}: A vector of vectors containing the y-coordinates.\noffset: An optional parameter with a default value of zero(S), used to adjust the y-dimensions.\n\nReturns\n\nIf offset is greater than or equal to zero, returns an instance of TopDimensions containing:\nx_dims: The calculated x-dimensions.\ny_dims: The adjusted y-dimensions.\nlabels: The dimension labels.\nminor_lines: The minor lines for the dimensions.\nmajor_lines: The major lines for the dimensions.\nIf offset is less than zero, returns an instance of BottomDimensions with the same fields as above.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.v_dimension-Union{Tuple{Array{Array{Tuple{T, S}, 1}, 1}}, Tuple{S}, Tuple{T}} where {T, S}","page":"Home","title":"Dimensions.v_dimension","text":"v_dimension(objects::Vector{Vector{Tuple{T, S}}}; offset = zero(S)) where {T, S}\n\nCalculate the vertical dimension of a collection of objects.\n\nArguments\n\nobjects::Vector{Vector{Tuple{T, S}}}: A vector of vectors, where each inner vector contains tuples of type (T, S).\noffset: An optional offset value of type S. Defaults to zero(S).\n\nReturns\n\nThe vertical dimension of the given objects.\n\n\n\n\n\n","category":"method"},{"location":"#Dimensions.v_dimension-Union{Tuple{S}, Tuple{T}, Tuple{Array{Vector{T}, 1}, Array{Vector{S}, 1}}} where {T, S}","page":"Home","title":"Dimensions.v_dimension","text":"v_dimension(xs::Vector{Vector{T}}, ys::Vector{Vector{S}}; offset = zero(T)) where {T, S}\n\nCalculate the vertical dimensions for a given set of x and y coordinates.\n\nArguments\n\nxs::Vector{Vector{T}}: A vector of vectors containing the x coordinates.\nys::Vector{Vector{S}}: A vector of vectors containing the y coordinates.\noffset: An optional parameter with a default value of zero(S), used to adjust the x-dimensions.\n\nReturns\n\nIf offset is greater than or equal to zero, returns a RightDimensions object containing:\nx_dims: The x dimensions adjusted by the offset.\ny_dims: The y dimensions.\nlabels: The dimension labels.\nminor_lines: The minor lines for the dimensions.\nmajor_lines: The major lines for the dimensions.\nIf offset is less than zero, returns a LeftDimensions object containing the same fields as above.\n\n\n\n\n\n","category":"method"}]
}
