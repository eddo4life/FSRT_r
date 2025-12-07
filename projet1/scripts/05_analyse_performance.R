stat_completes <- function(v) {
  v <- as.numeric(v)
  list(
    min = min(v, na.rm = TRUE),
    max = max(v, na.rm = TRUE),
    moyenne = mean(v, na.rm = TRUE),
    mediane = median(v, na.rm = TRUE),
    ecart_type = sd(v, na.rm = TRUE)
  )
}

analyse_performance <- function(df) {
  
  # Statistiques par matière S1 et S2
  matieres_s1 <- grep("note_.*_s1$", names(df), value = TRUE)
  matieres_s2 <- grep("note_.*_s2$", names(df), value = TRUE)
  
  stats_s1 <- lapply(df[matieres_s1], stat_completes)
  stats_s2 <- lapply(df[matieres_s2], stat_completes)
  
  # Distribution moyennes S1 & S2
  moyennes_s1 <- stat_completes(df$moyenne_s1)
  moyennes_s2 <- stat_completes(df$moyenne_s2)
  
  # Taux de réussite global
  reussite_s1 <- mean(df$moyenne_s1 >= 10, na.rm = TRUE)
  reussite_s2 <- mean(df$moyenne_s2 >= 10, na.rm = TRUE)
  
  taux_reussite <- list(
    reussite_s1 = reussite_s1,
    reussite_s2 = reussite_s2
  )
  
  # Matières les plus difficiles
  # - On considère la difficulté = moyenne la plus basse
  # - Et une variabilité élevée (écart-type)
  
  mat_s1_diff <- sapply(stats_s1, function(x) x$moyenne)
  mat_s2_diff <- sapply(stats_s2, function(x) x$moyenne)
  
  matiere_difficile_s1 <- names(which.min(mat_s1_diff))
  matiere_difficile_s2 <- names(which.min(mat_s2_diff))
  
  difficile <- list(
    s1 = list(
      matiere = matiere_difficile_s1,
      stats = stats_s1[[matiere_difficile_s1]]
    ),
    s2 = list(
      matiere = matiere_difficile_s2,
      stats = stats_s2[[matiere_difficile_s2]]
    )
  )
  
  return(list(
    stats_matieres_s1 = stats_s1,
    stats_matieres_s2 = stats_s2,
    distribution_moyennes = list(s1 = moyennes_s1, s2 = moyennes_s2),
    taux_reussite = taux_reussite,
    matieres_difficiles = difficile
  ))
}
