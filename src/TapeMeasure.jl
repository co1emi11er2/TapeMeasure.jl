module TapeMeasure

import Statistics: middle
using Unitful
using DispatchDoctor
export Labels, HDimensions, BottomDimensions, LeftDimensions, VDimensions
export dim, dim!, h_dimension, v_dimension, dim_top, dim_bottom, dim_left, dim_right

include("Utils.jl")
include("Labels.jl")
include("HDimensions.jl")
include("VDimensions.jl")

function dim end
function dim! end

end
