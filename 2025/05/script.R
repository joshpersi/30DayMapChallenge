dem <- terra::rast(fs::path("data", "DEM.tif"))

breaks <- base::seq(0, 3000, by = 150)

dem <- terra::as.polygons(terra::classify(dem, breaks))

dem <- sf::st_as_sf(dem)

dem <- sf::st_transform(dem, crs = "EPSG:4617")

showtext::showtext_auto()

showtext::showtext_opts(dpi = 300)

sysfonts::font_add_google(name = "Cabin", family = "Cabin")

palette <- c(
  "#1a7a1a", # Dark green - lowlands
  "#2d8b2d", # Green
  "#4a9b4a", # Medium green
  "#70b870", # Light green
  "#a3d96c", # Yellow-green
  "#d4e7a3", # Pale green-yellow
  "#ffffbe", # Yellow
  "#e8c78e", # Tan
  "#c8a26d", # Light brown
  "#a67c52", # Brown
  "#ffffff" # White - peaks
)

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(data = dem, aes(fill = DEM)) +
  ggplot2::scale_fill_manual(values = palette) +
  ggplot2::scale_x_continuous(expand = ggplot2::expansion()) +
  ggplot2::scale_y_continuous(expand = ggplot2::expansion()) +
  ggplot2::labs(
    title = "Elevation of the Kananaskis Valley",
    subtitle = "The northern portion of the\nKananaskis Valley in Alberta, Canada"
  ) +
  ggplot2::theme_void() +
  ggplot2::theme(
    legend.position = "none",
    panel.border = ggplot2::element_rect(color = "#000000"),
    plot.margin = ggplot2::margin(t = 0.5, r = 0, b = 0.5, l = 0, unit = "cm"),
    text = ggplot2::element_text(family = "Cabin")
  )

ggplot2::ggsave(
  "plot.png",
  p,
  width = 4,
  height = 5,
  units = "in",
  bg = "#FFFFFF"
)
