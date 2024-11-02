module MakieDimExt

using TapeMeasure
import TapeMeasure: dim, dim!
using Makie
import Makie.SpecApi as S


@recipe(Dim, object) do scene
    Attributes(
        color = :black,
        linewidth = 1,
        fontsize = 8,
        font = "sans-serif",
        rotation = false,
        with_mask = true,
    )
end

include("HDimensions.jl")
include("VDimensions.jl")
end