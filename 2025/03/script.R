showtext::showtext_auto()

showtext::showtext_opts(dpi = 300)

sysfonts::font_add_google(name = "Rye", family = "Rye")

france <- rnaturalearth::ne_states(country = "France")

france <- dplyr::filter(
  france,
  type == "Metropolitan département",
  region != "Corse"
)

france <- dplyr::arrange(france, region, name)

france <- dplyr::select(france, region, name)

# fmt: skip
palette <- tibble::tribble(
  ~region,                      ~name,                      ~color,
  "Auvergne-Rhône-Alpes",       "Ain",                      "#1f4788",
  "Auvergne-Rhône-Alpes",       "Allier",                   NA,
  "Auvergne-Rhône-Alpes",       "Ardèche",                  NA,
  "Auvergne-Rhône-Alpes",       "Cantal",                   NA,
  "Auvergne-Rhône-Alpes",       "Drôme",                    NA,
  "Auvergne-Rhône-Alpes",       "Haute-Loire",              NA,
  "Auvergne-Rhône-Alpes",       "Haute-Savoie",             NA,
  "Auvergne-Rhône-Alpes",       "Isère",                    NA,
  "Auvergne-Rhône-Alpes",       "Loire",                    NA,
  "Auvergne-Rhône-Alpes",       "Puy-de-Dôme",              NA,
  "Auvergne-Rhône-Alpes",       "Rhône",                    NA,
  "Auvergne-Rhône-Alpes",       "Savoie",                   NA,
  "Bourgogne-Franche-Comté",    "Côte-d'Or",                "#E9D8A6",
  "Bourgogne-Franche-Comté",    "Doubs",                    NA,
  "Bourgogne-Franche-Comté",    "Haute-Saône",              NA,
  "Bourgogne-Franche-Comté",    "Jura",                     NA,
  "Bourgogne-Franche-Comté",    "Nièvre",                   NA,
  "Bourgogne-Franche-Comté",    "Saône-et-Loire",           NA,
  "Bourgogne-Franche-Comté",    "Territoire de Belfort",    NA,
  "Bourgogne-Franche-Comté",    "Yonne",                    NA,
  "Bretagne",                   "Côtes-d'Armor",            "#c2523c",
  "Bretagne",                   "Finistère",                NA,
  "Bretagne",                   "Ille-et-Vilaine",          NA,
  "Bretagne",                   "Morbihan",                 NA,
  "Centre-Val de Loire",        "Cher",                     "#006d2c",
  "Centre-Val de Loire",        "Eure-et-Loir",             NA,
  "Centre-Val de Loire",        "Indre",                    NA,
  "Centre-Val de Loire",        "Indre-et-Loire",           NA,
  "Centre-Val de Loire",        "Loir-et-Cher",             NA,
  "Centre-Val de Loire",        "Loiret",                   NA,
  "Grand Est",                  "Ardennes",                 "#ffafcc",
  "Grand Est",                  "Aube",                     NA,
  "Grand Est",                  "Bas-Rhin",                 NA,
  "Grand Est",                  "Haute-Marne",              NA,
  "Grand Est",                  "Haute-Rhin",               NA,
  "Grand Est",                  "Marne",                    NA,
  "Grand Est",                  "Meurthe-et-Moselle",       NA,
  "Grand Est",                  "Meuse",                    NA,
  "Grand Est",                  "Moselle",                  NA,
  "Grand Est",                  "Vosges",                   NA,
  "Hauts-de-France",            "Aisne",                    "#542788",
  "Hauts-de-France",            "Nord",                     NA,
  "Hauts-de-France",            "Oise",                     NA,
  "Hauts-de-France",            "Pas-de-Calais",            NA,
  "Hauts-de-France",            "Somme",                    NA,
  "Normandie",                  "Calvados",                 "#084594",
  "Normandie",                  "Eure",                     NA,
  "Normandie",                  "Manche",                   NA,
  "Normandie",                  "Orne",                     NA,
  "Normandie",                  "Seine-Maritime",           NA,
  "Nouvelle-Aquitaine",         "Charente",                 "#8c510a",
  "Nouvelle-Aquitaine",         "Charente-Maritime",        NA,
  "Nouvelle-Aquitaine",         "Corrèze",                  NA,
  "Nouvelle-Aquitaine",         "Creuse",                   NA,
  "Nouvelle-Aquitaine",         "Deux-Sèvres",              NA,
  "Nouvelle-Aquitaine",         "Dordogne",                 NA,
  "Nouvelle-Aquitaine",         "Gironde",                  NA,
  "Nouvelle-Aquitaine",         "Haute-Vienne",             NA,
  "Nouvelle-Aquitaine",         "Landes",                   NA,
  "Nouvelle-Aquitaine",         "Lot-et-Garonne",           NA,
  "Nouvelle-Aquitaine",         "Pyrénées-Atlantiques",     NA,
  "Nouvelle-Aquitaine",         "Vienne",                   NA,
  "Occitanie",                  "Ariège",                   "#01665e",
  "Occitanie",                  "Aude",                     NA,
  "Occitanie",                  "Aveyron",                  NA,
  "Occitanie",                  "Gard",                     NA,
  "Occitanie",                  "Gers",                     NA,
  "Occitanie",                  "Haute-Garonne",            NA,
  "Occitanie",                  "Hautes-Pyrénées",          NA,
  "Occitanie",                  "Hérault",                  NA,
  "Occitanie",                  "Lot",                      NA,
  "Occitanie",                  "Lozère",                   NA,
  "Occitanie",                  "Pyrénées-Orientales",      NA,
  "Occitanie",                  "Tarn",                     NA,
  "Occitanie",                  "Tarn-et-Garonne",          NA,
  "Pays de la Loire",           "Loire-Atlantique",         "#EE9B00",
  "Pays de la Loire",           "Maine-et-Loire",           NA,
  "Pays de la Loire",           "Mayenne",                  NA,
  "Pays de la Loire",           "Sarthe",                   NA,
  "Pays de la Loire",           "Vendée",                   NA,
  "Provence-Alpes-Côte-d'Azur", "Alpes-Maritimes",          "#4d004b",
  "Provence-Alpes-Côte-d'Azur", "Alpes-de-Haute-Provence",  NA,
  "Provence-Alpes-Côte-d'Azur", "Bouches-du-Rhône",         NA,
  "Provence-Alpes-Côte-d'Azur", "Hautes-Alpes",             NA,
  "Provence-Alpes-Côte-d'Azur", "Var",                      NA,
  "Provence-Alpes-Côte-d'Azur", "Vaucluse",                 NA,
  "Île-de-France",              "Essonne",                  "#00441b",
  "Île-de-France",              "Hauts-de-Seine",           NA,
  "Île-de-France",              "Paris",                    NA,
  "Île-de-France",              "Seine-et-Marne",           NA,
  "Île-de-France",              "Seine-Saint-Denis",        NA,
  "Île-de-France",              "Val-d'Oise",               NA,
  "Île-de-France",              "Val-de-Marne",             NA,
  "Île-de-France",              "Yvelines",                 NA
)

