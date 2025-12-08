# =====================================================================
# Analyse des performances par genre (H/F)
# =====================================================================

analyse_par_genre <- function(df) {

  df$genre <- as.factor(df$genre)

  # ----------------------------------------------------------
  # Comparaison globale S1 et S2
  # ----------------------------------------------------------
  performances_globales <- df |>
    dplyr::group_by(genre) |>
    dplyr::summarise(
      effectif = dplyr::n(),
      moyenne_s1 = mean(moyenne_s1, na.rm = TRUE),
      moyenne_s2 = mean(moyenne_s2, na.rm = TRUE),
      evolution = moyenne_s2 - moyenne_s1
    )

  # ----------------------------------------------------------
  # Comparaison par matiere
  # ----------------------------------------------------------
  matieres <- c("math", "info", "physique", "economie", "anglais")

  perfs_matieres <- lapply(matieres, function(m) {
    s1 <- paste0("note_", m, "_s1")
    s2 <- paste0("note_", m, "_s2")

    df |>
      dplyr::group_by(genre) |>
      dplyr::summarise(
        moyenne_s1 = mean(.data[[s1]], na.rm = TRUE),
        moyenne_s2 = mean(.data[[s2]], na.rm = TRUE),
        evolution = moyenne_s2 - moyenne_s1
      )
  })
  names(perfs_matieres) <- matieres


  return(list(
    global = performances_globales,
    matieres = perfs_matieres
  ))
}
