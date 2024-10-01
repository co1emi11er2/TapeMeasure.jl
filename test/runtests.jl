using TestItems, TestItemRunner

if isdefined(@__MODULE__,:LanguageServer)
    include("../src/Dimensions.jl")
end

include("setup_tests.jl")

@testitem "Top Dimensions" setup=[DimensionObjectSetup] begin
    include("TopDimensions.jl")
end

@testitem "Bottom Dimensions" setup=[DimensionObjectSetup] begin
    include("BottomDimensions.jl")
end

@testitem "Right Dimensions" setup=[DimensionObjectSetup] begin
    include("RightDimensions.jl")
end

@testitem "Left Dimensions" setup=[DimensionObjectSetup] begin
    include("LeftDimensions.jl")
end

@run_package_tests verbose=true