using TapeMeasure
using Documenter

DocMeta.setdocmeta!(TapeMeasure, :DocTestSetup, :(using TapeMeasure); recursive=true)

makedocs(;
    modules=[TapeMeasure],
    authors="Cole Miller",
    sitename="TapeMeasure.jl",
    format=Documenter.HTML(;
        canonical="https://co1emi11er2.github.io/TapeMeasure.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/co1emi11er2/TapeMeasure.jl",
    devbranch="main",
)
