```@meta
CurrentModule = TapeMeasure
```

# TapeMeasure.jl

[<img src="./assets/tape_measure_large_logo.svg" />](image.png)

TapeMeasure.jl is a Julia package for handling physical dimensions and units in scientific computing. It provides a robust framework for defining, converting, and manipulating dimensions.

## Installation

To install TapeMeasure.jl, use the Julia package manager:

```julia
using Pkg
Pkg.add("TapeMeasure")
```

## Basic Usage

Here's a basic example of how to use TapeMeasure.jl:

```@example plots
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

dims = h_dimension(x, y)

plot(x, y, seriestype=:shape, color=:lightgrey, legend=false, aspectratio=1)
plot!(dims)
```

*Can work similarly with Makie*

```@example makie
using TapeMeasure
using CairoMakie
using Unitful

const ft = u"ft"
uc = Makie.UnitfulConversion(ft)

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

dims = h_dimension(x, y)

f = Figure()
ax = Axis(f[1,1], autolimitaspect=1, dim1_conversion=uc, dim2_conversion=uc)
lines!.(ax, x, y, color=:lightgrey)
plot!(ax, dims)
f
```

## Features

- Makes dimensioning easy
- Works with Unitful
- Dimensional consistency checks
- Hope to integrate with Meshes ecosystem

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the MIT License.

## Acknowledgements

Thanks to the Julia community and the amazing Plots and Makie packages.
