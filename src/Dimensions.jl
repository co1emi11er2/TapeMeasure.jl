module Dimensions

using RecipesBase
import Statistics: middle
using Unitful
export TopDimensions, dim, dim!

include("Utils.jl")
include("TopDimensions.jl")
include("BottomDimensions.jl")
include("LeftDimensions.jl")
include("RightDimensions.jl")
include("Labels.jl")

function dim end
function dim! end

end
