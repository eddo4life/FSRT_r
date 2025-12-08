# Analyse de l'evolution des performances entre S1 et S2
analyse_evolution <- function(df) {

  # Comparaison des moyennes S1 vs S2
  s1_mean <- mean(df$moyenne_s1, na.rm = TRUE)
  s2_mean <- mean(df$moyenne_s2, na.rm = TRUE)

  comparaison_moyennes <- list(
    moyenne_s1 = s1_mean,
    moyenne_s2 = s2_mean,
    evolution_globale = s2_mean - s1_mean,
    interpretation = ifelse(
      s2_mean > s1_mean,
      "La moyenne générale des étudiants s'est améliorée au semestre 2.",
      ifelse(s2_mean < s1_mean,
             "La moyenne générale a diminué au semestre 2.",
             "Les performances globales sont identiques entre S1 et S2.")
    )
  )


  # Distribution des variations individuelles
  df$variation <- df$moyenne_s2 - df$moyenne_s1

  distribution_variations <- list(
    moyenne_variation = mean(df$variation),
    mediane_variation = median(df$variation),
    ecart_type_variation = sd(df$variation),
    minimum_variation = min(df$variation),
    maximum_variation = max(df$variation)
  )


  # Identification progression et regression
  df$classification <- dplyr::case_when(
    df$variation > 0 ~ "progression",
    df$variation < 0 ~ "regression",
    TRUE ~ "stable"
  )

  progression_regression <- list(
    nb_progressions = sum(df$variation > 0),
    nb_regressions  = sum(df$variation < 0),
    nb_stables      = sum(df$variation == 0),
    pourcentage_progressions = mean(df$variation > 0) * 100,
    pourcentage_regressions  = mean(df$variation < 0) * 100,
    pourcentage_stables      = mean(df$variation == 0) * 100
  )


  # Top 10 des progressions
  top_10_progressions <- df |>
    dplyr::arrange(desc(variation)) |>
    dplyr::slice(1:10) |>
    dplyr::select(id_etudiant, nom, moyenne_s1, moyenne_s2, variation)


  # Top 10 des regressions
  top_10_regressions <- df |>
    dplyr::arrange(variation) |>
    dplyr::slice(1:10) |>
    dplyr::select(id_etudiant, nom, moyenne_s1, moyenne_s2, variation)


  # Resultat global
  return(list(
    comparaison_moyennes = comparaison_moyennes,
    distribution_variations = distribution_variations,
    progression_regression = progression_regression,
    top_10_progressions = top_10_progressions,
    top_10_regressions = top_10_regressions
  ))
}
