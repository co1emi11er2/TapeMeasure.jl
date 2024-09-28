module MakieDimExt

using Dimensions
import Dimensions: dim, dim!
using Makie
import Makie.SpecApi as S


@recipe(Dim, object) do scene
    Theme(
        # plot_color = :red
    )
end

include("TopDimensions.jl")
end