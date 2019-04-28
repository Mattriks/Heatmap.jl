# Examples


```@example 1
using Heatmap, Gadfly, RDatasets, StatsBase
hm = Heatmap
nothing # hide
```
## Raw matrix
```@example 1
set_default_plot_size(8inch, 6inch)
mtcars = dataset("datasets", "mtcars")
Z = zscore(Matrix{Float64}(mtcars[:,2:11]),1)
plot(z=Z, x=mtcars.Model, y=names(mtcars)[2:11], hm.heatmap(matrix="raw"), 
    Geom.rectbin, hm.dendrogram(dendrogram="both"),
 Scale.color_continuous(colormap=Scale.lab_gradient("steelblue3","white","darkred"))
)
```

## Distance matrix
```@example 1
set_default_plot_size(8inch, 8inch)
plot(z=Z, x=mtcars.Model, y=mtcars.Model, hm.heatmap(matrix="distance"), 
    Geom.rectbin, hm.dendrogram(dendrogram="both"),
 Scale.color_continuous(colormap=Scale.lab_gradient("steelblue3","white","darkred")),
    Coord.cartesian(aspect_ratio=1)
)

```


