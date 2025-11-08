# Data pulled from https://open.canada.ca/data/en/dataset/9797a946-9da8-41ec-8815-f6b276dec7e9

montreal <- sf::st_read(fs::path(
  "data",
  "limites-administratives-agglomeration.shp"
))

montreal <- dplyr::mutate(montreal, geometry = sf::st_union(geometry))

roads <- sf::st_read(
  fs::path("data", "lrnf000r25a_e.shp"),
  query = "SELECT * FROM lrnf000r25a_e WHERE PRNAME_R = 'Quebec / Québec'"
)

roads <- sf::st_transform(roads, crs = "EPSG:4326")

roads <- sf::st_crop(roads, montreal)

roads_major <- dplyr::filter(roads, TYPE == "AUT")

roads_minor <- dplyr::filter(roads, TYPE != "AUT")

showtext::showtext_auto()

showtext::showtext_opts(dpi = 300)

sysfonts::font_add_google("Fascinate", "Fascinate")

sysfonts::font_add_google("Atkinson Hyperlegible", "Atkinson Hyperlegible")

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(
    data = roads_minor,
    color = "#CCCCCC",
    linewidth = 0.3,
  ) +
  ggplot2::geom_sf(
    data = roads_major,
    color = "#174397",
    linewidth = 1.0,
  ) +
  ggplot2::coord_sf(
    expand = FALSE
  ) +
  ggplot2::labs(
    title = "Roads of Montreal",
    subtitle = "Highways, or *autoroutes*, are shown in blue",
  ) +
  ggplot2::theme_void() +
  ggplot2::theme(
    panel.border = ggplot2::element_rect(color = "#174397", linewidth = 1),
    plot.margin = ggplot2::margin(0.25, 0.25, 0.25, 0.25, "in"),
    plot.subtitle = ggtext::element_markdown(
      family = "Atkinson Hyperlegible",
      size = 10,
      color = "#174397"
    ),
    text = ggplot2::element_text(family = "Fascinate", color = "#174397")
  )

ggplot2::ggsave(
  "plot.png",
  p,
  width = 4,
  height = 4,
  dpi = 300,
  bg = "#FFFFFF"
)
