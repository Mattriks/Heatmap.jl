var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#Heatmap.jl-1",
    "page": "Home",
    "title": "Heatmap.jl",
    "category": "section",
    "text": ""
},

{
    "location": "#Introduction-1",
    "page": "Home",
    "title": "Introduction",
    "category": "section",
    "text": "This is a work in progress, and currently there are errors to be fixed."
},

{
    "location": "#Gallery-1",
    "page": "Home",
    "title": "Gallery",
    "category": "section",
    "text": "Pages = [joinpath(\"gallery\", \"Examples.md\")]\nDepth = 1"
},

{
    "location": "#Library-1",
    "page": "Home",
    "title": "Library",
    "category": "section",
    "text": "Pages = [joinpath(\"lib\",\"library.md\")]"
},

{
    "location": "#Documentation-1",
    "page": "Home",
    "title": "Documentation",
    "category": "section",
    "text": "The documentation was built using Documenter.jl.println(\"Documentation built with Julia $(VERSION).\") # hide"
},

{
    "location": "gallery/Examples/#",
    "page": "Gallery",
    "title": "Gallery",
    "category": "page",
    "text": ""
},

{
    "location": "gallery/Examples/#Examples-1",
    "page": "Gallery",
    "title": "Examples",
    "category": "section",
    "text": "using Heatmap, Gadfly, RDatasets, StatsBase\nhm = Heatmap\nnothing # hide"
},

{
    "location": "gallery/Examples/#Raw-matrix-1",
    "page": "Gallery",
    "title": "Raw matrix",
    "category": "section",
    "text": "set_default_plot_size(8inch, 6inch)\nmtcars = dataset(\"datasets\", \"mtcars\")\nZ = zscore(Matrix{Float64}(mtcars[:,2:11]),1)\nplot(z=Z, x=mtcars.Model, y=names(mtcars)[2:11], hm.heatmap(matrix=\"raw\"), \n    Geom.rectbin, hm.dendrogram(dendrogram=\"both\"),\n Scale.color_continuous(colormap=Scale.lab_gradient(\"steelblue3\",\"white\",\"darkred\"))\n)"
},

{
    "location": "gallery/Examples/#Distance-matrix-1",
    "page": "Gallery",
    "title": "Distance matrix",
    "category": "section",
    "text": "set_default_plot_size(8inch, 8inch)\nplot(z=Z, x=mtcars.Model, y=mtcars.Model, hm.heatmap(matrix=\"distance\"), \n    Geom.rectbin, hm.dendrogram(dendrogram=\"both\"),\n Scale.color_continuous(colormap=Scale.lab_gradient(\"steelblue3\",\"white\",\"darkred\")),\n    Coord.cartesian(aspect_ratio=1)\n)\n"
},

{
    "location": "lib/library/#",
    "page": "Library",
    "title": "Library",
    "category": "page",
    "text": ""
},

{
    "location": "lib/library/#Library-1",
    "page": "Library",
    "title": "Library",
    "category": "section",
    "text": "Pages = [\"library.md\"]"
},

{
    "location": "lib/library/#Heatmap.Dendrogram",
    "page": "Library",
    "title": "Heatmap.Dendrogram",
    "category": "type",
    "text": "Dendrogram\n\nA Gadfly GuideElement type for marginal dendrograms.\n\n\n\n\n\n"
},

{
    "location": "lib/library/#Heatmap.HeatMapStatistic",
    "page": "Library",
    "title": "Heatmap.HeatMapStatistic",
    "category": "type",
    "text": "HeatMapStatistic\n\nA Gadfly StatisticElement type for heatmaps.\n\n\n\n\n\n"
},

{
    "location": "lib/library/#Types-1",
    "page": "Library",
    "title": "Types",
    "category": "section",
    "text": "Modules = [Heatmap]\nOrder   = [:type]"
},

{
    "location": "lib/library/#Heatmap.dendrogram-Tuple{}",
    "page": "Library",
    "title": "Heatmap.dendrogram",
    "category": "method",
    "text": "dendrogram(; dendrogram=\"both\", metric=Euclidean())\n\nConstruct a  dendrogram guide. dendrogram can be \"row\", \"column\" or \"both\". metric as in package Distances. Note that currently metric is independent of heatmap(matrix=\"distance\", metric= ) hence both need to be specified if plotting a distance matrix heatmap.\n\n\n\n\n\n"
},

{
    "location": "lib/library/#Heatmap.heatmap-Tuple{}",
    "page": "Library",
    "title": "Heatmap.heatmap",
    "category": "method",
    "text": "heatmap(; matrix=\"raw\", metric=Euclidean())\n\nConstruct a heatmap type. matrix can be \"raw\" or \"distance\". metric as in package Distances. \n\n\n\n\n\n"
},

{
    "location": "lib/library/#Functions-1",
    "page": "Library",
    "title": "Functions",
    "category": "section",
    "text": "Modules = [Heatmap]\nOrder   = [:function]"
},

]}
