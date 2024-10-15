using TestItems, TestItemRunner

if isdefined(@__MODULE__,:LanguageServer)
    include("../src/Dimensions.jl")
end

include("setup_tests.jl")

@testitem "Horizontal Dimensions" setup=[DimensionObjectSetup] begin
    include("HDimensions.jl")
end

@testitem "Vertical Dimensions" setup=[DimensionObjectSetup] begin
    include("VDimensions.jl")
end


@run_package_tests verbose=true