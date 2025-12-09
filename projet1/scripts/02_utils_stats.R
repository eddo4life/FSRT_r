#  statistiques descriptives (moyenne, médiane, écart-type)
simple_summary <- function(x) {
  list(
    moyenne = mean(x, na.rm = TRUE),
    mediane = median(x, na.rm = TRUE),
    ecart_type = sd(x, na.rm = TRUE)
  )
}

# Comptage et pourcentage
count_percent <- function(x) {
  tab <- table(x)
  pct <- prop.table(tab) * 100
  data.frame(
    categorie = names(tab),
    effectif = as.numeric(tab),
    pourcentage = round(as.numeric(pct), 2)
  )
}

# Sauvegarder les donnees
save_to_csv <- function(data, filename) {
  filepath <- file.path("output", "tables", filename)

  write.csv(data, filepath, row.names = FALSE)
  cat("-- ", filename, " créé\n")
}
