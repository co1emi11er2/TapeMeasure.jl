module TapeMeasure

import Statistics: middle
using Unitful
export Labels, TopDimensions, BottomDimensions, LeftDimensions, RightDimensions
export dim, dim!, h_dimension, v_dimension, dim_top, dim_bottom, dim_left, dim_right

include("Utils.jl")
include("Labels.jl")
include("TopDimensions.jl")
include("BottomDimensions.jl")
include("LeftDimensions.jl")
include("RightDimensions.jl")

function dim end
function dim! end

end
