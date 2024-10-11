module MakieDimExt

using TapeMeasure
import TapeMeasure: dim, dim!
using Makie
import Makie.SpecApi as S


@recipe(Dim, object) do scene
    Theme(
        # plot_color = :red
    )
end

include("TopDimensions.jl")
include("BottomDimensions.jl")
include("RightDimensions.jl")
include("LeftDimensions.jl")
end