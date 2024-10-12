# Working with Makie.jl

TapeMeasure.jl provides an extension that loads when the user calls `using Makie`, `using CairoMakie`, or other makie package in their code.

## Changing Plot Settings:

You can change the plot settings using the following keyword arguments.

### Settings

- `color::Symbol` - changes the color of the dimension lines as well as the labels
- `with_mask::Bool` - the label will not "mask" over the dimension line
- `linewidth` - the line width of the dimension lines
- `fontsize` - the size of the label font
- `rotation` - radians of rotation for the label

The keywords are a bit different from Plots.jl in order to be more consistent with Makie ecosystem, but that may change if it is an issue for users. See below for examples:

## Examples
```@setup plots
using TapeMeasure
using CairoMakie
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

uc = Makie.UnitfulConversion(ft)
```

```@example plots
dims = h_dimension(x, y)

f = Figure()
ax = Axis(f[1,1], autolimitaspect=1, dim1_conversion=uc, dim2_conversion=uc)
lines!.(ax, x, y, color=:lightgrey)
plot!(ax, dims, color=:blue, with_mask=false, fontsize = 10)
f
```

```@example plots
dims = v_dimension(y, x)

f = Figure()
ax = Axis(f[1,1], autolimitaspect=1, dim1_conversion=uc, dim2_conversion=uc)
lines!.(ax, y, x, color=:lightgrey)
plot!(ax, dims, rotation = 0)
f
```