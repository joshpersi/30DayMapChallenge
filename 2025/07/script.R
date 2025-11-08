df <- sf::st_read(fs::path("data", "CARIBOU_RANGE_BOUNDARY.shp"))

df <- sf::st_transform(df, "EPSG:3979")

df <- dplyr::summarize(
  df,
  geometry = sf::st_union(geometry)
)

df <- smoothr::fill_holes(df, threshold = 100)

ontario <- dplyr::filter(
  rnaturalearth::ne_states(country = "Canada"),
  name == "Ontario"
)

ontario <- sf::st_transform(ontario, "EPSG:3979")

showtext::showtext_auto()

showtext::showtext_opts(dpi = 300)

sysfonts::font_add_google(
  name = "Atkinson Hyperlegible",
  family = "Atkinson Hyperlegible"
)

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(data = ontario, fill = "#dda15e") +
  ggplot2::geom_sf(data = df, fill = "#283618") +
  ggplot2::labs(
    title = "Caribou range in Ontario",
    subtitle = "The geographic range of boreal woodland caribou,<br>*Rangifer tarandus*, in Ontario, Canada",
    caption = "Caribou range shown in dark green"
  ) +
  ggplot2::theme_void() +
  ggplot2::theme(
    text = ggplot2::element_text(
      family = "Atkinson Hyperlegible",
      color = "#283618",
      size = 16
    ),
    plot.title = ggplot2::element_text(
      face = "bold",
      size = 32
    ),
    plot.subtitle = ggtext::element_markdown(),
    plot.caption = ggplot2::element_text(hjust = 0)
  )

ggplot2::ggsave(
  "plot.png",
  p,
  width = 6,
  height = 6,
  units = "in",
  bg = "#fefae0"
)
