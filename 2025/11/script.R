df <- sf::st_read(
  fs::path(
    "data",
    "TTC_SUBWAY_LINES_WGS84.shp"
  )
)

df <- dplyr::arrange(df, dplyr::desc(RID))

showtext::showtext_auto()
showtext::showtext_opts(dpi = 300)
sysfonts::font_add_google("IBM Plex Mono")

grDevices::png("plot.png", width = 6, height = 6, units = "in", res = 300)

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(
    data = df,
    ggplot2::aes(color = ROUTE_NAME),
    linewidth = 2,
    lineend = "round"
  ) +
  ggplot2::theme_void() +
  ggplot2::scale_color_manual(
    values = c(
      "LINE 1 (YONGE-UNIVERSITY)" = "#F8C300",
      "LINE 2 (BLOOR - DANFORTH)" = "#00923F",
      "LINE 3 (SCARBOROUGH)" = "#0093DD",
      "LINE 4 (SHEPPARD)" = "#974578"
    )
  ) +
  ggplot2::labs(
    title = "The Subway Lines of Toronto",
    subtitle = "The four subway lines operated\nby the Toronto Transit Commission (TTC)",
    color = NULL
  ) +
  ggplot2::theme(
    legend.position = "bottom",
    plot.background = ggplot2::element_rect(fill = "#e6e6e6"),
    plot.margin = ggplot2::margin(0.25, 0.5, b = 0.425, 0.5, unit = "in"),
    plot.subtitle = ggplot2::element_text(hjust = 0.5),
    plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
    text = ggplot2::element_text(family = "IBM Plex Mono", size = 16)
  ) +
  ggplot2::guides(color = ggplot2::guide_legend(ncol = 2))

print(p)

utilities::add_author_caption(p)
utilities::add_source_caption(p, "City of Toronto")

grDevices::dev.off()
