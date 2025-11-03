world <- rnaturalearth::ne_countries(scale = 10L)

world <- dplyr::select(world, geometry)

world <- sf::st_make_valid(world)

arctic_archipelago <- sf::st_crop(
  world,
  sf::st_bbox(
    base::c(xmin = -115, ymin = 65, xmax = -65, ymax = 85),
    crs = "EPSG:4326"
  )
)

arctic_archipelago <- sf::st_transform(arctic_archipelago, crs = "EPSG:3978")

# fmt: skip
points <- tibble::tribble(
  ~"name",                                 ~"lat",     ~"lon",
  "Terror and Erebus\nabandoned in 1848",  70.1300194, -98.8807375,
  "Terror found in 2016",                  68.8056034, -99.0744739,
  "Erebus found in 2014",                  68.1321188, -98.8532519
)

points_sf <- points |>
  sf::st_as_sf(coords = c("lon", "lat"), crs = "EPSG:4326") |>
  sf::st_transform(crs = "EPSG:3978")

points <- points_sf |>
  dplyr::mutate(
    lon = sf::st_coordinates(geometry)[, 1],
    lat = sf::st_coordinates(geometry)[, 2]
  ) |>
  sf::st_drop_geometry()

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(data = arctic_archipelago, fill = "white") +
  ggplot2::geom_sf(data = points_sf) +
  ggplot2::geom_label(
    data = points,
    ggplot2::aes(
      x = lon - 1e4,
      y = lat,
      label = name
    ),
    fill = "grey80",
    hjust = 1,
    vjust = 0
  ) +
  ggplot2::annotate(
    "text",
    x = -4.5e5,
    y = 2.485e6,
    label = "Franklin's Lost Voyage",
  ) +
  ggplot2::annotate(
    "text",
    x = -5e5,
    y = 2.015e6,
    label = "Nunavut",
    hjust = 0
  ) +
  ggplot2::coord_sf(
    xlim = c(-5e5, 0),
    ylim = c(2e6, 2.5e6),
    expand = FALSE,
    datum = "EPSG:3978"
  ) +
  ggplot2::theme_void() +
  ggplot2::theme(
    panel.background = ggplot2::element_rect(fill = "#adcbd9")
  )

ggplot2::ggsave(
  "plot.png",
  p,
  width = 3,
  height = 3,
  units = "in"
)