palette <- dplyr::mutate(
  palette,
  color = purrr::accumulate(
    color,
    \(prev, current) {
      dplyr::if_else(
        rlang::is_na(current),
        colorspace::lighten(prev, amount = 0.1),
        current
      )
    }
  ),
  .by = region
)

palette <- palette |>
  dplyr::select(name, color) |>
  tibble::deframe()

region_labels <- france |>
  dplyr::summarize(geometry = sf::st_union(geometry), .by = region) |>
  dplyr::mutate(geometry = sf::st_centroid(geometry)) |>
  dplyr::mutate(
    lon = sf::st_coordinates(geometry)[1],
    lat = sf::st_coordinates(geometry)[2],
    .by = geometry
  )

region_labels <- dplyr::mutate(
  region_labels,
  region = stringr::str_wrap(region, width = 10)
)

p <- ggplot2::ggplot() +
  ggplot2::geom_sf(data = france, ggplot2::aes(fill = name)) +
  ggrepel::geom_label_repel(
    data = region_labels,
    ggplot2::aes(x = lon, y = lat, label = region),
    nudge_x = region_labels$nudge_x,
    nudge_y = region_labels$nudge_y,
    xlim = c(-Inf, Inf),
    ylim = c(-Inf, Inf),
    min.segment.length = 2.5
  ) +
  ggplot2::scale_fill_manual(values = palette) +
  ggplot2::labs(
    title = "Regions of France"
  ) +
  ggplot2::theme_void() +
  ggplot2::theme(
    legend.position = "none",
    text = ggplot2::element_text(family = "Rye"),
    plot.title = ggplot2::element_text(hjust = 0.5, size = 32)
  ) +
  ggplot2::coord_sf(clip = "off")

ggplot2::ggsave(
  "plot.png",
  p,
  width = 6,
  height = 6,
  units = "in",
  bg = "#fefae0"
)
