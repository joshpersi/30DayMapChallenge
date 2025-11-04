# Data manually downloaded from https://www.pcta.org/discover-the-trail/maps/pct-data/

# Load the data
pct <- sf::st_read(fs::path("data", "Full_PCT_Simplified.shp"))

states <- rnaturalearth::ne_states(country = "United States of America")

states <- dplyr::filter(
  states,
  name %in%
    base::c(
      "Arizona",
      "California",
      "Idaho",
      "Montana",
      "Nevada",
      "Oregon",
      "Utah",
      "Washington"
    )
)

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(data = states, fill = "#FFFFFF") +
  ggplot2::geom_sf(data = pct, color = "#606c38") +
  ggplot2::coord_sf(
    xlim = base::c(-125, -112.5)
  ) +
  ggplot2::theme_void() +
  ggplot2::theme()

ggplot2::ggsave(
  "plot.png",
  p,
  width = 3,
  height = 3,
  units = "in",
  bg = "#FFFFFF"
)
