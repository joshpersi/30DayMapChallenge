df <- terra::rast("2m_temperature_0_daily-mean.nc")

df <- df$`t2m_valid_time=0`

terra::ext(df) <- terra::ext(0, 360, -90, 90)

df <- terra::rotate(df)

df <- base::as.data.frame(df, xy = TRUE, na.rm = TRUE)

tibble::as_tibble()

showtext::showtext_auto()
showtext::showtext_opts(dpi = 300)
sysfonts::font_add_google("DM Serif Text")

p <- ggplot2::ggplot(df, ggplot2::aes(x, y, fill = `t2m_valid_time=0`)) +
  ggplot2::geom_raster() +
  ggplot2::scale_x_continuous(
    expand = expansion()
  ) +
  ggplot2::scale_y_continuous(
    expand = expansion()
  ) +
  ggplot2::scale_fill_viridis_c(option = "plasma", na.value = "transparent") +
  ggplot2::coord_sf(crs = "ESRI:54009") +
  ggplot2::theme_void() +
  ggplot2::theme(
    legend.position = "none",
    panel.border = ggplot2::element_rect(colour = "black", linewidth = 3),
    plot.margin = ggplot2::margin(
      t = 0.5,
      r = 0.10,
      b = 0.5,
      l = 0.10,
      unit = "in"
    ),
    plot.title = ggplot2::element_text(size = 64),
    plot.subtitle = ggplot2::element_text(
      size = 24,
      margin = ggplot2::margin(
        t = 0.05,
        b = 0.25,
        unit = "in"
      )
    ),
    text = ggplot2::element_text(family = "DM Serif Text")
  ) +
  ggplot2::labs(
    title = "Air temperature",
    subtitle = "Mean air temperature at 2m above the surface of the Earth on January 1st, 2024"
  )

ggsave(
  "plot.png",
  width = 15,
  height = 9,
  units = "in",
  bg = "white"
)
