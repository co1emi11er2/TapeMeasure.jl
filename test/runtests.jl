# This sets the preferences for dispatch doctor.
# Note this does not work when running through testitems but will through terminal (ie CI)
using Preferences: set_preferences!
set_preferences!("TapeMeasure", "instability_check" => "error")

using TestItems, TestItemRunner

if isdefined(@__MODULE__,:LanguageServer)
    include("../src/TapeMeasure.jl")
end

include("setup_tests.jl")

@testitem "Horizontal Dimensions" setup=[DimensionObjectSetup] begin
    include("HDimensions.jl")
end

@testitem "Vertical Dimensions" setup=[DimensionObjectSetup] begin
    include("VDimensions.jl")
end


@run_package_tests verbose=true