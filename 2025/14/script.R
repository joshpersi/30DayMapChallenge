ottawa_bbox <- osmdata::opq(bbox = "Ottawa, Canada")

ottawa_daycares <- ottawa_bbox |>
  osmdata::add_osm_feature(
    key = "amenity",
    value = base::c("childcare", "daycare", "kindergarten")
  ) |>
  osmdata::osmdata_sf() |>
  purrr::pluck("osm_points")

ottawa_bbox <- sf::st_bbox(ottawa_daycares)

grid <- sf::st_make_grid(
  ottawa_bbox,
  cellsize = 0.01,
  what = "polygons"
)

grid <- sf::st_as_sf(grid)

# Count daycares per grid cell
grid$daycare_count <- lengths(st_intersects(grid, ottawa_daycares))

# Calculate density (daycares per sq km)
grid$area_km2 <- as.numeric(st_area(grid)) / 1e6
grid$density <- grid$daycare_count / grid$area_km2

grid <- sf::st_transform(grid, sf::st_crs(ottawa_daycares))

library(ggplot2)

ontario <-
  rnaturalearth::ne_states(country = "Canada") |>
  dplyr::filter(name == "Ontario")

ggplot() +
  geom_sf(data = ontario) +
  geom_sf(data = grid, aes(fill = density), alpha = 0.5) +
  geom_sf(data = ottawa_daycares, size = 0.5, alpha = 0.6) +
  coord_sf(
    xlim = ottawa_bbox[c("xmin", "xmax")],
    ylim = ottawa_bbox[c("ymin", "ymax")],
  ) +
  scale_fill_viridis_c(option = "plasma") +
  theme_minimal() +
  labs(title = "Daycare Density by Area in Ottawa", fill = "Daycares per km²")
