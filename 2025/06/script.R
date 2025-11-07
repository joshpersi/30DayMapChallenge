dem_raster <- terra::rast(fs::path("data", "DEM.tif"))

dem_matrix <- rayshader::raster_to_matrix(dem_raster)

dem_matrix |>
  rayshader::sphere_shade(sunangle = 60) |>
  rayshader::add_water(rayshader::detect_water(dem_matrix)) |>
  rayshader::add_shadow(rayshader::ray_shade(dem_matrix), 0.5) |>
  rayshader::add_shadow(
    rayshader::ambient_shade(dem_matrix, maxsearch = 30),
    0
  ) |>
  rayshader::plot_3d(
    dem_matrix,
    zscale = 20,
    fov = 0,
    theta = 135,
    zoom = 0.75,
    phi = 45,
    windowsize = c(1000, 800)
  )
