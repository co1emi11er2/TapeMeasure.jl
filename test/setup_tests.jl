@testsnippet DimensionObjectSetup begin
    using StructuralUnits
    multi_girders_xs_plot_format =  x = [
        [2.5ft, 2.5ft, 3.7083333329999997ft, 3.7083333329999997ft, 2.666666667ft, 2.666666667ft, 5.333333333000001ft, 5.333333333000001ft, 4.291666667ft, 4.291666667ft, 5.5ft, 5.5ft, 2.5ft],
        [10.5ft, 10.5ft, 11.708333333ft, 11.708333333ft, 10.666666667ft, 10.666666667ft, 13.333333333ft, 13.333333333ft, 12.291666667ft, 12.291666667ft, 13.5ft, 13.5ft, 10.5ft],
        [18.5ft, 18.5ft, 19.708333333ft, 19.708333333ft, 18.666666667ft, 18.666666667ft, 21.333333333ft, 21.333333333ft, 20.291666667ft, 20.291666667ft, 21.5ft, 21.5ft, 18.5ft],
        [26.5ft, 26.5ft, 27.708333333ft, 27.708333333ft, 26.666666667ft, 26.666666667ft, 29.333333333ft, 29.333333333ft, 28.291666667ft, 28.291666667ft, 29.5ft, 29.5ft, 26.5ft],
        [34.5ft, 34.5ft, 35.708333333ft, 35.708333333ft, 34.666666667ft, 34.666666667ft, 37.333333333ft, 37.333333333ft, 36.291666667ft, 36.291666667ft, 37.5ft, 37.5ft, 34.5ft]
    ]

    multi_girders_ys_plot_format = [
        [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
        [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
        [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
        [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft],
        [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft]
    ]

    single_girder_xs_plot_format =  x = [2.5ft, 2.5ft, 3.7083333329999997ft, 3.7083333329999997ft, 2.666666667ft, 2.666666667ft, 5.333333333000001ft, 5.333333333000001ft, 4.291666667ft, 4.291666667ft, 5.5ft, 5.5ft, 2.5ft]
    single_girder_ys_plot_format = [-0.25ft, -0.541666667ft, -0.875ft, -3.375ft, -4.020833333000001ft, -4.75ft, -4.75ft, -4.020833333000001ft, -3.375ft, -0.875ft, -0.541666667ft, -0.25ft, -0.25ft]

    function test_dimension_fields(expected, calc)
        for field in fieldnames(typeof(calc))
            if field != :labels
                @debug "field: $field"
                @test getfield(calc, field) == getfield(expected, field)
            end
        end
    
        expected_lbls = expected.labels
        calc_lbls = calc.labels
        for field in fieldnames(typeof(calc_lbls))
            @debug "field: $field"
            @test getfield(calc_lbls, field) == getfield(expected_lbls, field)
        end
    end

end