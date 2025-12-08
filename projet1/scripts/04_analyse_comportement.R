interpret_correlation <- function(r) {
  force <- abs(r)
  
  niveau <- if (force < 0.1) {
    "négligeable"
  } else if (force < 0.3) {
    "faible"
  } else if (force < 0.5) {
    "modérée"
  } else {
    "forte"
  }
  
  direction <- if (r > 0) {
    "positive (plus les heures d'étude augmentent, plus les absences augmentent)"
  } else if (r < 0) {
    "négative (plus les heures d'étude augmentent, moins il y a d'absences)"
  } else {
    "nulle"
  }
  
  paste("Corrélation", niveau, "et", direction, ".")
}


analyse_comportement <- function(df) {
  
  # Statistiques heures d'etude
  heures_stats <- simple_summary(df$heures_etude_semaine)
  
  # Statistiques absences S1 et S2
  abs_s1_stats <- simple_summary(df$nb_absences_s1)
  abs_s2_stats <- simple_summary(df$nb_absences_s2)

  # Relation heures d'etude / absences
  cor_s1 <- cor(df$heures_etude_semaine, df$nb_absences_s1, use = "complete.obs")
  cor_s2 <- cor(df$heures_etude_semaine, df$nb_absences_s2, use = "complete.obs")

  relations <- list(
    correlation_heure_abs_s1 = cor_s1,
    interpretation_s1 = interpret_correlation(cor_s1),
    
    correlation_heure_abs_s2 = cor_s2,
    interpretation_s2 = interpret_correlation(cor_s2)
  )
  
  return(list(
    heures_etude = heures_stats,
    absences_s1 = abs_s1_stats,
    absences_s2 = abs_s2_stats,
    relations = relations
  ))
}
