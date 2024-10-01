module Dimensions

using RecipesBase
import Statistics: middle
using Unitful
export Labels, TopDimensions, BottomDimensions, LeftDimensions, RightDimensions
export dim, dim!, h_dimension, v_dimension

include("Utils.jl")
include("TopDimensions.jl")
include("BottomDimensions.jl")
include("LeftDimensions.jl")
include("RightDimensions.jl")
include("Labels.jl")

function dim end
function dim! end

end
