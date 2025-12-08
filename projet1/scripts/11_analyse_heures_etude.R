# =====================================================================
# Analyse de l'impact des heures d'étude sur la performance
# =====================================================================

analyse_heures_etude <- function(df) {

  # ----------------------------------------------------------
  # Corrélation heures d'étude / moyenne générale
  # ----------------------------------------------------------
  correlation <- cor(df$heures_etude_semaine, df$moyenne_s2, use = "complete.obs")

  # ----------------------------------------------------------
  # Analyse par tranche d'heures d'étude
  # ----------------------------------------------------------
  # On considere la plage d'heures : faible 5-15h, moyenne 16-25h, élevée 26-40h, très élevée >40h
  df$heures_cat <- cut(
    df$heures_etude_semaine,
    breaks = c(4, 15, 25, 40, Inf),
    labels = c("5-15h", "16-25h", "26-40h", ">40h"),
    right = TRUE
  )

  df$heures_cat <- as.factor(df$heures_cat)

  perfs_par_tranche <- df |>
    dplyr::group_by(heures_cat) |>
    dplyr::summarise(
      effectif = dplyr::n(),
      moyenne_s1 = mean(moyenne_s1, na.rm = TRUE),
      moyenne_s2 = mean(moyenne_s2, na.rm = TRUE),
      evolution = moyenne_s2 - moyenne_s1
    )

  # ----------------------------------------------------------
  # Identification d'un seuil optimal
  # ----------------------------------------------------------
  # On utilise la tranche d'heures avec la meilleure moyenne S2
  seuil_optimal <- perfs_par_tranche$heures_cat[which.max(perfs_par_tranche$moyenne_s2)]


  return(list(
    correlation = correlation,
    perfs_par_tranche = perfs_par_tranche,
    seuil_optimal = seuil_optimal
  ))
}
