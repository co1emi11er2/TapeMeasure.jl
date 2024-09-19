using Dimensions
using Documenter

DocMeta.setdocmeta!(Dimensions, :DocTestSetup, :(using Dimensions); recursive=true)

makedocs(;
    modules=[Dimensions],
    authors="Cole Miller",
    sitename="Dimensions.jl",
    format=Documenter.HTML(;
        canonical="https://co1emi11er2.github.io/Dimensions.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/co1emi11er2/Dimensions.jl",
    devbranch="main",
)
