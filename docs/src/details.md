# Details

The goal of this package is to be able to get measurements for objects (geometric shapes) as well as plot dimensions. Currently, objects are defined differently depending on the package. Plots, for instance, takes objects in the form of two separate x and y vectors, while Makie uses `Polygon` objects. The Meshes.jl package uses `Ngon` objects. Makie `Polygon` objects currently do not support unitful, so still debating on the best approach there. 

The short term goals are:
 - Feature parity with both Makie.jl and Plots.jl
 - Sensible API for the package
 - Meshes.jl integration
 - Measurements for radius or diameter of a circle 
 - Angle Measurements

## Current Capabilities
There are two main use cases for TapeMeasure currently. One use case is for objects and the other is for a single object. The term object here is specifically for a set of points that define a polygon.

### Multiple Objects
When dealing with a set of objects, there are two main functions currently.
- [`h_dimension`](@ref h_dimension) (may be renamed to `h_dim`)
- [`v_dimension`](@ref v_dimension) (may be renamed to `v_dim`)

These functions will calculate the middle of the each object. This is trivial currently. It is just finding the middle point of the xs and ys of each object (using the `middle` function from the Statistics package), and then it determines either the horizontal or vertical spacing between the middles of each object. The function will then return a `TopDimensions` or `BottomDimensions` object or a `LeftDimensions` or `RightDimensions` object that can then be plotted in Plots.jl and Makie.jl. The user can provide an keyword `offset` value to the functions to change the location of where the dimension will be plotted.

```@setup plots
using TapeMeasure
using Plots
using Unitful

const ft = u"ft"

# Define a few objects consisting of x and y coordinates
 x = [
     [2.5ft, 2.5ft, 3.7083333329999997ft, 3.7083333329999997ft, 2.666666667ft, 2.666666667ft, 5.333333333000001ft, 5.333333333000001ft, 4.291666667ft, 4.291666667ft, 5.5ft, 5.5ft, 2.5ft],
     [10.5ft, 10.5ft, 11.708333333ft, 11.708333333ft, 10.666666667ft, 10.666666667ft, 13.333333333ft, 13.333333333ft, 12.291666667ft, 12.291666667ft, 13.5ft, 13.5ft, 10.5ft],
     [18.5ft, 18.5ft, 19.708333333ft, 19.708333333ft, 18.666666667ft, 18.666666667ft, 21.333333333ft, 21.333333333ft, 20.291666667ft, 20.291666667ft, 21.5ft, 21.5ft, 18.5ft],
     [26.5ft, 26.5ft, 27.708333333ft, 27.708333333ft, 26.666666667ft, 26.666666667ft, 29.333333333ft, 29.333333333ft, 28.291666667ft, 28.291666667ft, 29.5ft, 29.5ft, 26.5ft],
     [34.5ft, 34.5ft, 35.708333333ft, 35.708333333ft, 34.666666667ft, 34.666666667ft, 37.333333333ft, 37.333333333ft, 36.291666667ft, 36.291666667ft, 37.5ft, 37.5ft, 34.5ft]
 ]

y = [
    [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
    [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
    [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
    [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
    [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft]
]
```

*Continuing the example from the Home page*
```@example plots
# lets add some vertical spacing between each object as well
for (i, ys) in enumerate(y)
    y[i] = ys .+ (5*i)*ft
end

dims = h_dimension(x, y, offset=3ft)

plot(x, y, seriestype=:shape, color=:lightgrey, legend=false, aspectratio=1)
plot!(dims)
```
```@example plots
dims = v_dimension(x, y, offset=-3ft)

plot(x, y, seriestype=:shape, color=:lightgrey, legend=false, aspectratio=1)
plot!(dims)
```

### Single Object
When dealing with a single object, there are four main functions currently.
- [`dim_top`](@ref dim_top)
- [`dim_bottom`](@ref dim_bottom)
- [`dim_left`](@ref dim_left)
- [`dim_right`](@ref dim_right)

These functions attempt to calculate the dimensions of the respective side of the object. These functions are really for rectangular/symetric type objects. The current implementation is limited. The user can provide an keyword `offset` value to the functions to change the location of where the dimension will be plotted. See example below.

```@example plots
top = dim_top(x[1], y[1], offset=1ft)
bottom = dim_bottom(x[1], y[1])
left = dim_left(x[1], y[1])
right = dim_right(x[1], y[1])

plot(x[1], y[1], seriestype=:shape, color=:lightgrey, legend=false, aspectratio=1)
plot!(top)
plot!(bottom)
plot!(left)
plot!(right)
```

You can see from the plot that the bottom dimension is finding the dimension of the max overall width and not the relative width at the bottom.


