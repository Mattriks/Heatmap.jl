module Heatmap

using Distances, Clustering
using Compose, Gadfly, StatsBase

PositionedGuide = Gadfly.Guide.PositionedGuide
top_guide_position = Gadfly.Guide.top_guide_position
right_guide_position = Gadfly.Guide.right_guide_position

"""
    HeatMapStatistic

A Gadfly `StatisticElement` type for heatmaps.
"""
struct HeatMapStatistic <: Gadfly.StatisticElement
   matrix::String
   metric::Metric 
end

"""
    heatmap(; matrix="raw", metric=Euclidean())

Construct a `heatmap` type. `matrix` can be "raw" or "distance". `metric` as in package `Distances`. 
"""
heatmap(; matrix::String="raw", metric::Metric=Euclidean()) = HeatMapStatistic(matrix, metric)


Gadfly.Stat.input_aesthetics(stat::HeatMapStatistic) =  [:z, :x, :y]
Gadfly.Stat.output_aesthetics(stat::HeatMapStatistic) = [:xmin, :xmax, :ymin, :ymax]
Gadfly.Stat.default_scales(stat::HeatMapStatistic) = [Scale.z_func(), Scale.x_discrete(), Scale.y_discrete(), Scale.color_continuous()]


function Gadfly.Stat.apply_statistic(stat::HeatMapStatistic,
                         scales::Dict{Symbol, Gadfly.ScaleElement},
                         coord::Gadfly.CoordinateElement,
                         aes::Gadfly.Aesthetics)
    n, p = size(aes.z)
    if stat.matrix=="distance"
        aes.y = repeat(aes.x, inner=n)
        aes.x = repeat(aes.x, outer=n)
        dist = pairwise(stat.metric, aes.z, dims=1)
        aes.color_key_title = replace(string(typeof(stat.metric), "\n","distance"), "Distances."=>"")
    else
        aes.x = repeat(aes.x, outer=p)
        aes.y = repeat(aes.y, inner=n)
        dist = aes.z
        aes.color_key_title = ""
    end
    Stat.apply_statistic(Stat.rectbin(), scales, coord, aes)
    color_scale = get(scales, :color, Scale.color_continuous)
    Scale.apply_scale(color_scale, [aes], Gadfly.Data(color=vec(dist)))
end


function branches(hc::Hclust, useheight::Bool=true)
    order = StatsBase.indexmap(hc.order)
    nodepos = Dict(-i => (float(order[i]), 0.0) for i in hc.order)

    branches1 = Vector{NTuple{2, Float64}}[]
    branches2 = Vector{NTuple{2, Float64}}[]
    ypos = 0.0
    
    for i in 1:size(hc.merges, 1)
        x1, y1 = nodepos[hc.merges[i, 1]]
        x2, y2 = nodepos[hc.merges[i, 2]]

        xpos = (x1 + x2) / 2
        h = useheight ? hc.heights[i] : 1.0
        ypos = max(y1, y2) + h
        
        nodepos[i] = (xpos, ypos)
        push!(branches1, [(x1,y1), (x1,ypos), (x2,ypos), (x2,y2)])
        push!(branches2, [(y1,x1), (ypos,x1), (ypos,x2), (y2,x2)])
    end

    return (branches1, branches2, ypos)
end


"""
    Dendrogram

A Gadfly `GuideElement` type for marginal dendrograms.
"""
struct Dendrogram <: Gadfly.GuideElement
    dendrogram::String
    metric::Metric
end

"""
    dendrogram(; dendrogram="both", metric=Euclidean())

Construct a  dendrogram guide. `dendrogram` can be "row", "column" or "both". `metric` as in package `Distances`.
Note that currently `metric` is independent of `heatmap(matrix="distance", metric= )` hence both need to be specified if plotting a distance matrix heatmap.
"""
dendrogram(; dendrogram::String="both", metric::Metric=Euclidean()) = Dendrogram(dendrogram, metric)


function Gadfly.Guide.render(guide::Dendrogram, theme::Gadfly.Theme, aes::Gadfly.Aesthetics)

    adict = Dict{String, Vector{Int}}("row"=>[1], "column"=>[2], "both"=>[1,2]) 
    dims = adict[guide.dendrogram]
    n, p = size(aes.z)

    pgv = PositionedGuide[]
    if in(1, dims)
        hc = hclust(pairwise(guide.metric, aes.z, dims=1))
        branches1, _, ypos = branches(hc)
        ctx = context(units=UnitBox(0.5, ypos, n, -ypos, bottompad=4px), minheight=25)
        compose!(ctx, line(branches1), stroke("black"), linewidth(0.3pt))
        push!(pgv, PositionedGuide([ctx], 0, top_guide_position))
    end
    if in(2, dims)
        d = 2
        if occursin("distance", aes.color_key_title)
            p, d = n, 1
        end
        hc = hclust(pairwise(guide.metric, aes.z, dims=d))
        _, branches2, ypos = branches(hc)
        ctx2 = context(units=UnitBox(0, p+0.5,  ypos, -p, leftpad=4px), minwidth=25)
        compose!(ctx2, line(branches2), stroke("black"), linewidth(0.3pt))
        push!(pgv, PositionedGuide([ctx2], 0, right_guide_position))
    end
    return pgv
end



end # module
