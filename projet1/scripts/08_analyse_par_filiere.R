# Analyse par filiere

analyse_par_filiere <- function(df) {

  # Verification que la filiere est bien un facteur
  df$filiere <- as.factor(df$filiere)

  # Statistiques descriptives 
  stats_descriptives <- df |>
    dplyr::group_by(filiere) |>
    dplyr::summarise(
      effectif = dplyr::n(),
      moyenne_s1 = mean(moyenne_s1, na.rm = TRUE),
      moyenne_s2 = mean(moyenne_s2, na.rm = TRUE),
      ecart_type_s1 = sd(moyenne_s1, na.rm = TRUE), #TODO verifier na.rm pour ecart_type_s1 et ecart_type_s2 (car il y a des NA)
      ecart_type_s2 = sd(moyenne_s2, na.rm = TRUE)
    )

  # Comparaison des moyennes entre filieres
  analyse_s1 <- aov(moyenne_s1 ~ filiere, data = df)
  analyse_s2 <- aov(moyenne_s2 ~ filiere, data = df)

  comparaison <- list(
    analyse_s1 = summary(analyse_s1),
    analyse_s2 = summary(analyse_s2),
    interpretation = "Si p < 0.05, alors les moyennes diffèrent significativement entre les filières."
  )

  # Identification de la filiere la plus performante

  perf_s1 <- stats_descriptives[which.max(stats_descriptives$moyenne_s1), ]
  perf_s2 <- stats_descriptives[which.max(stats_descriptives$moyenne_s2), ]

  meilleure_filiere <- list(
    meilleur_s1 = perf_s1,
    meilleur_s2 = perf_s2
  )

  # Taux de reussite par filiere, moyenne >= 10
  df$reussi_s1 <- df$moyenne_s1 >= 10
  df$reussi_s2 <- df$moyenne_s2 >= 10

  taux_reussite <- df |>
    dplyr::group_by(filiere) |>
    dplyr::summarise(
      taux_reussite_s1 = mean(reussi_s1, na.rm = TRUE) * 100,
      taux_reussite_s2 = mean(reussi_s2, na.rm = TRUE) * 100
    )

  return(list(
    statistiques = stats_descriptives,
    comparaison_filiere = comparaison,
    meilleure_filiere = meilleure_filiere,
    taux_reussite = taux_reussite
  ))
}
