library(ggplot2)

visualiser <- function(df) {

  # ----------------------------------------------------------
  # Histogramme : Distribution des moyennes générales S2
  # ----------------------------------------------------------
  histo_moyennes <- ggplot(df, aes(x = moyenne_s2)) +
    geom_histogram(binwidth = 1, fill = "steelblue", color = "black") +
    labs(
      title = "Distribution des moyennes générales (S2)",
      x = "Moyenne générale S2",
      y = "Nombre d'étudiants"
    ) +
    theme_minimal()

  # ----------------------------------------------------------
  # Boxplot : moyennes par filière
  # ----------------------------------------------------------
  boxplot_filiere <- ggplot(df, aes(x = filiere, y = moyenne_s2, fill = filiere)) +
    geom_boxplot() +
    labs(
      title = "Distribution des moyennes par filière (S2)",
      x = "Filière",
      y = "Moyenne générale S2"
    ) +
    theme_minimal() +
    theme(legend.position = "none")

  # ----------------------------------------------------------
  # Scatter plot : heures d'étude vs performance S2
  # ----------------------------------------------------------
  scatter_heures <- ggplot(df, aes(x = heures_etude_semaine, y = moyenne_s2)) +
    geom_point(color = "darkorange", size = 2, alpha = 0.7) +
    geom_smooth(method = "lm", color = "blue", se = TRUE) +
    labs(
      title = "Relation heures d'étude / performance (S2)",
      x = "Heures d'étude par semaine",
      y = "Moyenne générale S2"
    ) +
    theme_minimal()

  # ----------------------------------------------------------
  # Graphique d'évolution : S1 vs S2 par étudiant
  # ----------------------------------------------------------
  df$etudiant_id <- 1:nrow(df)  # si pas déjà présent
  evo_s1_s2 <- ggplot(df, aes(x = moyenne_s1, y = moyenne_s2)) +
    geom_point(alpha = 0.6, color = "darkgreen") +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
    labs(
      title = "Évolution S1 → S2 par étudiant",
      x = "Moyenne S1",
      y = "Moyenne S2"
    ) +
    theme_minimal()

  # ----------------------------------------------------------
  # Graphique au choix : Moyenne par tranche d'heures d'étude
  # ----------------------------------------------------------
  df$heures_cat <- cut(df$heures_etude_semaine, breaks = c(4, 15, 25, 40, Inf),
                       labels = c("5-15h", "16-25h", "26-40h", ">40h"), right = TRUE)
  moy_par_tranche <- df |>
    dplyr::group_by(heures_cat) |>
    dplyr::summarise(moyenne = mean(moyenne_s2, na.rm = TRUE))

  bar_tranche <- ggplot(moy_par_tranche, aes(x = heures_cat, y = moyenne, fill = heures_cat)) +
    geom_bar(stat = "identity") +
    labs(
      title = "Moyenne S2 par tranche d'heures d'étude",
      x = "Tranche d'heures d'étude",
      y = "Moyenne générale S2"
    ) +
    theme_minimal() +
    theme(legend.position = "none")


  return(list(
    histo_moyennes = histo_moyennes,
    boxplot_filiere = boxplot_filiere,
    scatter_heures = scatter_heures,
    evo_s1_s2 = evo_s1_s2,
    bar_tranche = bar_tranche
  ))
}
