using Documenter, Heatmap

makedocs(
    modules = [Heatmap],
    clean = false,
    sitename = "Heatmap.jl",
    pages = [
        "Home" => "index.md",
        "Gallery" => "gallery/Examples.md",
        "Library" => "lib/library.md"
    ],
)


deploydocs(
    repo = "github.com/Mattriks/Heatmap.jl.git",
)
