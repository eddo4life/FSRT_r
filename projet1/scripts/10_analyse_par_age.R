# =====================================================================
# Analyse des performances par categorie d'age
# =====================================================================

analyse_par_age <- function(df) {

  # ----------------------------------------------------------
  # Créer des categories d'age
  # ----------------------------------------------------------
  # Considerant la plage -> jeunes 18-20, moyens 21-23, plus âgés 24-26
  df$age_cat <- cut(
    df$age,
    breaks = c(17, 20, 23, 26),
    labels = c("18-20", "21-23", "24-26"),
    right = TRUE
  )

  df$age_cat <- as.factor(df$age_cat)

  # ----------------------------------------------------------
  # Comparaison globale S1 et S2 par catégorie
  # ----------------------------------------------------------
  performances_globales <- df |>
    dplyr::group_by(age_cat) |>
    dplyr::summarise(
      effectif = dplyr::n(),
      moyenne_s1 = mean(moyenne_s1, na.rm = TRUE),
      moyenne_s2 = mean(moyenne_s2, na.rm = TRUE),
      evolution = moyenne_s2 - moyenne_s1
    )

  # ----------------------------------------------------------
  # Comparaison par matière
  # ----------------------------------------------------------
  matieres <- c("math", "info", "physique", "economie", "anglais")

  perfs_matieres <- lapply(matieres, function(m) {
    s1 <- paste0("note_", m, "_s1")
    s2 <- paste0("note_", m, "_s2")

    df |>
      dplyr::group_by(age_cat) |>
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
