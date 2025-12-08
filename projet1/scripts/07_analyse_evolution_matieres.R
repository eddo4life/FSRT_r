# Analyse de l'evolution des performances par matiere entre S1 et S2
analyse_evolution_matieres <- function(df) {

  matieres <- list(
    math     = c("note_math_s1","note_math_s2"),
    info     = c("note_info_s1","note_info_s2"),
    physique = c("note_physique_s1","note_physique_s2"),
    economie = c("note_economie_s1","note_economie_s2"),
    anglais  = c("note_anglais_s1","note_anglais_s2")
  )

  comparaison <- list()
  progression_regression <- list()
  tests_stats <- list()

  # Analyse par matiere
  for (matiere in names(matieres)) {

    col_s1 <- matieres[[matiere]][1]
    col_s2 <- matieres[[matiere]][2]

    # On compare les moyennes S1 vs S2
    moy_s1 <- mean(df[[col_s1]], na.rm = TRUE)
    moy_s2 <- mean(df[[col_s2]], na.rm = TRUE)
    diff   <- moy_s2 - moy_s1

    comparaison[[matiere]] <- list(
      moyenne_s1 = moy_s1,
      moyenne_s2 = moy_s2,
      difference = diff,
      interpretation = ifelse(
        diff > 0, "Amelioration",
        ifelse(diff < 0, "Baisse", "Stable")
      )
    )

    # Calcuul des matieres en progression / regression
    variation_individuelle <- df[[col_s2]] - df[[col_s1]]

    progression_regression[[matiere]] <- list(
        nb_progressions = sum(variation_individuelle > 0, na.rm = TRUE),
        nb_regressions  = sum(variation_individuelle < 0, na.rm = TRUE),
        nb_stables      = sum(variation_individuelle == 0, na.rm = TRUE)
    )

    # Tests de comparaison 
    test <- t.test(df[[col_s1]], df[[col_s2]], paired = TRUE)

    tests_stats[[matiere]] <- list(
      t_statistique = test$statistic,
      p_value = test$p.value,
      interpretation = ifelse(
        test$p.value < 0.05,
        "Difference significative entre S1 et S2",
        "Aucune difference significative"
      )
    )
  }

  return(list(
    comparaison_moyennes = comparaison,
    progression_regression = progression_regression,
    tests_statistiques = tests_stats
  ))
}
