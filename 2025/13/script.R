# Data links
# https://open.canada.ca/data/en/dataset/d0cdef71-9343-46c3-b2e7-c1ded5907686
# https://open.canada.ca/data/en/dataset/6c78fb2f-d23b-45b4-b3af-cc6f6cc4fff8
# https://open.canada.ca/data/en/dataset/4f154582-bc36-42fb-8dee-25d863466081

lakes_rivers <- sf::st_read(
  fs::path("data", "lhy_000c16a_e", "lhy_000c16a_e.shp")
)

rivers <- sf::st_read(
  fs::path("data", "lhy_000d16a_e", "lhy_000d16a_e.shp")
)

coastal_waters <- sf::st_read(
  fs::path("data", "lhy_000h16a_e", "lhy_000h16a_e.shp")
)

canada <- rnaturalearth::ne_countries(country = "Canada")

canada <- sf::st_transform(canada, crs = st_crs(rivers))

ragg::agg_png(
  filename = "plot.png",
  width = 6,
  height = 6,
  units = "in",
  res = 300
)

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(data = canada, color = "grey80", fill = "white") +
  ggplot2::geom_sf(data = rivers, color = "blue") +
  ggplot2::theme_void() +
  ggplot2::labs(title = "The Rivers of Canada")

utilities::add_author_caption(p)

utilities::add_source_caption("Government of Canada Census Data 2016")

print(p)

dev.off()
